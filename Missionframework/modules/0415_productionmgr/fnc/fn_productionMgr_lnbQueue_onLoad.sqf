#include "..\ui\defines.hpp"
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
        https://community.bistudio.com/wiki/lnbSetValue
*/

params [
    ["_lnbQueue", controlNull, [controlNull]]
];

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

// TODO: TBD: perchance to notification_system ...
systemChat "fn_productionMgr_lnbQueue_onLoad";

private _dim = 16;

private _queueData = [
    [["", toUpper localize "STR_KPLIB_PRODUCTION_CAPABILITY_SUPPLY"], 0]
    , [["", toUpper localize "STR_KPLIB_PRODUCTION_CAPABILITY_AMMO"], 1]
    , [["", toUpper localize "STR_KPLIB_PRODUCTION_CAPABILITY_FUEL"], 2]
];

// https://community.bistudio.com/wiki/Structured_Text#Image
// TODO: TBD: will need to adjust the row height to have a measured effect on the set pictures...
// https://community.bistudio.com/wiki/lnbSetPicture
private _someData = +[
    _queueData#0
    , _queueData#1
    , _queueData#2
    , _queueData#0
    , _queueData#1
    , _queueData#2
    , _queueData#0
    , _queueData#2
];

// TODO: TBD: refactor some of these rendering bits to common functions in the prodmgr UI module...
private _columns = ["_enqueued"];
private _onRenderColumn = { toUpper (_x splitString "" select [1, count _x - 1] joinString ""); };

private _headerIndex = _lnbQueue lnbAddRow ([""] + (_columns apply _onRenderColumn));

_lnbStatus lnbSetValue [[_headerIndex, 0], -1];

// TODO: TBD: from compiled summary...
// https://community.bistudio.com/wiki/lnbAddRow
{
    private _rowIndex = _lnbQueue lnbAddRow (_x#0);
    private _resourceIndex = (_x#1);

    _lnbQueue lnbSetPicture [[_rowIndex, 0], KPLIB_productionMgr_resourceImages select _resourceIndex];

    // For use when coordinating production resource management
    _lnbStatus lnbSetValue [[_rowIndex, 0], _resourceIndex];

} forEach _someData;
