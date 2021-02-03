/*
    KPLIB_fnc_eden_selectWithFlightDeck

    File: fn_eden_selectWithFlightDeck.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 11:42:32
    Last Update: 2021-01-28 11:42:34
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Selects the Eden bits within range of the asset with `KPLIB_eden_flightDeckProxy` designation.

    Parameters:
        _asset - The asset informing the startbase selection algorithm [OBJECT, default: objNull]
        _range - The range around which to select the startbase proxies [SCALAR, default: KPLIB_param_assetMoveRange]

    Returns:
        The selected Eden bits within range of the asset, with 'KPLIB_eden_flightDeckProxy' designation [ARRAY]

    Remarks:
        At this level we do not care whether there actually is a 'KPLIB_eden_flightDeckProxy' object.
        We just want the Eden bits selected that are within range and eligibility.
*/

params [
    ["_asset", objNull, [objNull]]
    , ["_range", KPLIB_param_assetMoveRange, [0]]
];

private _onWithFlightDeck = {
    params ["_target", "_dist2d", "_eden"];
    private _proxy = missionNamespace getVariable (_eden#0);
    _dist2d <= _range
    && (_proxy getVariable ["KPLIB_eden_flightDeckProxy", ""] != "")
};

// Identify the Eden bits near the asset, and which support flight deck proxies
[_asset, _onWithFlightDeck] call KPLIB_fnc_eden_select;
