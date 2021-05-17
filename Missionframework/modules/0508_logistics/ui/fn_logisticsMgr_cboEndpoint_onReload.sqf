/*
    KPLIB_fnc_logisticsMgr_cboEndpoint_onReload

    File: fn_logisticsMgr_cboEndpoint_onReload.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-01 19:53:08
    Last Update: 2021-03-15 01:16:32
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns the ENDPOINT tuple corresponding to the '_cboEndpoint' selection.

    Parameters:
        _cboEndpoint - the logistics ENDPOINT CT_COMBO control [CONTROL, default: controlNull]

    Returns:
        The ENDPOINT tuple corresponding to the '_cboEndpoint' control [ENDPOINT]

    References:
        https://community.bistudio.com/wiki/lbAdd
        https://community.bistudio.com/wiki/lnbSetData
 */

private _debug = [
    [
        {KPLIB_logisticsMgr_cboEndpoint_onReload_debug}
    ]
] call KPLIB_fnc_logisticsMgr_debug;

params [
    ["_cboEndpoint", controlNull, [controlNull]]
];

private _eps = uiNamespace getVariable ["KPLIB_logisticsMgr_endpoints", []];
private _abandonedEps = uiNamespace getVariable ["KPLIB_logisticsMgr_abandonedEps", []];
private _abandonedStatusReport = [KPLIB_logistics_status_abandoned] call KPLIB_fnc_logistics_getStatusReport;

// TODO: TBD: do we need to watch for server published values?
// TODO: TBD: or better yet request for them...
private _allEps = _eps + _abandonedEps;
//private _fobs = +KPLIB_sectors_fobs;

if (_debug) then {
    [format ["[fn_logisticsMgr_cboEndpoint_onReload] Entering: [isNull _cboEndpoint, count _eps, count _abandonedEps]: %1"
        , str [isNull _cboEndpoint, count _eps, count _abandonedEps]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

if (isNull _cboEndpoint) exitWith {
    false;
};

private _curSelData = [lbCurSel _cboEndpoint] call {
    params ["_curSel"];
    private _data = if (_curSel < 0) then { ""; } else {
        _cboEndpoint lbData _curSel;
    };
    [_curSel, _data];
};

lbClear _cboEndpoint;

private _mapGridPosChars = (mapGridPosition KPLIB_zeroPos) splitString "";
private _unSelMapGridPos = (_mapGridPosChars apply { "-"; }) joinString "";

// TODO: TBD: may also render FACTORY ENDPOINTS including their resources...
// Allowing for edge cases, including active ENDPOINT, as well as a zero UNSELECTED tuple
private _onAddEndpoint = {
    params [
        ["_pos", +KPLIB_zeroPos, [[]], 3]
        , ["_markerName", "", [""]]
        , ["_baseMarkerText", "", [""]]
        , ["_billValue", +KPLIB_resources_storageValueDefault, [[]], 3]
        , ["_mapGridPos", "", [""]]
    ];
    // _billValue - unused, in keeping with operational ENDPOINT tuples
    [
        _markerName in KPLIB_sectors_factory
        , _markerName in KPLIB_sectors_blufor
        , _markerName in allMapMarkers          // Which is to say, assuming "not" an FOB
    ] params [
        "_factory"
        , "_blufor"
        , "_isMarker"
    ];
    if (_mapGridPos isEqualTo "") then {
        _mapGridPos = mapGridPosition _pos;
    };
    // TODO: TBD: may use string table format...
    // Unless that ENDPOINT has been lost or ABANDONED
    private _text = switch (true) do {
        case ((_factory && _blufor) || _isMarker);
        case (_mapGridPos isEqualTo _unSelMapGridPos): {
            format ["%1 - %2", _mapGridPos, _baseMarkerText];
        };
        case ((_factory && !_blufor) || !_isMarker);
        default {
            format ["%1 - %2 [%3]", _mapGridPos, _baseMarkerText, _abandonedStatusReport];
        };
    };
    private _rowIndex = _cboEndpoint lbAdd _text;
    _cboEndpoint lbSetData [_rowIndex, _markerName];
    true;
};

private _unselected = [_unSelMapGridPos] call {
    params ["_mapGridPos"];
    // Identify the maximum ENDPOINT according to its _baseMarkerText length
    private _max = [_allEps, {count (_this#0#3)}] call KPLIB_fnc_linq_max;
    _max params [
        "_0"
        , "_1"
        , "_baseTemplateText"
    ];
    private _baseTemplateChars = _baseTemplateText splitString "";
    [
        nil                                                     // _pos
        , ""                                                    // _markerName
        , (_baseTemplateChars apply { "-"; }) joinString ""     // _baseMarkerText
        , nil                                                   // _billValue
        , _mapGridPos                                           // _mapGridPos
    ];
};

// Including the UNSELECTED zero entry
_unselected call _onAddEndpoint;
{ _x call _onAddEndpoint; } forEach _allEps;

// TODO: TBD: could introduce a "selectbydata" ...
private _epIndex = _allEps findIf { ((_x#1) isEqualTo (_curSelData#1)); };
//                     _markerName:   ^^^^

// Only re-select when the index was actually different
if (_epIndex >= 0 && _epIndex != (_curSelData#0)) then {
    _cboEndpoint lbSetCurSel (_epIndex + 1);
};

if (_debug) then {
    [format ["[fn_logisticsMgr_cboEndpoint_onReload] Fini: [count _eps, count _abandonedEps]: %1"
        , str [count _eps, count _abandonedEps]], "LOGISTICSMGR", true] call KPLIB_fnc_common_log;
};

true;
