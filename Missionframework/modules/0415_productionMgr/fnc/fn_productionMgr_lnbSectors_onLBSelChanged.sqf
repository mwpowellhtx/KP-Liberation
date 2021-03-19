#include "..\ui\defines.hpp"
/*
    KPLIB_fnc_productionMgr_lnbSectors_onLBSelChanged

    File: fn_productionMgr_lnbSectors_onLBSelChanged.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-06 12:56:43
    Last Update: 2021-02-06 12:56:45
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Module sectors list box onLBSelChanged event handler.

    Parameter(s):
        _lnbSectors - the list box control [CONTROL]
        _selectedIndex - the selected index [SCALAR, default: -1]

    Returns:
        Module postInit finished [BOOL]

    References:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers#onLBSelChanged
        https://community.bistudio.com/wiki/ctrlMapAnimAdd
        https://community.bistudio.com/wiki/ctrlMapAnimCommit
*/

params [
    ["_lnbSectors", controlNull, [controlNull]]
    , ["_selectedIndex", -1, [0]]
];

// TODO: TBD: may need some error handling around display... production... markername... etc...
private _display = findDisplay KPLIB_IDD_PRODUCTIONMGR;

private _productionState = _display getVariable ["_productionState", []];

if (_selectedIndex < 0 || _productionState isEqualTo []) exitWith {
    false;
};

private _markerName = [_lnbSectors, _selectedIndex, ""] call KPLIB_fnc_productionMgr_getAdditionalDataOrValue;

if (_markerName isEqualTo "") exitWith {
    false;
};

// TODO: TBD: may need to put debugging here...
private _selected = _productionState select { ((_x#0#0) isEqualTo _markerName); };

private _productionElem = (_selected#0);

[(_productionState select _selectedIndex)] call {
    params [
        ["_productionElem", +KPLIB_productionMgr_productionElem_default, [[]], 3]
    ];
    [
        _productionElem call KPLIB_fnc_productionMgr_productionElemViews_onStatus
        , _productionElem call KPLIB_fnc_productionMgr_productionElemViews_onQueue
        , _productionElem call KPLIB_fnc_productionMgr_productionElemViews_onTimeRem
    ];
} params [
    "_statusView"
    , "_queueView"
    , "_timeRemView"
];

{
    _x params [
        ["_idc", 0, [0]]
        , "_view"
        , ["_onLoad", {}, [{}]]
    ];
    private _ctrl = _display displayCtrl _idc;
    private _currentView = _ctrl getVariable ["_view", []];
    if (!(_currentView isEqualTo _view)) then {
        _ctrl setVariable ["_view", _view];
        [_ctrl] spawn _onLoad;
    };
} forEach [
    [
        KPLIB_IDC_PRODUCTIONMGR_LNBSTATUS
        , _statusView
        , KPLIB_fnc_productionMgr_lnbStatus_onLoad
    ]
    , [
        KPLIB_IDC_PRODUCTIONMGR_LNBQUEUE
        , _queueView
        , KPLIB_fnc_productionMgr_lnbQueue_onLoad
    ]
    , [
        KPLIB_IDC_PRODUCTIONMGR_TXTTIMEREM
        , _timeRemView
        , KPLIB_fnc_productionMgr_txtTimeRem_onLoad
    ]
];

// Done, fini; we could get fancier with it, I suppose, but this meets the objective for now.
[_display, _markerName] spawn {
    params [
        ["_display", displayNull, [displayNull]]
        , ["_markerName", "", [""]]
    ];

    private _sectorPos = markerPos _markerName;

    // TODO: TBD: discover nearby storage containers and present them as well...
    // TODO: TBD: because remember we want to sort out the whole building thing...
    // TODO: TBD: we should start with a dedicated storage build sequence first...
    // TODO: TBD: then examine both for consistencies, differences, patterns, etc...
    // TODO: TBD: however, that's not for this sprint...

    private _ctrlMap = _display displayCtrl KPLIB_IDC_PRODUCTIONMGR_CTRLMAP;

    _ctrlMap ctrlMapAnimAdd [0, 0.1, _sectorPos];

    _ctrlMap setVariable ["KPLIB_sector_markerName", _markerName];

    [_ctrlMap] call KPLIB_fnc_productionMgr_ctrlMap_onLoad;

    ctrlMapAnimCommit _ctrlMap;
};
