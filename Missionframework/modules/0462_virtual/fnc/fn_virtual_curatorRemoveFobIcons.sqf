/*
    KPLIB_fnc_virtual_curatorRemoveFobIcons

    File: fn_virtual_curatorRemoveFobIcons.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2018-11-27
    Last Update: 2021-05-20 10:51:25
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Removes FOBs icons from curator.

    Parameter(s):
        _curator    - Curator logic [OBJECT, defaults to objNull]

    Returns:
        FOB icons were removed [BOOL]
 */

params [
    ["_curator", objNull, [objNull]]
];

if (isNull _curator) exitWith { false; };

private _fobIcons = _curator getVariable ["KPLIB_fobIcons", []];

// Remove all icons from curator
{ [_curator, _x] call BIS_fnc_removeCuratorIcon; } forEach _fobIcons;

_curator setVariable ["KPLIB_fobIcons", []];

true;
