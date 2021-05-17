/*
    KPLIB_fnc_init_processPresetVar

    File: fn_init_processPresetVar.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-08
    Last Update: 2021-04-17 13:07:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Processes a given preset variable by filtering for missing mods and adding the
        variable to the specific package.

    Parameter(s):
        _variable - Preset variable [STRING, default: ""]
        _suffix - Preset faction suffix [STRING, default: ""]

    Returns:
        The callback has finished [BOOL]
*/

// TODO: TBD: why are we here...
// TODO: TBD: because it is a possible rabbit hole we dive down concerning preset armies...
// TODO: TBD: especially vis-a-vis configured side/armies...
// TODO: TBD: potentially as it relates to garrison sources...
params [
    ["_variable", "", [""]]
    , ["_suffix", "", [""]]
];

if (!isServer) exitWith {
    false;
};

private _presetVariableName = ["KPLIB_preset_", _variable, _suffix] joinString "";

// Get basic variable
private _prstVar = missionNamespace getVariable _presetVariableName;

// Skip if the basic variable is not used or if it's name or alphabet
if (!(
        isNil "_prstVar"
            || _variable isEqualTo "name"
            || _variable isEqualTo "nameC"
            || _variable isEqualTo "nameR"
            || _variable isEqualTo "alphabet"
    )) then {

    switch (true) do {

        // Filter mods arrays
        case (_prstVar isEqualType []): {
            _prstVar = [_prstVar] call KPLIB_fnc_init_filterMods;
        };

        // Check single class name availability
        case (!([_prstVar] call KPLIB_fnc_init_checkClass)): {
            [format ["Check failed: %1", _prstVar], "CHECK CLASS", true] call KPLIB_fnc_common_log;
            KPLIB_validationNamespace setVariable ["KPLIB_preset_checkedSingles", false];
        };
    };

    // Add filtered variable to package
    private _package = missionNamespace getVariable ["KPLIB_preset_package" + _suffix, []];
    _package pushBack [_presetVariableName, _prstVar];
};

true;
