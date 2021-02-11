#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_lnbSectors_onLoad

    File: fn_productionMgr_lnbSectors_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:56:43
    Last Update: 2021-02-09 21:41:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Module sectors list box onLoad event handler.

    Parameter(s):
        _lnbSectors - the list box control [CONTROL]

    Returns:
        Module event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

if (_debug) then {
    ["[fn_productionMgr_lnbSectors_onLoad] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

params [
    ["_lnbSectors", controlNull, [controlNull]]
];

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

private _production = _display getVariable ["_production", []];

if (_debug) then {
    [format ["[fn_productionMgr_lnbSectors_onLoad] [count _production]: %1"
        , str [count _production]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

// Which allows for cases when we are refreshing the list, leave the selection intact
private _previousIndex = lnbCurSelRow _lnbSectors;

lnbClear _lnbSectors;

private _view = _production apply {
    _x call KPLIB_fnc_productionMgr_productionElemViews_onSector;
};

if (!(_view isEqualTo [])) then {
    {
        _x params [
            ["_viewData", [], [[]], 2]
            , ["_markerName", "", [""]]
        ];

        private _rowIndex = _lnbSectors lnbAddRow _viewData;

        [_lnbSectors, _rowIndex, _markerName] call KPLIB_fnc_productionMgr_setAdditionalDataOrValue;

    } forEach _view;
};

// Allow the index to be re-selected when necessary, i.e. receiving updates from the server
if (_previousIndex >= 0) then {
    // Taking into account any overages in the new view
    _lnbSectors lnbSetCurSelRow (_previousIndex min (count _view));
};

if (_debug) then {
    [format ["[fn_productionMgr_lnbSectors_onLoad] Finished: [count _productionView]: %1"
        , str [count _view]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
