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

waitUntil {!isNil "KPLIB_campaignRunning"};

// Init function for event loop, executed every time whole list of player was iterated
private _initFunction = {
    // Get all current FOBs
    _players = [] call CBA_fnc_players;
    _tick = 0;
    _playersCount = count _players;
    // FOBs are not gotten as positions, but rather we want the marker names.
    _fobs = +KPLIB_sectors_fobs;
};

// Create PFH for fob event
[
    {
        private _currentPlayer = _players select _tick;
        // Increment the counter
        _tick = _tick + 1;

        private _emptyFob = "";
        private _playerFob = _emptyFob;

        private _fobIndex = -1;

        // TODO: TBD: For now we just want whether the current player within range of a start base area.
        // TODO: TBD: if we need/want anything more specific than that, then we may need to consider options such as creating uuids, etc...
        private _opsIndex = if (isNil "KPLIB_init_startbases") then {-1} else {
            /*
             * Follow what's going on here:
             * 1. Add distance between player and each of the start bases.
             * 2. Work with only those start bases within range of the player.
             * 3. Identify the nearest of those start bases to the player.
             * 4. Identify the appropriate index based on the original array.
             */
             // TODO: TBD: there are probably better ways of going about this and using other A3 primitives...
            private _startbases = KPLIB_init_startbases apply {_x + [(_x select 1) distance2D _currentPlayer]};
            _startbases = _startbases select {(_x select (count _x - 1)) <= KPLIB_param_opsRange};
            private _nearest = [_startbases, {_x select (count _x - 1)}] call KPLIB_fnc_common_min;
            if (isNil "_nearest") then {-1} else {KPLIB_init_startbases find (_nearest select [0, count _nearest - 1])};
        };

	// TODO: TBD: index works to a point, but we think there is logic downstream dealing with player actions...
	// TODO: TBD: might be better if we add some UUID to the mix and uniquely identify where player actually is...
        _currentPlayer setVariable ["KPLIB_opsIndex", _opsIndex, true];
        ["KPLIB_player_ops", [_currentPlayer, _opsIndex]] call CBA_fnc_globalEvent;

        // Rinse and repeat the ops question, more or less.
        // TODO: TBD: we do not care "at which" FOB the player is, only whether he/she is.
        // TODO: TBD: if that changes later, then we can be concerned about that, install uuids, whatever...
        _currentPlayer setVariable ["KPLIB_fob", {
            _currentPlayer distance2D (getMarkerPos _x) <= KPLIB_param_fobRange;
        } count _fobs > 0, true];

        // Set fob variable on player if it has changed
        if (!((_currentPlayer getVariable ["KPLIB_fob", _emptyFob]) isEqualTo _playerFob)) then {
            _currentPlayer setVariable ["KPLIB_fob", _playerFob, true];
            // Emit event
            // TODO: TBD: https://ace3mod.com/wiki/framework/events-framework.html#324-global-event
            ["KPLIB_player_fob", [_currentPlayer, _playerFob]] call CBA_fnc_globalEvent;
        };

        // If we checked whole list, reinitialize the list
        if(_tick >= _playersCount) then {
            [] call (_this getVariable "start");
        };
    }               // Handler
    , 0             // Delay
    , []            // Args
    , _initFunction // Start func
    , {}            // End func
    , {KPLIB_campaignRunning}   // Run condition
    , {}            // End condition
    , ["_players", "_tick", "_playersCount", "_fobs"]   // Privates to serialize between calls
] call CBA_fnc_createPerFrameHandlerObject;
// TODO: TBD: see: https://cbateam.github.io/CBA_A3/docs/files/common/fnc_createPerFrameHandlerObject-sqf.html#CBA_fnc_createPerFrameHandlerObject
