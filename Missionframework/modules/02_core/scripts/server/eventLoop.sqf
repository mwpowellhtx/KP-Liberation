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
    // Get fobs as positions
    // TODO: TBD: except if I read the usage correctly, it is not "as positions" but rather as "marker name"...
    // TODO: TBD: also depending on when in the lifecycle we see this relative to the init module...
    private _startbases = if (isNil "KPLIB_init_startbases") then {[]} else {KPLIB_init_startbases};
    _fobs = _startbases apply {_x select 2};
    _fobs append KPLIB_sectors_fobs;
};

// Create PFH for fob event
[
    {
        private _currentPlayer = _players select _tick;
        // Increment the counter
        _tick = _tick + 1;

        private _emptyFob = "";
        private _playerFob = _emptyFob;

        {
            // Check if player is in any of the FOBs, or not, i.e. empty.
            if (_currentPlayer inArea [getMarkerPos _x, KPLIB_param_fobRange, KPLIB_param_fobRange, 0, false]) exitWith {
                _playerFob = _x;
            };
        } forEach _fobs;

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
