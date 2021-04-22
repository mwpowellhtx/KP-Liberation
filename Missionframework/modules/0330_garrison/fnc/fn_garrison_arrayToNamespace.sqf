#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_arrayToNamespace

    File: fn_garrison_arrayToNamespace.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-16 16:27:15
    Last Update: 2021-04-16 16:27:18
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Converts the TUPLE ARRAY to a CBA GARRISON namespace.

    Parameter(s):
        _markerName - a SECTOR marker name [STRING, default: ""]
        _side - a SIDE or an index to a side [SCALAR|SIDE, default: _defaultSide]
        _grpCount - the group count [SCALAR, default: 0]
        _unitCount - the unit count [SCALAR, default: 0]
        _lightAssetClassNames - an array of LIGHT VEHICLE class names [ARRAY, default: []]
        _heavyAssetClassNames - an array of HEAVY VEHICLE class names [ARRAY, default: []]

    Returns:
        A CBA namespace corresponding to the TUPLE [LOCATION]
 */

private _defaultSide = (MPRESET(_sides)#0);

params [
    [Q(_markerName), "", [""]]
    , [Q(_side), _defaultSide, [0, sideEmpty]]
    , [Q(_grpCount), 0, [0]]
    , [Q(_unitCount), 0, [0]]
    , [Q(_lightAssetClassNames), [], [[]]]
    , [Q(_heavyAssetClassNames), [], [[]]]
];

// Normalize side to SIDE type
if (_side isEqualType 0) then {
    _side = MPRESET(_sides) select _side;
};

// Building upon the SECTORS module with GARRISON specific API
private _namespace = KPLIB_sectors_namespaces get _markerName;

{ _namespace setVariable _x; } forEach [
    [QMVAR(_side), _side]
    , [QMVAR(_grpCount), _grpCount]
    , [QMVAR(_unitCount), _unitCount]
    , [QMVAR(_lightAssetClassNames), _lightAssetClassNames]
    , [QMVAR(_heavyAssetClassNames), _heavyAssetClassNames]
    , [QMVAR(_iedClassNames), _iedClassNames]
];

_namespace;
