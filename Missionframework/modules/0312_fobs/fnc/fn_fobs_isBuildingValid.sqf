#include "script_component.hpp"
/*
    KPLIB_fnc_fobs_isBuildingValid

    File: fn_fobs_isBuildingValid.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-18 13:41:26
    Last Update: 2021-05-18 13:59:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns whether the FOB BUILDING is valid for purposes of evaluating FOB things.

        Evaluation includes:
            - null: it is not
            - class name: correct
            - FOB index: greater than or equal to zero
            - FOB uuid: it is valid
            - FOB marker name: in all map markers

    Parameter(s):
        _candidate - a CANDIDATE object [OBJECT, default: objNull]

    Returns:
        Whether the CANDIDATE object is a valid FOB BUILDING [BOOL]
 */

params [
    [Q(_candidate), objNull, [objNull]]
];

[
    isNull _candidate
    , typeOf _candidate
    , _candidate getVariable [QMVAR(_fobIndex), -1]
    , _candidate getVariable [QMVAR(_fobUuid), ""]
    , _candidate getVariable [QMVAR(_markerName), ""]
] params [
    Q(_null)
    , Q(_className)
    , Q(_fobIndex)
    , Q(_fobUuid)
    , Q(_markerName)
];

!_null
    && _className isEqualTo KPLIB_preset_fobBuildingF
    && _fobIndex >= 0
    && !(
        (_fobUuid isEqualTo "")
        || (_markerName in allMapMarkers)
    )
    ;
