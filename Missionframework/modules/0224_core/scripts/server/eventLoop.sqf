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

// Init function for event loop, executed every time whole list of player was iterated
private _onEventLoopStart = {
    _tick = 0;
    _players = [] call CBA_fnc_players;
    _edens = +KPLIB_sectors_edens;
    _fobs = +KPLIB_sectors_fobs;
    _edenRange = KPLIB_param_edenRange;
    _fobRange = KPLIB_param_fobRange;
};

// Create PFH for fob event
[
    {
        // Allowing for breaks in the set of players...
        private _currentPlayer = _players select (_tick mod (count _players));
        //                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^

        private _default = "";

        private _candidateMarkers = [
            [_currentPlayer, _fobRange, _fobs, _default] call KPLIB_fnc_common_getTargetMarkerIfInRange
            , [_currentPlayer, _edenRange, _edens, _default] call KPLIB_fnc_common_getTargetMarkerIfInRange
        ];

        private _selectedMarkers = _candidateMarkers select { !(_x isEqualTo _default); };

        private _nearestMarker = if (_selectedMarkers isEqualTo []) then { _default; } else {
        // And if in range is still not the case then clear the variable   ^^^^^^^^^
            (_selectedMarkers#0);
        };

        _currentPlayer setVariable ["KPLIB_sector_markerName", _nearestMarker];

        _tick = _tick + 1;

        // When the tick counter rolls over, reset the variables
        if (_tick >= count _players) then {
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
        , "_edens"
        , "_fobs"
        , "_edenRange"
        , "_fobRange"
    ]   
] call CBA_fnc_createPerFrameHandlerObject;
// TODO: TBD: see: https://cbateam.github.io/CBA_A3/docs/files/common/fnc_createPerFrameHandlerObject-sqf.html#CBA_fnc_createPerFrameHandlerObject
