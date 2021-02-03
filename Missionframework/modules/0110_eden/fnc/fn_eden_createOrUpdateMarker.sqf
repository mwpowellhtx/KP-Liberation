/*
    KPLIB_fnc_eden_createOrUpdateMarkers

    File: fn_eden_createOrUpdateMarkers.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 12:17:00
    Last Update: 2021-01-28 12:17:02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates or updates the markers associated with the given Eden sector tuple.

    Parameters:
        _eden - an Eden sector tuple
            [
                ["_markerName", "_markerText", "_varName", "_pos"]
                , ["_sectorType", "_side", "_est", "_uuid"]
            ]

    Reference:
        https://community.bistudio.com/wiki/createMarker
        https://community.bistudio.com/wiki/setMarkerType
        https://community.bistudio.com/wiki/setMarkerColor
        https://community.bistudio.com/wiki/Arma_3:_CfgMarkerColors
*/

// TODO: TBD: could also be a refresh... given "sector tuple" ...
// TODO: TBD: with transformation function...
// TODO: TBD: would need to also provide a default set of tangential options, i.e. marker type, color, etc...
// TODO: TBD: hold that thought, we may come back to it...

// There is no direct reference to 'KPLIB_sectors_edens' here, but there should be/
params [
    ["_eden", [], [[]], 2]
];

_eden params [
    ["_ident", [], [[]], 4]
    , ["_info", [], [[]], 4]
];

// This is a key use case motivating a more sensible restructuring of the sectors tuple shape.
_ident params [
    ["_markerName", "", [""]]
    , ["_markerText", "", [""]]
    , ["_varName", "", [""]]
    , ["_pos", KPLIB_zeroPos, [[]], 3]
];

// Can only create a marker one time.
if ({_x isEqualTo _markerName} count allMapMarkers == 0) then {
    createMarker [_markerName, _pos];
};

{
    _x params ["_onCurrent", "_onVerify", "_onCallback"];

    if (!((_markerName call _onCurrent) call _onVerify)) then {
        _markerName call _onCallback;
    };
} forEach [
    [
        {markerPos _this}
        , {_this isEqualTo _pos}
        , {_this setMarkerPos _pos}
    ]
    , [
        {markerType _this}
        , {_this isEqualTo KPLIB_eden_markerType}
        , {_this setMarkerType KPLIB_eden_markerType}
    ]
    , [
        {markerText _this}
        , {_this isEqualTo _markerText}
        , {_this setMarkerText _markerText}
    ]
    , [
        {markerColor _this}
        , {_this isEqualTo KPLIB_preset_colorF}
        , {_this setMarkerColor KPLIB_preset_colorF}
    ]
];

_eden
