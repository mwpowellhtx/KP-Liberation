/*
    KPLIB_fnc_common_isClass

    File: fn_common_isClass.sqf
    Author: Michael W. Powell
    Created: 2021-05-05 22:07:13
    Last Update: 2021-05-05 22:07:16
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether the TARGET NAME is indeed a CLASS.

    Parameter(s):
        _targetName - a TARGET NAME under consideration [STRING, default: ""]
        _config - a CONFIG from which to decide [CONFIG, default: configNull]

    Returns:
        Whether the TARGET NAME is indeed a CLASS [BOOL]
*/

params [
    ["_targetName", "", [""]]
    , ["_config", configFile, [configNull]]
];

if (_targetName isEqualTo "" || isNull _config) exitWith {
    false;
};

private _index = ["CfgVehicles", "CfgWeapons", "CfgMagazines", "CfgAmmo"] findIf {
    isClass (_config >> _x >> _targetName);
};

_index >= 0;
