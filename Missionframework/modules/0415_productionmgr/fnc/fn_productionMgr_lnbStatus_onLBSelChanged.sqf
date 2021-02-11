#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_lnbStatus_onLBSelChanged

    File: fn_productionMgr_lnbStatus_onLBSelChanged.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:56:43
    Last Update: 2021-02-11 17:32:34
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Module status list box onLBSelChanged event handler.

    Parameter(s):
        _lnbStatus - the list box control [CONTROL]
        _selectedIndex - the selected index [SCALAR, default: -1]

    Returns:
        Module postInit finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLBSelChanged
*/

params [
    ["_lnbStatus", controlNull, [controlNull]]
    , ["_selectedIndex", -1, [0]]
];

/* No-op for the time being.
 * However, we will leave the event handler in place for now. */

true;
