#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_lnbStatus_onLoad

    File: fn_productionMgr_lnbStatus_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:56:43
    Last Update: 2021-02-06 12:56:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Module status list box onLoad event handler.

    Parameter(s):
        _lnbStatus - the list box control [CONTROL]

    Returns:
        Module postInit finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLoad
        https://community.bistudio.com/wiki/lnbSetValue
*/

params [
    ["_lnbStatus", controlNull, [controlNull]]
];

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

// TODO: TBD: perchance to notification_system ...
systemChat "fn_productionMgr_lnbStatus_onLoad";

private _dim = 16;

// https://community.bistudio.com/wiki/Structured_Text#Image
// TODO: TBD: will need to adjust the row height to have a measured effect on the set pictures...
// https://community.bistudio.com/wiki/lnbSetPicture
private _someData = [
    [["", toUpper localize "STR_KPLIB_PRODUCTION_CAPABILITY_SUPPLY", "yes", "yes", str 1000, str 10], 0]
    , [["", toUpper localize "STR_KPLIB_PRODUCTION_CAPABILITY_AMMO", "yes", "yes", str 500, str 5], 1]
    , [["", toUpper localize "STR_KPLIB_PRODUCTION_CAPABILITY_FUEL", "yes", "yes", str 100, str 1], 2]
];

// TODO: TBD: should be refactored on load of the overall dialog... and tucked away as a variable...
private _ticks = "''" splitString "";
private _squareBrackets = "[]" splitString "";

private _columns = ["_resource", "_capability", "_producing", "_total", "_crates"];
private _onRenderColumn = { toUpper (_x splitString "" select [1, count _x - 1] joinString ""); };

//private _onJoiningTicks = { _ticks joinString _x; };
//// TODO: TBD: may be specialized depending on the resource...
//private _tooltip = _squareBrackets joinString (_columns apply _onRenderColumn apply _onJoiningTicks joinString ", ");

private _headerIndex = _lnbStatus lnbAddRow ([""] + (_columns apply _onRenderColumn));

_lnbStatus lnbSetValue [[_headerIndex, 0], -1];

// TODO: TBD: from compiled summary...
// https://community.bistudio.com/wiki/lnbAddRow
{
    private _rowIndex = _lnbStatus lnbAddRow (_x#0);
    private _resourceIndex = (_x#1);

    _lnbStatus lnbSetPicture [[_rowIndex, 0], KPLIB_productionMgr_resourceImages select _resourceIndex];

    // For use when coordinating production resource management
    _lnbStatus lnbSetValue [[_rowIndex, 0], _resourceIndex];

} forEach _someData;
