#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_ieds_onMineSpawned

    File: fn_ieds_onMineSpawned.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-06 21:35:37
    Last Update: 2021-05-07 14:07:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds to the 'KPLIB_vehicle_spawned' event.

    Parameter(s):
        _target - a TARGET object being created [OBJECT, default: objNull]

    Returns:
        The event handler completed [BOOL]
 */

private _debug = MPARAM(_onMineSpawned_debug);

params [
    [Q(_target), objNull, [objNull]]
];

// TODO: TBD: IED may be triggered
// TODO: TBD: may also receive damage
// TODO: TBD: which should also trigger it potentially
if (!(typeOf _target in MPRESET(_mineClassNames))) exitWith {
    true;
};

private _uuid = [] call KPLIB_fnc_uuid_create_string;

if (_debug) then {
    [format ["[fn_ieds_onMineSpawned] Entering: [typeOf _target, _uuid]: %1"
        , str [typeOf _target, _uuid]], "IEDS", true] call KPLIB_fnc_common_log;
};

// // TODO: TBD: since MINES are technically consider "ammo" then primitives like setVariable will not work...
// _target setVariable [QMVAR(_uuid), _uuid, true];

if (_debug) then {
    ["[fn_ieds_onMineSpawned] Fini", "IEDS", true] call KPLIB_fnc_common_log;
};

true;
