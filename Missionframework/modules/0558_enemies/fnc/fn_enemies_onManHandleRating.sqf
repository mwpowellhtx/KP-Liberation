#include "script_component.hpp"
/*
    KPLIB_fnc_enemies_onManHandleRating

    File: fn_enemies_onManHandleRating.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-10 20:31:26
    Last Update: 2021-06-14 17:17:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        MAN HANDLE RATING event handler.

    Parameter(s):
        _target - [OBJECT, default: objNull]
        _rating - [SCALAR, default: 0]

    Returns:
        The filtered RATING [SCALAR]

    References:
        https://community.bistudio.com/wiki/Arma_3:_Event_Handlers#HandleRating
 */

params [
    [Q(_target), objNull, [objNull]]
    , [Q(_rating), 0, [0]]
];

// switch (side _target) do {
//     case KPLIB_preset_sideF: {};
//     case KPLIB_preset_sideE: {};
//     case KPLIB_preset_sideC: {};
//     case KPLIB_preset_sideR: {};
//     case default {};
// };

// TODO: TBD: we may want to be smarter about this, i.e. allowing for "true" friendly fire, i.e. blufor:blufor, optof:opfor
// TODO: TBD: whereas not so much, blufor:opfor, allowing for friendliness ratings
(0 max _rating);
