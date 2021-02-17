/*
    KPLIB_fnc_persistence_whereAssetMayBeFobPersistent

    File: fn_persistence_whereAssetMayBeFobPersistent.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-16 17:01:02
    Last Update: 2021-02-16 17:01:04
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Screen candidate '_object' on a few simple criteria approaching the persistence question.

    Parameter(s):
        _object - the object being screend for FOB asset persistence [OBJECT, default: objNull]

    Returns:
        Whether '_object' may qualify for FOB persistence [BOOL]

    References:
        https://github.com/mwpowellhtx/KP-Liberation/issues/39
 */

params [
    ["_object", objNull, [objNull]]
];

if (isNull _object) exitWith {
    false;
};

[
    _object isKindOf "Man"
    , _object getVariable ["KPLIB_asset_wasSeized", false]
    , _object getVariable ["KPLIB_fob_originalUuid", ""]
] params [
    "_isMan"
    , "_seized"
    , "_originalUuid"
];

// Screens on a few basic criteria...
!_isMan
    && (
        _seized
        || !(_originalUuid isEqualTo "")
    );
