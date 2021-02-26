/*
    KPLIB_fnc_logistics_onTransportRecycle

    File: fn_logistics_onTransportRecycle.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 21:59:08
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Recycles one of the transports from the '_targetUuid' CBA logistics namespace.

    Parameters:
        _targetUuid - the target UUID of the CBA logistics namespace to recycle transport [STRING, default: ""]

    Returns:
        Whether the request was successful [BOOL]
 */

params [
    ["_targetUuid", "", [""]]
];

private _namespace = [_targetUuid] call KPLIB_fnc_logistics_getNamespaceByUuid;

if (isNull _namespace) exitWith {
    // TODO: TBD: add some logging...
    false;
};

private _transportValues = _namespace getVariable ["KPLIB_logistics_transportValues", []];
private _transportValueCount = count _transportValues;

if (_transportValueCount > 0) then {
    private _deletedValues = _transportValues deleteAt (_transportValueCount - 1);
    // TODO: TBD: also credit the nearest FOB with the recycle value...
    // TODO: TBD: not having enough or choose the nearest FOB with sufficient space to receive the credit...
    // TODO: TBD: and which should also raise an event to notify managers...
    _namespace setVariable ["KPLIB_logistics_transportValues", _transportValues];
};

// Meaning request successful.
_transportValueCount != count _transportValues;
