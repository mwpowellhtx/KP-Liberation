/*
    KPLIB_fnc_init_enableSave

    File: fn_init_enableSave.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Date: 2017-10-16
    Last Update: 2021-05-23 13:16:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Allows moments when SAVE should be ENABLED or DISABLED.

    Parameter(s):
        _enabled - whether to ENABLE or DISABLE the SAVE from happening [BOOL, default: true]

    Returns:
        The function has finished [ARRAY]
*/

params [
    ["_enable", true, [true]]
];

KPLIB_init_saveEnabled = _enable;
publicVariableServer "KPLIB_init_saveEnabled";

_enable;