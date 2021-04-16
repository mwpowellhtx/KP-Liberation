#include "script_component.hpp"
/*
    KPLIB_fnc_sectorsSM_zeroSitrep

    File: fn_sectorsSM_zeroSitrep.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-14 15:24:48
    Last Update: 2021-04-14 15:24:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Clears or zeros the baseline CBA SECTORS state machine object sitrep details.
        These are considered any overarching SECTOR activation sitrep bits that we use
        to make decisions concerning each of the ACTIVATED or ACTIVATING SECTORS.

    Parameter(s):
        _objSM - a CBA SECTORS state machine object [LOCATION, default: locationNull]

    Returns:
        The callback has finished [BOOL]
 */

private _debug = MPARAMSM(_zeroSitrep_debug);

params [
    [Q(_objSM), locationNull, [locationNull]]
];

// Which VALUE may be anything, most commonly, default: 0
{
    _x params [
        [Q(_variableName), "", [""]]
        , [Q(_value), 0, [0]]
    ];
    _objSM setVariable [_variableName, _value];
} forEach [

];


true;
