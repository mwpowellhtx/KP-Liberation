#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"
/*
    KPLIB_fnc_eden_setupAssetActions

    File: fn_eden_setupAssetActions.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-20 22:36:12
    Last Update: 2021-05-21 12:43:11
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sets up the module ASSET actions.

    Parameter(s):
        _vehicle - a VEHICLE which was created [OBJECT, defaults to objNull]

    Returns:
        The event handler has finished [BOOL]
 */

params [
    [Q(_vehicle), objNull, [objNull]]
];

// TODO: TBD: consider, "on create callbacks" ...
// TODO: TBD: better yet, class-based initializers...
// TODO: TBD: possibly also requiring managers/FSMs for new join players, proxmity objects, i.e. add actions on the fly...
switch (typeOf _vehicle) do {
    case KPLIB_preset_addRotaryLightF: {

        // TODO: TBD: startbases / https://github.com/mwpowellhtx/KP-Liberation/issues/2
        // TODO: TBD: rotary flight decks / https://github.com/mwpowellhtx/KP-Liberation/issues/6

        // TODO: TBD: could look at things like range as well (?)
        // TODO: TBD: we think there are still considerations concerning whether flight deck actually clear as part of the conditions...
        // TODO: TBD: colors could be defined as first class config variables
        [
            _vehicle
            , [
                "STR_KPLIB_ACTION_ASSETMOVE"
                , { _this call KPLIB_fnc_eden_assetToFlightDeck; }
                , []
                , KPLIB_ACTION_PRIORITY_ASSETMOVE
                , true
                , true
                , ""
                , "
                    [KPLIB_sectors_startbases, { ((missionNamespace getVariable _x) getVariable ['KPLIB_eden_flightDeckProxy', '']) != ''; }] call KPLIB_fnc_linq_any
                "
                , MPARAM(_assetMoveRange)
            ]
            , [[Q(_color), "#FF8000"]]
        ] call KPLIB_fnc_common_addAction;
    };
};

true;
