#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_namespaceToArray

    File: fn_garrison_namespaceToArray.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-16 16:28:41
    Last Update: 2021-04-16 16:28:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Converts the CBA GARRISON namespace to a TUPLE ARRAY.

    Parameter(s):
        _namespace - a CBA GARRISON namespace [LOCATION, default: locationNull]

    Returns:
        A CBA namespace corresponding to the TUPLE [LOCATION]
 */

// Building upon the SECTORS module with GARRISON specific API
params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _tupleSpec = [
    [Q(KPLIB_sectors_markerName), ""]
    , [QMVAR(_side), sideEmpty]
    , [QMVAR(_grpCount), 0]
    , [QMVAR(_unitCount), 0]
    , [QMVAR(_lightVehicleClassNames), []]
    , [QMVAR(_heavyVehicleClassNames), []]
];

// This is correct, we want the values themselves, this is a TUPLE we are forming
private _tuple = _tupleSpec apply { _namespace getVariable _x; };

private _sideIndex = 1;

// TODO: TBD: we may get away from this in the future, but for now, it is what it is...
// TODO: TBD: being consistent with the baseline refactor efforts...
private _side = _tuples select _sideIndex;

// Must translate in terms of 'index' for the time being
_tuple set [_sideIndex, MPRESET(_allSides) findIf { _x isEqualTo _side; }];

_tuple;
