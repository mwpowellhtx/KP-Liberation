/*
    KPLIB_fnc_core_getMobSpawns

    File: fn_core_getMobSpawns.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-10-30
    Last Update: 2021-01-25 14:53:34
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns an array with all mobile spawn objects.

    Parameters:
        NONE

    Returns:
        Mobile spawn objects [ARRAY]
*/

// TODO: TBD: this can potentially be factored into, let's say, a callbacks class...
// TODO: TBD: leverage for this function, also for "fn_core_canBuildFob.sqf"
private _onSelectStartbases = {
    params ["_target", "_startbase"];
    (_startbase select 4) <= KPLIB_param_opsRange;
};

vehicles select {
    private _pos = getPos _x;

    private _deployType = _x getVariable ["KPLIB_deployType", KPLIB_deployType_nil];
    private _startbases = [_x, _onSelectStartbases] call KPLIB_fnc_core_findStartbases;

    alive _x
    && _deployType == KPLIB_deployType_mob
    && count _startbases == 0
    && (
        (surfaceIsWater _pos && _x isKindOf "Ship")
        || !(surfaceIsWater _pos || _x isKindOf "Ship")
    )
    && (_pos select 2) < 5
    /* Remembering also, "speed" positive is FORWARD momentum, whereas negative
     * is BACKWARD momentum. Botton line here is MOMENTUM, in ANY direction. */
    && abs (speed _x) < 5
}
