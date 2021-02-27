/*
    KPLIB_fnc_logisticsMgr_lnbConvoy_onLBSelChanged

    File: fn_logisticsMgr_lnbConvoy_onLBSelChanged.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-27 15:14:45
    Last Update: 2021-02-27 15:14:48
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _lnbConvoy - the logistics convoy LISTNBOX control [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]
 */

params [
    ["_lnbConvoy", controlNull, [controlNull]]
    , "_selectedIndex"
];

// TODO: TBD: fill this gap...
systemChat format ["[fn_logisticsMgr_lnbConvoy_onLBSelChanged] [_selectedIndex]: %1", str [_selectedIndex]];

true;
