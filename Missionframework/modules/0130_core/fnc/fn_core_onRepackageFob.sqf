/*
    KPLIB_fnc_core_onRepackageFob

    File: fn_core_onRepackageFob.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-12 18:06:44
    Last Update: 22021-03-12 18:06:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Repackages the FOB near the target location to either BOX or TRUCK.

    Parameters:
        _target - the reference object near which to repackage the FOB [OBJECT, default: player]
        _className - the desired form factor into which to repackage [STRING, default: KPLIB_preset_fobBoxF]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_target", player, [objNull]]
    , ["_caller", objNull, [objNull]]
    , ["_actionId", 0, [0]]
    , ["_args", [], [[]]]
];

_args params [
    ["_className", "", [""]]
];

//private _repackageCost = +KPLIB_resources_storageValueDefault;

systemChat format ["[fn_core_repackageFob] Repackaging: '%1'", _className];

// TODO: TBD: which, itself, may also be a single item build sequence...
// TODO: TBD: not dissimilar with the production storage build sequence...

true;
