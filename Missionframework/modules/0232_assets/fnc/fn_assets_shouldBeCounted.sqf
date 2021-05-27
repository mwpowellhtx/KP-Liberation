#include "script_component.hpp"
/*
    KPLIB_fnc_assets_shouldBeCounted

    File: fn_assets_shouldBeCounted.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-25 23:28:26
    Last Update: 2021-05-25 23:28:28
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Unlike its PERSISTENCE cousin, we do not care about MOMENTUM, nor do we care
        about CREW, when it comes to accounting for ASSETS. Besides not being NULL and
        is ALIVE, the two most important criteria are whether the asset was CAPTURED,
        or whether the asset was BUILT at an FOB. START BASE assets are to be ignored
        during this count, on the one hand; similarly, although beyond the scope of this
        module, should neither be persistent.

        For purposes of their accounting in perpetuity, we do not care about things such
        as MOMENTUM, nor do we care about their immediate proximity, or not, to an FOB.
        If they are alive and operating anywhere, they are still counted.

    Parameter(s):
        _asset - an ASSET OBJECT to consider [OBJECT, default: objNull]

    Returns:
        Whether the ASSET shall be counted [BOOL]
 */

params [
    [Q(_asset), objNull, [objNull]]
];

[
    isNull _asset
    , alive _asset
    , _asset getVariable [Q(KPLIB_fobs_fobUuid), ""]
    , _asset getVariable [Q(KPLIB_captured), false]
] params [
    Q(_null)
    , Q(_alive)
    , Q(_fobUuid)
    , Q(_captured)
];

!_null
    && _alive
    && (_captured || !(_fobUuid isEqualTo ""))
    ;
