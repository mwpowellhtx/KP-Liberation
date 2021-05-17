#include "script_component.hpp"
/*
    KPLIB_fnc_resources_checkCrate

    File: fn_resources_checkCrate.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-15
    Last Update: 2021-05-05 22:29:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Displays the amount of resources inside a given crate as hint.

    Parameter(s):
        _crate - Resource crate to check [OBJECT, defaults to objNull]

    Returns:
        Function reached the end [BOOL]
 */

params [
    [Q(_crate), objNull, [objNull]]
];

// Get the specific resource type string
private _resource = switch (typeOf _crate) do {
    case KPLIB_preset_crateSupplyE;
    case KPLIB_preset_crateSupplyF: {
        Q(STR_KPLIB_SUPPLIES);
    };
    case KPLIB_preset_crateAmmoE;
    case KPLIB_preset_crateAmmoF: {
        Q(STR_KPLIB_AMMO);
    };
    case KPLIB_preset_crateFuelE;
    case KPLIB_preset_crateFuelF: {
        Q(STR_KPLIB_FUEL);
    };
};

// TODO: TBD: hint? or actually show a notification?
// TODO: TBD: plus we could actually use the hint API...
// Display hint
hint format [localize Q(STR_KPLIB_HINT_RESCRATECONTENT)
    , _crate getVariable [QMVAR(_crateValue), 0], localize _resource
];

[{ hintSilent ""; }, [], 3] call CBA_fnc_waitAndExecute;

true;
