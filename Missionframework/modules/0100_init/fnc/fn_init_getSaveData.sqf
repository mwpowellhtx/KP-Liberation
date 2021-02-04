/*
    KPLIB_fnc_init_getSaveData

    File: fn_init_getSaveData.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-10-07
    Last Update: 2021-02-03 11:44:55
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Retrieves the datum associated by the _tag associative key. Returns the data
        as-is, or an empty array when the associate _tag could not be found.

    Parameter(s):
        _tag - Associative key corresponding to the global saved datum element [STRING, default: ""]

    Returns:
        Save datum element corresponding to the _tag associative key [ANY, default: ARRAY]
*/

params [
    ["_tag", "", [""]]
];

private _i = KPLIB_save_data findIf {(_x#0) isEqualTo _tag};

if (_i isEqualTo -1) exitWith {[]};

(KPLIB_save_data select _i) select 1;
