/*
    KPLIB_fnc_common_vehicleBoundingBox

    File: fn_common_vehicleBoundingBox.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-10 15:35:41
    Last Update: 2021-06-14 16:38:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns a fully CACHED VEHICLE BOUNDING BOX corresponding to the CLASS NAME.

        Depends on a mission file 'KPLIB_common_bbrCache' clutter cutter object being
        created as a proxy, should be placed in an unobtrusive location on the map. Usually
        this can simply be placed in proximity to the slotted units the mission shall support.

        Assumes that CLASS NAME is at a least valid vehicle class which may be created.

    Parameter(s):
        _className - the CLASS NAME being created [STRING, default: '']
        _pos - optional POSITION at which to consider the proxy [POSITION, default: getPos KPLIB_eden_createVehicle]

    Returns:
        BOUNDING BOX for the OBJECT corresponding to the CLASS NAME [BOUNDING BOX]

    References:
        https://community.bistudio.com/wiki/createVehicleLocal
        https://community.bistudio.com/wiki/boundingBoxReal
        https://community.bistudio.com/wiki/deleteVehicle
        https://community.bistudio.com/wiki/File:Boundingbox.jpg
 */

params [
    ["_className", "", [""]]
    , ["_pos", getPos KPLIB_eden_createVehicle, [[]]]
];

if (isNil {KPLIB_common_bbrCache}) then {
    KPLIB_common_bbrCache = createHashMap;
};

private _bbrCurrent = KPLIB_common_bbrCache get _className;

if (!isNil {_bbrCurrent}) exitWith {
    _bbrCurrent;
};

private _object = _className createVehicleLocal _pos;
private _bbr = 3 boundingBoxReal _object;

deleteVehicle _object;

KPLIB_common_bbrCache set [_className, _bbr];

_bbr;
