/*
    KPLIB_fnc_logistics_areEndpointsEqual

    File: fn_logistics_areEndpointsEqual.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-25 11:58:41
    Last Update: 2021-02-25 15:27:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Returns whether the two endpoints are equal to one another. May evaluate only
        identifying information, or may include the full endpoint, including bill values.

    Parameters:
        _alpha - an ALPHA logistics endpoint tuple shape [ARRAY]
        _bravo - a BRAVO logistics endpoint tuple shape [ARRAY]
        _availableOnly - whether to evaluate endpoints fully or not [BOOL, default: true]

    Returns:
        Whether '_alpha' equals '_bravo', taking into consideration '_availableOnly' [BOOL]
 */

params [
    ["_alpha", [], [[]]]
    , ["_bravo", [], [[]]]
    , ["_availableOnly", true, [true]]
];

if (_availableOnly) exitWith {

    // TODO: TBD: may deserve a first class config function...
    private _onAvailableEndpoint = {
        params [
            ["_pos", +KPLIB_zeroPos, [[]], 3]
            , ["_markerName", "", [""]]
            , ["_baseMarkerText", "", [""]]
        ];

        [
            _pos
            , _markername
            , _baseMarkerText
        ];
    };

    private _alphaAvail = _alpha call _onAvailableEndpoint;
    private _bravoAvail = _bravo call _onAvailableEndpoint;

    // TODO: TBD: do some logging...
    _alphaAvail isEqualTo _bravoAvail;
};

private _onFullEndpoint = {
    params [
        ["_pos", +KPLIB_zeroPos, [[]], 3]
        , ["_markerName", "", [""]]
        , ["_baseMarkerText", "", [""]]
        , ["_billValue", +KPLIB_resources_storageValueDefault, [[]], 3]
    ];

    [
        _pos
        , _markername
        , _baseMarkerText
        , _billValue
    ];
};

private _alphaFull = _alpha call _onFullEndpoint;
private _bravoFull = _bravo call _onFullEndpoint;

// TODO: TBD: ditto logging...
_alphaFull isEqualTo _bravoFull;
