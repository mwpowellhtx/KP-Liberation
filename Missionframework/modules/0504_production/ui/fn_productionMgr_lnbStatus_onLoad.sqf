#include "defines.hpp"
/*
    KPLIB_fnc_productionMgr_lnbStatus_onLoad

    File: fn_productionMgr_lnbStatus_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:56:43
    Last Update: 2021-02-06 12:56:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Module status list box onLoad event handler. Assumes that the _view has been
        determined and set on the _lnbStatus control itself by the time we see this event.

    Parameter(s):
        _lnbStatus - the list box control [CONTROL]

    Returns:
        Module event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/lnbAddRow
        https://community.bistudio.com/wiki/lnbSetPicture
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

if (_debug) then {
    ["[fn_productionMgr_lnbStatus_onLoad] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

params [
    ["_lnbStatus", controlNull, [controlNull]]
];

lnbClear _lnbStatus;

// Assumes view is ready and waiting on the control itself
private _view = _lnbStatus getVariable ["_view", []];

// TODO: TBD: could be refactored on load of the overall dialog... and tucked away as a variable...
private _columns = ["_resource", "_capability", "_producing", "_total", "_crates"];
private _onRenderColumn = { toUpper (_x splitString "" select [1, count _x - 1] joinString ""); };

// Show at least the header row
private _headerIndex = _lnbStatus lnbAddRow ([""] + (_columns apply _onRenderColumn));
[_lnbStatus, _headerIndex, -1] call KPLIB_fnc_productionMgr_setAdditionalDataOrValue;

if (!(_view isEqualTo [])) then {
    {
        _x params [
            ["_viewData", [], [[]]]
            , ["_resourceIndex", 0, [0]]
        ];

        private _rowIndex = _lnbStatus lnbAddRow _viewData;

        _lnbStatus lnbSetPicture [[_rowIndex, 0], (KPLIB_resources_imagePaths select _resourceIndex)];

        // For use when coordinating production resource management
        [_lnbStatus, _rowIndex, _resourceIndex] call KPLIB_fnc_productionMgr_setAdditionalDataOrValue;

    } forEach _view;
};

if (_debug) then {
    [format ["[fn_productionMgr_lnbStatus_onLoad] Finished: [_view]: %1"
        , str [_view]], "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
