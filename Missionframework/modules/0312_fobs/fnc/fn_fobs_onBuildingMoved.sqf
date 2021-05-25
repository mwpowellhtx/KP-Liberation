#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_fobs_onBuildingMoved

    File: fn_fobs_onBuildingMoved.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-19 12:26:52
    Last Update: 2021-05-19 12:26:55
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Refreshes aspects of the module objects, FOB BUILDING, when move is validated.

    Parameter(s):
        _object - the OBJECT that was just moved [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_object), objNull, [objNull]]
];

// TODO: TBD: should mark as "cannot recycle" ...
// TODO: TBD: virtually any other object potentially 'could' recycle...
switch (typeOf _object) do {
    case KPLIB_preset_fobBuildingF: {

        private _fobBuilding = _object;

        // There is nothing to resequence, but we do need to UPDATE MARKERS
        [] call MFUNC(_onUpdateMarkers);

        // Also moving the FOB BUILDING potentially changes the SAVE composition
        ["fn_fobs_onBuildingMoved"] spawn KPLIB_fnc_init_save;
    };
};

true;
