// /*
//     KPLIB_fnc_logisticsMgr_edtResource_onKeyUp

//     File: fn_logisticsMgr_edtResource_onKeyUp.sqf
//     Author: Michael W. Powell [22nd MEU SOC]
//     Created: 2021-02-27 18:29:32
//     Last Update: 2021-02-27 18:29:37
//     License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

//     Description:
//         ...

//     Parameters:
//         _edtResource - the logistics resource CT_EDIT control [CONTROL, default: controlNull]
//         _key -
//         _shift -
//         _ctrl -
//         _alt -

//     Returns:
//         The event handler finished [BOOL]

//     References:
//         https://community.bistudio.com/wiki/ctrlText
//         https://community.bistudio.com/wiki/ctrlSetText
//         https://community.bistudio.com/wiki/parseNumber
//  */

// params [
//     "_edtResource"
//     , "_key"
//     , "_shift"
//     , "_ctrl"
//     , "_alt"
// ];

// private _raw = ctrlText _edtResource;

// private _filtered = str (parseNumber _raw);

// private _argTypeNames = [_edtResource, _key, _shift, _ctrl, _alt] apply { typeName _x; };

// systemChat format ["[fn_logisticsMgr_edtResource_onKeyUp] [_raw, _filtered, _argTypeNames]: %1", str [_raw, _filtered, _argTypeNames]];

// _edtResource ctrlSetText _filtered;

// true;
