/*
    KPLIB_fnc_eden_createOrUpdateMarkers

    File: fn_eden_createOrUpdateMarkers.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-01-28 12:17:00
    Last Update: 2021-01-28 12:17:02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Creates or updates the markers associated with the given Operations Base tuple.

    Parameters:
        _eden - an Operations Base tuple
            [
                _varName
                , [_uuid, _sysTime]
                , [_sectorType, _pos, _side]
                , [_markerName, _markerText]
            ]

    Reference:
        https://community.bistudio.com/wiki/createMarker
        https://community.bistudio.com/wiki/setMarkerType
        https://community.bistudio.com/wiki/setMarkerColor
        https://community.bistudio.com/wiki/Arma_3:_CfgMarkerColors
*/

//private _dep = [
//    "KPLIB_eden_markerType"
//    , "KPLIB_preset_colorF"
//];

//waitUntil {
//    _dep = _dep select {isNil _x};
//    _dep isEqualTo [];
//};

// TODO: TBD: could also be a refresh... given "sector tuple" ...
// TODO: TBD: with transformation function...
// TODO: TBD: would need to also provide a default set of tangential options, i.e. marker type, color, etc...
// TODO: TBD: hold that thought, we may come back to it...
params [
    ["_eden", [], [[]], 4]
];

/* We should have everything we need by this point. ALl that remains is to follow through with by establishing and/or refreshing the map marker itself. */
_eden params [
    ["_varName", "", [""]]
    , ["_bookkeeping", [], [[]], 2]
    , ["_sector", [], [[]], 3]
    , ["_marker", [], [[]], 2]
];

_sector params [
    ["_sectorType", KPLIB_sectorType_nil, [0]]
    , ["_pos", KPLIB_zeroPos, [[]], 3]
];

_marker params [
    ["_markerName", "", [""]]
    , ["_markerText", "", [""]]
];

// TODO: TBD: we could put some obvious checks in for bits like marker name, etc...

// Can only create a marker one time.
if ({_x isEqualTo _markerName} count allMapMarkers == 0) then {
    createMarker [_markerName, _pos];
};

{
    _x params ["_current", "_verify", "_callback"];

    if (!((_markerName call _current) call _verify)) then {
        _markerName call _callback;
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
