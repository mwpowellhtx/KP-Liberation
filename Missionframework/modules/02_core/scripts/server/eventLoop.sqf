/*
    KP Liberation server side event loop

    File: eventLoop.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-05-25
    Last Update: 2021-01-25 18:02:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Does periodic checks on players and emits events when necessary
*/

//private _dep = [
//    "KPLIB_campaignRunning"
//    , "KPLIB_sectorType_nil"
//   , "KPLIB_param_edenRange"
//   , "KPLIB_param_fobRange"
//    , "KPLIB_sectors_fobs"
//    , "KPLIB_sectors_edens"
//];

//waitUntil {
//    _dep = _dep select {isNil _x};
//    _dep isEqualTo [];
//};

// Init function for event loop, executed every time whole list of player was iterated
private _onEventLoopStart = {
    _tick = 0;
    _players = [] call CBA_fnc_players;
    _playerCount = count _players;
    // TODO: TBD: we are doing this in at least 3x places... so we really should consider a proper helper for it...
    private _onTransformPfh = {[
        _x select 3 select 0 // Marker -> Marker name
        , _x select 1 select 0 // Bookkeeping -> UUID
        , _x select 2 select 0 // Sector -> Sector type
    ]};
    _edens = KPLIB_sectors_edens apply _onTransformPfh;
    _fobs = KPLIB_sectors_fobs apply _onTransformPfh;
    _edenRange = KPLIB_param_edenRange;
    _fobRange = KPLIB_param_fobRange;
};

// Create PFH for fob event
[
    {
        private _currentPlayer = _players select _tick;
        // Increment the counter
        _tick = _tick + 1;

        private _defaultG = ["", "", KPLIB_sectorType_nil];
        private _defaultArgs = [0, "", "", KPLIB_sectorType_nil];

        private _onAggregateMarkerName = {
            params [
                ["_g", _defaultG, [[]], 3]
                , ["_args", _defaultArgs, [[]], 4]
            ];
            // TODO: TBD: which, if we are transforming here as well, we really might use a to/from transformation util functions...
            _args params [
                ["_range", 0, [0]]
                , ["_markerName", "", [""]]
                , ["_uuid", "", [""]]
                , ["_sectorType", KPLIB_sectorType_nil, [0]]
            ];
            // TODO: TBD: could perhaps have some "min" functionality built in as well...
            if (_g isEqualTo _defaultG && _currentPlayer inArea [getMarkerPos _markerName, _range, _range, 0, false]) then {
                _g = [_markerName, _uuid, _sectorType];
            };
            _g
        };

        /* From the tuples above:
         * 0: Marker -> Marker name
         * 1: Bookkeeping -> UUID
         * 2: Sector -> Sector type
         * Then we sprinkle in FOB or Ops ranges depending on the base array.
         */
        private _actualG = [_defaultG
            , (_fobs apply {[_fobRange] + _x})
                + (_edens apply {[_edenRange] + _x})
            , _onAggregateMarkerName] call KPLIB_fnc_linq_aggregate;

        private _currentG = [_currentPlayer, nil, _defaultG] call KPLIB_fnc_common_getSectorInfo;

        // Only update and notify when there has been an actual noteworthy change.
        if (!(_actualG isEqualTo _currentG)) then {

            // Shape of the '_sectorInfo' tuple: [_markerName, _sectorUuid, _sectorType]
            _currentPlayer setVariable ["KPLIB_sector_info", _actualG];

            // TODO: TBD: https://ace3mod.com/wiki/framework/events-framework.html#324-global-event
            switch (true) do {
                // TODO: TBD: 'KPLIB_player_fob' should we be raising this event also? ditto 'KPLIB_player_ops'.
                // TODO: TBD: also events throughout this machinary pretty much deal in terms of marker names.
                case (!((_edens select {(_x select 0) isEqualTo (_actualG select 0)}) isEqualTo [])): {
                    ["KPLIB_player_ops", [_currentPlayer, _actualG#0]] call CBA_fnc_globalEvent;
                };
                case (!((_fobs select {(_x select 0) isEqualTo (_actualG select 0)}) isEqualTo [])): {
                    ["KPLIB_player_fob", [_currentPlayer, _actualG#0]] call CBA_fnc_globalEvent;
                };
            };
        };

        // If we checked whole list, reinitialize the list
        if (_tick >= _playerCount) then {
            [] call (_this getVariable "start");
        };
    }                               // Handler
    , 0                             // Delay
    , []                            // Args
    , _onEventLoopStart             // Start func
    , {}                            // End func
    , {KPLIB_campaignRunning}       // Run condition
    // TODO: TBD: we need an end condition? ...
    , {}                            // End condition
    , [ // Privates to serialize between calls
        "_tick"
        , "_players"
        , "_playerCount"
        , "_edens"
        , "_edenRange"
        , "_fobs"
        , "_fobRange"
    ]   
] call CBA_fnc_createPerFrameHandlerObject;
// TODO: TBD: see: https://cbateam.github.io/CBA_A3/docs/files/common/fnc_createPerFrameHandlerObject-sqf.html#CBA_fnc_createPerFrameHandlerObject
