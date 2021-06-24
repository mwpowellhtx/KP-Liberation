#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_fobs_onBuildItemBuilt

    File: fn_fobs_onBuildItemBuilt.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-19 09:36:25
    Last Update: 2021-06-23 13:16:50
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds to server side portion when a build item was built. In the case of this
        module, we are focused on the FOB BUILDING, for starters, and that is perhaps the
        extent of our interest receiving notification for the event.

    Parameter(s):
        _object - the OBJECT that was just built [OBJECT, default: objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_object), objNull, [objNull]]
];

// Ensure that the OBJECT is identified as originating from an FOB
private _fobBuilding = [_object, MPARAM(_range)] call MFUNC(_getNearestBuilding);

// Also, true for ANY non-FOB building object
if (!isNull _fobBuilding && _object isNotEqualTo _fobBuilding) then {
    private _fobUuid = _fobBuilding getVariable [QMVAR(_fobUuid), ""];
    _object setVariable [QMVAR(_fobUuid), _fobUuid, true];
};

switch (typeOf _object) do {

    case KPLIB_preset_fobBuildingF: {

        private _fobBuilding = _object;

        if (!(_fobBuilding in MVAR(_allBuildings))) then {
            private _fobIndex = MVAR(_allBuildings) pushBack _fobBuilding;

            // Resequence then show the notification, also update the sectors
            [MVAR(_allBuildings)] call MFUNC(_resequence);

            private _militaryAlpha = _fobBuilding getVariable [QMVAR(_militaryAlpha), "Unknown"];

            [
                Q(KPLIB_notification_blufor)
                , [
                    "KP LIBERATION - FOB"
                    , MPRESET(_markerPath)
                    , format [localize "STR_KPLIB_FOBS_FOB_EST_FORMAT", _militaryAlpha]
                ]
                , allPlayers
            ] call KPLIB_fnc_notification_show;

            // Remember to SAVE afterwards
            ["fn_fobs_onBuildItemBuilt"] spawn KPLIB_fnc_init_save;
        };
    };
};

true;
