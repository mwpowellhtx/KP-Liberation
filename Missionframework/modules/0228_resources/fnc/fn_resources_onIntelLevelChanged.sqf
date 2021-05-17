#include "script_component.hpp"
/*
    KPLIB_fnc_resources_onIntelLevelChanged

    File: fn_resources_onIntelLevelChanged.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-27 18:19:07
    Last Update: 2021-04-27 18:23:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Applies the INTEL LEVEL to the appropriately mapped INTEL CLASS NAME.

    Parameter(s):
        _variableName - the variable name being changed [STRING, default: ""]
        _value - the setting value [SCALAR, default: 1]

    Returns:
        The event handler has finished [BOOL]
 */

private _debug = MPARAM(_onIntelLevelChanged_debug);

params [
    [Q(_variableName), "", [""]]
    , [Q(_value), 1, [0]]
];

private _intelClassNames = switch (toLower _variableName) do {
    case (toLower QMPARAM(_intelLevelA)): {
        [Q(Land_File1_F), Q(Land_Document_01_F)];
    };
    case (toLower QMPARAM(_intelLevelB)): {
        [Q(Land_MobilePhone_smart_F), Q(Land_SatellitePhone_F)];
    };
    case (toLower QMPARAM(_intelLevelC)): {
        [Q(Land_Tablet_02_F)];
    };
    case (toLower QMPARAM(_intelLevelD)): {
        [Q(Land_Laptop_F), Q(Land_Laptop_device_F), Q(Land_Laptop_unfolded_F)];
    };
    default { []; };
};

{ MPRESET(_intelMap) set [_x, _value]; } forEach _intelClassNames;

true;
