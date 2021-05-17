#include "defines.hpp"
/*
    KPLIB_fnc_productionMgr_lnbQueue_onLoad

    File: fn_productionMgr_lnbQueue_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-09 16:38:39
    Last Update: 2021-02-09 16:38:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Module queue list box onLoad event handler.

    Parameter(s):
        _lnbQueue - the list box control [CONTROL]

    Returns:
        Module postInit finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/lnbAddRow
        https://community.bistudio.com/wiki/lnbSetPicture
 */

private _debug = [] call KPLIB_fnc_productionMgr_debug;

if (_debug) then {
    ["[fn_productionMgr_lnbQueue_onLoad] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

params [
    ["_lnbQueue", controlNull, [controlNull]]
];

lnbClear _lnbQueue;

private _view = _lnbQueue getVariable ["_view", []];

// TODO: TBD: refactor some of these rendering bits to common functions in the prodmgr UI module...
private _columns = ["_enqueued"];
private _onRenderColumn = { toUpper (_x splitString "" select [1, count _x - 1] joinString ""); };

private _headerIndex = _lnbQueue lnbAddRow ([""] + (_columns apply _onRenderColumn));
[_lnbQueue, _headerIndex, -1] call KPLIB_fnc_productionMgr_setAdditionalDataOrValue;

if (!(_view isEqualTo [])) then {
    {
        _x params [
            ["_viewData", [], [[]]]
            , ["_resourceIndex", 0, [0]]
        ];

        private _rowIndex = _lnbQueue lnbAddRow _viewData;

        _lnbQueue lnbSetPicture [[_rowIndex, 0], (KPLIB_resources_imagePaths select _resourceIndex)];

        // For use when coordinating production resource management
        [_lnbQueue, _rowIndex, _resourceIndex] call KPLIB_fnc_productionMgr_setAdditionalDataOrValue;

    } forEach _view;
};

if (_debug) then {
    [format ["[fn_productionMgr_lnbQueue_onLoad] Finished: [_view]: %1"
        , str [_view]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
