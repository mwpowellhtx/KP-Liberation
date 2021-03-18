#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_getSelectedQueue

    File: fn_productionMgr_getSelectedQueue.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-11 09:26:30
    Last Update: 2021-02-11 09:26:32
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Lifts the queue from the list KPLIB_IDC_PRODUCTIONMGR_LNBQUEUE CT_LISTNBOX control.

    Parameter(s):
        NONE

    Returns:
        The queue that is currently installed.

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLBSelChanged
        https://community.bistudio.com/wiki/lnbSize
*/

private _queue = [];

private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

if (_display isEqualTo displayNull) exitWith {
    _queue;
};

private _lnbQueue = _display displayCtrl KPLIB_IDC_PRODUCTIONMGR_LNBQUEUE;

if (_lnbQueue isEqualTo controlNull) exitWith {
    _queue;
};

// Because LNB size is obtained as [_rows, _columns]
private _count = ((lnbSize _lnbQueue)#0);

// First row is always an ENQUEUED 'header' row of sorts
while {count _queue < (_count - 1)} do {
    private _resourceIndex = [_lnbQueue, (count _queue) + 1, -1] call KPLIB_fnc_productionMgr_getAdditionalDataOrValue;
    if (_resourceIndex >= 0) then {
        _queue pushBack _resourceIndex;
    };
};

_queue;
