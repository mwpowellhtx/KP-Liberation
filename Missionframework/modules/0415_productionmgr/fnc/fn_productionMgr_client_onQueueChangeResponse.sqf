#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_client_onQueueChangeResponse

    File: fn_productionMgr_client_onQueueChangeResponse.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 21:24:27
    Last Update: 2021-02-10 21:24:30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Client module 'onChangeQueueResponse' event handler, responds to the
        'KPLIB_productionMgr_onQueueChangeResponse' CBA owner event.

    Parameter(s):
        _productionElem - the production element that got updated in response
            to the change request [ARRAY, default: []]

    Returns:
        Event handler finished [BOOL]

    References:
*/

private _debug = [] call KPLIB_fnc_productionMgr_debug;

if (_debug) then {
    ["[fn_productionMgr_client_onQueueChangeResponse] Entering...", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

if (_debug) then {
    ["[fn_productionMgr_client_onQueueChangeResponse] Finished", "PRODUCTIONMGR", true] call KPLIB_fnc_common_log;
};

true;
