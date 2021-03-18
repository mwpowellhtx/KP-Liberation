/*
    KPLIB_fnc_productionMgr_setAdditionalDataOrValue

    File: fn_productionMgr_setAdditionalDataOrValue.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 13:54:36
    Last Update: 2021-02-10 13:54:39
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Sets the data or value corresponding to the '_rowIndex' and '_dataOrValue' element.

    Parameter(s):
        _lnb - the CT_LISTNBOX control [CONTROL, default: controlNull]
        _rowIndex - the row index [SCALAR, default: 0]
        _dataOrValue - the data or value being set behind the designated '_rowIndex'

    Returns:
        The function has finished [SCALAR, default: 0]
            0 - no error
            -1 - _dataOrValue was nil
            -2 - _dataOrValue typeName conflict

    References:
        https://community.bistudio.com/wiki/lnbSetData
        https://community.bistudio.com/wiki/lnbSetValue
 */

params [
    ["_lnb", controlNull, [controlNull]]
    , ["_rowIndex", 0, [0]]
    , "_dataOrValue"
];

if (isNil "_dataOrValue") exitWith { -1; };

private _retval = 0;

switch (typeName _dataOrValue) do {
    case "STRING": {
        _lnb lnbSetData [[_rowIndex, 0], _dataOrValue];
    };
    case "SCALAR": {
        _lnb lnbSetValue [[_rowIndex, 0], _dataOrValue];
    };
    default {
        _retval = -2;
    };
};

_retval;
