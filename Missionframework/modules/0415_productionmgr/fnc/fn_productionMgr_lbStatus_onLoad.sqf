#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_lbStatus_onLoad

    File: fn_productionMgr_lbStatus_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:56:43
    Last Update: 2021-02-06 12:56:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Module lbStatus onLoad event handler.

    Parameter(s):
        _lbStatus - the list box control [CONTROL]

    Returns:
        Module postInit finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
*/

params [
    ["_lbStatus", controlNull, [controlNull]]
];

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

// TODO: TBD: perchance to notification_system ...
systemChat "fn_productionMgr_lbStatus_onLoad";

private _dim = 16;

// https://community.bistudio.com/wiki/Structured_Text#Image
// TODO: TBD: will need to adjust the row height to have a measured effect on the set pictures...
// https://community.bistudio.com/wiki/lnbSetPicture
private _someData = [
    [["", toUpper localize "STR_KPLIB_PRODUCTION_CAPABILITY_SUPPLY", "yes", "yes", str 1000, str 10], "res\ui_supplies.paa"]
    , [["", toUpper localize "STR_KPLIB_PRODUCTION_CAPABILITY_AMMO", "yes", "yes", str 500, str 5], "res\ui_ammo.paa"]
    , [["", toUpper localize "STR_KPLIB_PRODUCTION_CAPABILITY_FUEL", "yes", "yes", str 100, str 1], "res\ui_fuel.paa"]
];

// TODO: TBD: should be refactored on load of the overall dialog... and tucked away as a variable...
private _ticks = "''" splitString "";
private _squareBrackets = "[]" splitString "";

private _columns = ["_resource", "_capability", "_producing", "_total", "_crates"];
private _onRenderColumn = { toUpper (_x splitString "" select [1, count _x - 1] joinString ""); };

//private _onJoiningTicks = { _ticks joinString _x; };
//// TODO: TBD: may be specialized depending on the resource...
//private _tooltip = _squareBrackets joinString (_columns apply _onRenderColumn apply _onJoiningTicks joinString ", ");

_lbStatus lnbAddRow ([""] + (_columns apply _onRenderColumn));

// TODO: TBD: from compiled summary...
// https://community.bistudio.com/wiki/lnbAddRow
{
    private _rowIndex = _lbStatus lnbAddRow (_x#0);
    _lbStatus lnbSetPicture [[_rowIndex, 0], (_x#1)];

    // https://community.bistudio.com/wiki/lnbSetTooltip

    //// TODO: TBD: tooltips indicating which resource it is
    //_lbStatus lnbSetTooltip [[_rowIndex, 0], _tooltip];

} forEach _someData;
