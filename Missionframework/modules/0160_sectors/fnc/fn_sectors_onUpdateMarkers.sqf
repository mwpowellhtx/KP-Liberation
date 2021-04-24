#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onUpdateMarkers

    File: fn_sectors_onUpdateMarkers.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-10-27
    Last Update: 2021-04-24 11:11:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Updates general sector marker colors and create locked vehicle markers. Marker
        coloration addresses the following matrix involving BLUFOR, OPFOR, ACTIVE, and
        INACTIVE markers. Also included are 'locked' build sectors.

                              BLUFOR                   OPFOR
                    ╔════════════════════════╤════════════════════════╗
             ACTIVE ║ KPLIB_preset_colorActF │ KPLIB_preset_colorActE ║
                    ╟────────────────────────┼────────────────────────╢
           INACTIVE ║ KPLIB_preset_colorF    │ KPLIB_preset_colorE    ║
                    ╚════════════════════════╧════════════════════════╝

        Coloration is basically a default, dim OPFOR or BLUFOR color for INACTIVE sectors,
        as opposed to a brighter RED or BLUE color for ACTIVE sectors, respectively.

    Parameter(s):
        NONE

    Returns:
        The event handler has finished [BOOL]

    References:
        https://community.bistudio.com/wiki/markerShape
        https://community.bistudio.com/wiki/setMarkerShape
        https://community.bistudio.com/wiki/Category:Arma_3:_Scripting_Commands
        https://www.unicode.org/charts/PDF/U2500.pdf
        https://en.wikipedia.org/wiki/Box_Drawing_(Unicode_block)
        https://en.wikipedia.org/wiki/List_of_Unicode_characters
 */

private _debug = MPARAM(_onUpdateMarkers_debug);

if (_debug) then {
    ["[fn_sectors_onUpdateMarkers] Entering", "SECTORS", true] call KPLIB_fnc_common_log;
};

// Identify INACTIVE SECTORS
private _inactiveSectors = MVAR(_all) - MVAR(_active);
// These are not 'literal' vehicle objects, but rather the build blueprints
private _lockedVehicleMarkers = +(MVAR(_lockedVehMarkers));

// Then identify ACTIVE+INACTIVE, OPFOR+BLUFOR SECTORS, respectively
private _activeOpforSectors = MVAR(_active) - MVAR(_blufor);
private _activeBluforSectors = MVAR(_active) - _activeOpforSectors;
private _inactiveOpforSectors = _inactiveSectors - MVAR(_blufor);
private _inactiveBluforSectors = _inactiveSectors - _inactiveOpforSectors;

if (_debug) then {

    [format ["[fn_sectors_onUpdateMarkers] Sectors: [count _activeOpforSectors, count _activeBluforSectors, count _inactiveOpforSectors, count _inactiveBluforSectors]: %1"
        , str [count _activeOpforSectors, count _activeBluforSectors, count _inactiveOpforSectors, count _inactiveBluforSectors]], "SECTORS", true] call KPLIB_fnc_common_log;

    [format ["[fn_sectors_onUpdateMarkers] Sectors: [_activeOpforSectors, _activeBluforSectors, _inactiveOpforSectors, _inactiveBluforSectors]: %1"
        , str [_activeOpforSectors, _activeBluforSectors, _inactiveOpforSectors, _inactiveBluforSectors]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: could probably consolidate 'locked' vehicle bits to a common API area...
private _viewLockedMarkerName = { (_this#0); };
private _viewLockedAssociatedName = { (_this#1); };

// Identify 'locked' build specs across ACTIVE+INACTIVE, OPFOR+BLUFOR sectors
private _lockedMarkerNames = [
    _activeOpforSectors
    , _activeBluforSectors
    , _inactiveOpforSectors
    , _inactiveBluforSectors
] apply {
    private _sectors = _x;
    private _locked = _lockedVehicleMarkers select {
        (_x call _viewLockedAssociatedName) in _sectors;
    };
    _locked apply { _x call _viewLockedMarkerName; };
};

_lockedMarkerNames params [
    Q(_activeOpforLocked)
    , Q(_activeBluforLocked)
    , Q(_inactiveOpforLocked)
    , Q(_inactiveBluforLocked)
];

if (_debug) then {

    [format ["[fn_sectors_onUpdateMarkers] Locked: [count _activeOpforLocked, count _activeBluforLocked, count _inactiveOpforLocked, count _inactiveBluforLocked]: %1"
        , str [count _activeOpforLocked, count _activeBluforLocked, count _inactiveOpforLocked, count _inactiveBluforLocked]], "SECTORS", true] call KPLIB_fnc_common_log;

    [format ["[fn_sectors_onUpdateMarkers] Locked: [_activeOpforLocked, _activeBluforLocked, _inactiveOpforLocked, _inactiveBluforLocked]: %1"
        , str [_activeOpforLocked, _activeBluforLocked, _inactiveOpforLocked, _inactiveBluforLocked]], "SECTORS", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: it is also 'now' when we might also consider introducing circles, etc, concerning activation/capture ranges...
{
    _x params [
        [Q(_markerNames), [], [[]]]
        , [Q(_color), "", ["", []]]
    ];
    { _x setMarkerColor _color; } forEach _markerNames;
} forEach [
    // Change the sector colors themselves, rinse and repeat for the 'locked' build specs
    [_activeOpforSectors + _activeOpforLocked, KPLIB_preset_colorActE]
    , [_activeBluforSectors + _activeBluforLocked, KPLIB_preset_colorActF]
    , [_inactiveOpforSectors + _inactiveOpforLocked, KPLIB_preset_colorE]
    , [_inactiveBluforSectors + _inactiveBluforLocked, KPLIB_preset_colorF]
];

if (_debug) then {
    ["[fn_sectors_onUpdateMarkers] Fini", "SECTORS", true] call KPLIB_fnc_common_log;
};

true;
