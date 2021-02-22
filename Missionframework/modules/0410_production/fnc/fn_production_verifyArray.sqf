/*
    KPLIB_fnc_production_verifyArray

    File: fn_production_verifyArray.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-17 09:00:35
    Last Update: 2021-02-17 09:00:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Verifies that '_this' is in the shape of a production array as expected.

    Parameter(s):
        _productionElem - an SQF production array [ARRAY]

    Returns:
        Whether the array is in a valid form [BOOL]

    References:
        https://community.bistudio.com/wiki/isEqualTo
        https://community.bistudio.com/wiki/isEqualType
        https://community.bistudio.com/wiki/isEqualTypeArray
 */

params [
    ["_productionElem", [], [[]]]
];

// Short circuit verification early, and often, ASAP when we know invalid
if (!(_productionElem isEqualType [])) exitWith {
    false;
};

[
    (_productionElem#0) isEqualTypeArray ["", ""]
    , (_productionElem#1) isEqualTypeArray [0, 0, 0, 0]
    , (_productionElem#2) isEqualTypeArray [[], [], []]
] params [
    "_identValid"
    , "_timerValid"
    , "_infoValid"
];

if (!(_identValid || _timerValid || _infoValid)) exitWith {
    false;
};

[
    (_productionElem#2#0) isEqualTypeArray [false, false, false]
    , (_productionElem#2#1) isEqualTypeArray [0, 0, 0]
    , (_productionElem#2#2) isEqualType []
] params [
    "_capValid"
    , "_storageValueValid"
    , "_queueIsArray"
];

// Dissecting the production tuple one level at a time...
if (!(_capValid || _storageValueValid || _queueIsArray)) exitWith {
    false;
};

private _queue = (_productionElem#2#2);

private _verified = _queue select { (_x in KPLIB_resources_indexes); };

_queue isEqualTo _verified;
