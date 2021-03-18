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

private _debug = [
    [
        "KPLIB_param_productionMgr_lnbSectors_debug"
    ]
] call KPLIB_fnc_productionMgr_debug;

// TODO: TBD: add storage image to the LNB ...
// configfile >> "CfgVehicles" >> "ContainmentArea_02_sand_F" >> "radarType"
// TODO: TBD: also, could simply indicate whether it has storage, "yes" or "no"
// configfile >> "CfgVehicles" >> "ContainmentArea_02_sand_F" >> "editorPreview" (?) <- a jpg image path

if (_debug) then {
    ["[fn_productionMgr_lnbSectors_onLoad] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

params [
    ["_lnbSectors", controlNull, [controlNull]]
];

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

private _productionState = _display getVariable ["_productionState", []];

if (_debug) then {
    [format ["[fn_productionMgr_lnbSectors_onLoad] [count _productionState]: %1"
        , str [count _productionState]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

// Which allows for cases when we are refreshing the list, leave the selection intact
private _previousIndex = lnbCurSelRow _lnbSectors;

// TODO: TBD: just replace the entire list... might then re-apply the selection as well...
private _view = _productionState apply {
    _x call KPLIB_fnc_productionMgr_productionElemViews_onSector;
};

private _getRowCount = { (lnbSize _lnbSectors) select 0; };

lnbClear _lnbSectors;

{
    _x params [
        ["_rowInfo", ["0", ""], [[]], 2]
        , ["_markerName", "", [""]]
    ];

    private _rowIndex = _forEachIndex;

    _lnbSectors lnbAddRow _rowInfo;

    [_lnbSectors, _rowIndex, _markerName] call KPLIB_fnc_productionMgr_setAdditionalDataOrValue;

} forEach _view;

// Allow the index to be re-selected when necessary, i.e. receiving updates from the server
if (_previousIndex >= 0) then {
    // Taking into account any overages in the new view
    _lnbSectors lnbSetCurSelRow (_previousIndex min (count _view - 1));
};

if (_debug) then {
    [format ["[fn_productionMgr_lnbSectors_onLoad] Finished: [count _productionView]: %1"
        , str [count _view]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
