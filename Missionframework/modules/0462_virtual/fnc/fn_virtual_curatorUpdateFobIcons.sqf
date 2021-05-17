/*
    KPLIB_fnc_virtual_curatorUpdateFobIcons

    File: fn_virtual_curatorUpdateFobIcons.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-11-27
    Last Update: 2021-01-27 21:09:16
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Adds FOBs icons to curator.

    Parameter(s):
        _curator - Curator logic [OBJECT, default: objNull]

    Returns:
        IDs of icons added to curator [ARRAY]
*/

params [
    ["_curator", objNull, [objNull]]
];

if (isNull _curator) exitWith {[]};

// Update FOB icons from curator, if any...
_curator call KPLIB_fnc_virtual_curatorRemoveFobIcons;

// Add FOB icons to curator
private _fobIcons = KPLIB_sectors_fobs apply {
    [(_x#1), (_x#4)] params ["_markerText", "_pos"];
    [
        _curator
        , ["#(argb,8,8,3)color(0,0,0,0)", [1, 1, 1, 1], _pos, 0, 0, 0, _markerText, 2, 0.05]
        , false
        , true
    ] call BIS_fnc_addCuratorIcon
};

_curator setVariable ["KPLIB_fobIcons", _fobIcons];

_fobIcons
