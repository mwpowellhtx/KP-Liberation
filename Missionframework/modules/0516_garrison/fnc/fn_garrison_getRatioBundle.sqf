#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_getRatioBundle

    File: fn_garrison_getRatioBundle.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-04 15:54:08
    Last Update: 2021-06-02 12:03:59
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the RATIOS that will be used to influence caller context, includes
        CIVILIAN REPUTATION, ENEMY STRENGTH, ENEMY AWARENESS, and PLAYER STRENGTH.

    Parameter(s):
        NONE

    Returns:
        A bundle of the ratios [ARRAY]
            [
                _civRepRatio
                , _opforStrengthRatio
                , _opforAwarenessRatio
                , _bluforStrengthRatio
            ]
 */

private _debug = MPARAM(_getRatioBundle_debug);

[
    [] call KPLIB_fnc_enemies_getCivRepRatio
    , [] call KPLIB_fnc_enemies_getStrengthRatio
    , [] call KPLIB_fnc_enemies_getAwarenessRatio
    , [] call KPLIB_fnc_core_getPlayerStrength
] params [
    Q(_civRepRatio)
    , Q(_opforStrengthRatio)
    , Q(_opforAwarenessRatio)
    , Q(_bluforStrengthRatio)
];

if (_debug) then {
    [format ["[fn_garrison_getRatioBundle] Ratios: [_civRepRatio, _opforStrengthRatio, _opforAwarenessRatio, _bluforStrengtRatio]: %1"
        , str [_civRepRatio, _opforStrengthRatio, _opforAwarenessRatio, _bluforStrengtRatio]], "GARRISON", true] call KPLIB_fnc_common_log;
};

[
    _civRepRatio
    , _opforStrengthRatio
    , _opforAwarenessRatio
    , _bluforStrengthRatio
];
