#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_onCapturing

    File: fn_sectorsSM_onCapturing.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-21 20:48:40
    Last Update: 2021-04-25 20:07:46
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Only ever appends potentially ACTIVATING SECTORS to the existing set of ACTIVE SECTORS.
        At most 'KPLIB_param_sectors_maxAct' sectors may be active at any one time.

        We are here because the SECTOR is in a CAPTURING condition. When the corresponding
        TIMER has elapsed, then we may consider the SECTOR CAPTURED to the appropriate side.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/allowGetIn
        https://community.bistudio.com/wiki/unassignVehicle
 */

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _debug = MPARAMSM(_onCapturing_debug)
    || (_namespace getVariable [QMVARSM(_onCapturing_debug), false]);

[
    _namespace getVariable [QMVAR(_markerName), ""]
    , _namespace getVariable [QMVAR(_timer), []]
] params [
    Q(_markerName)
    , Q(_timer)
];

if (_debug) then {
    [format ["[fn_sectorsSM_onCapturing] Entering: [_markerName, markerText _markerName, _timer]: %1"
        , str [_markerName, markerText _markerName, _timer]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

[
    _namespace getVariable [Q(KPLIB_garrison_units), []]
    , _namespace getVariable [Q(KPLIB_garrison_assets), []]
    , [0, 0]
] params [
    Q(_units)
    , Q(_assets)
    , Q(_capturedCounts)
];

private _counts = [_units, _assets] call {
    // Units are not necessarily surrendering but rather signals that CAPTURING has seen the object
    private _whereNotCapturing = { !(_x getVariable [QMVAR(_capturing), false]); };

    private _capturingObjs = _this apply { _x select _whereNotCapturing; };

    // Incrementally renders TARGET object CAPTURING
    private _onCapturing = {
        (_this call BIS_fnc_arrayShuffle) params [
            [Q(_target), objNull, [objNull]]
        ];
        if (!isNull _target) then {
            _target setVariable [QMVAR(_capturing), true];
        };
        _target;
    };

    // Disembark each of the assets
    private _onCapturingAssets = {
        private _target = _this call _onCapturing;
        if (!isNull _target) then {
            private _crew = crew _target;
            { unassignVehicle _x; } forEach _crew;
            _crew allowGetIn false;
        };
        _target;
    };

    // Which assumes [UNITS, ASSETS] ordering
    (_capturingObs#0) call _onCapturing;
    (_capturingObs#1) call _onCapturingAssets;

    _capturingObjs apply { _whereNotCapturing count _x; };
};

[_namespace, MSTATUS(_captured), { _counts isEqualTo _capturedCounts; }, QMVAR(_status)] call KPLIB_fnc_namespace_setStatus;
[_namespace, MSTATUS(_captured), { !(_counts isEqualTo _capturedCounts); }, QMVAR(_status)] call KPLIB_fnc_namespace_unsetStatus;

if (_debug) then {
    [format ["[fn_sectorsSM_onCapturing] Fini: [_markerName, _timer, count _units, count _assets, _counts]: %1"
        , str [_markerName, _timer, count _units, count _assets, _counts]], "SECTORSSM", true] call KPLIB_fnc_common_log;
};

true;
