/*
    KPLIB_fnc_logistics_normalizeEndpoint

    File: fn_logistics_normalizeEndpoint.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-16 10:04:49
    Last Update: 2021-03-16 10:04:51
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Normalizes the ENDPOINT to standard form factor. Optionally includes the
        BILL VALUE, or when determined that the size was four, i.e. inclusive of
        a BILL VALUE.

    Parameters:
        _endpoint - an ENDPOINT array [ARRAY, default: []]

    Returns:
        The ENDPOINT normalized to: [_pos, _markerName, _baseMarkerText, _billValue] [ARRAY]
 */

params [
    ["_endpoint", [], [[]]]
    , ["_includeBillValue", false, [false]]
];

private _epSize = count _endpoint;

_endpoint params [
    ["_pos", +KPLIB_zeroPos, [[]], 3]
    , ["_markerName", "", [""]]
    , ["_baseMarkerText", "", [""]]
];

private _normalized = +[_pos, _markerName, _baseMarkerText];

if (_includeBillValue || (_epSize == 4)) then {
    // Ignoring the first several elements, we just want the BILL VALUE
    _endpoint params [
        "_0"
        , "_1"
        , "_2"
        , ["_billValue", +KPLIB_resources_storageValueDefault, [[]], 3]
    ];

    private _billValueIndex = _normalized pushBack _billValue;
};

_normalized;
