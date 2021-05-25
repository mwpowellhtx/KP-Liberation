/*
    KPLIB_fnc_persistence_makePersistent

    File: fn_persistence_makePersistent.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Date: 2019-03-30
    Last Update: 2021-02-16 18:26:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Adds object to persistence system.

    Parameter(s):
        _object - Object to add to persistence [OBJECT]

    Returns:
        Object was added to persistence [BOOL]
*/
params [
    ["_object", objNull, [objNull]]
];

// Just push them back, uniquely, after all, so as to avoid tearing at the array...
if (_object isKindOf "CAManBase") exitWith {
    KPLIB_persistence_units pushBackUnique _object;
};

KPLIB_persistence_objects pushBackUnique _object;

true;
