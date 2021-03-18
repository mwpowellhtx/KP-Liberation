/*
    KPLIB_fnc_productionMgr_getAdditionalDataOrValue

    File: fn_productionMgr_getAdditionalDataOrValue.sqf
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
        _dataOrValueDefault - used to inform how to get the corresponding data or value

    Returns:
        The data or value corresponding to the '_rowIndex' [BOOL]
*/

params [
    ["_lnb", controlNull, [controlNull]]
    , ["_rowIndex", 0, [0]]
    , "_dataOrValueDefault"
];

if (!(isNil "_dataOrValueDefault")) then {

    private _retval = _dataOrValueDefault;

    switch (typeName _dataOrValueDefault) do {
        case "STRING": {
            _retval = _lnb lnbData [_rowIndex, 0];
        };
        case "SCALAR": {
            _retval = _lnb lnbValue [_rowIndex, 0];
        };
    };

    if (!isNil "_retval") exitWith {
        _retval;
    };
};
