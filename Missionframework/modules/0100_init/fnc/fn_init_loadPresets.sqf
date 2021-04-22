/*
    KPLIB_fnc_init_loadPresets

    File: fn_init_loadPresets.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2017-10-16
    Last Update: 2021-04-17 13:34:23
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Loads the configured preset files, checks if classnames are available with current
        modset and initialize global arrays which are dependent on the presets. Distributes
        the cleaned arrays to the clients.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]

    Remarks:
        Still not sure about this whole publicVariable method in the preset initialization.
        Idea was that the server will first initialize all vital stuff and distribute it to
        the clients. This would avoid that clients check all arrays for mods, etc, to ensure
        equity, validity, etc, in these arrays. As it would catch errors if a client has for
        example RHS loaded but not the server, "due to verifySignatures 0", for example.
*/

// TODO: TBD: we should consider mapping these during init phases...
// TODO: TBD: then also potentially reporting whether the preset has compiled and is 'ready'
// Load friendly (player side) preset
switch (KPLIB_param_presetF) do {
    case 0: {[true] call compile preprocessFileLineNumbers "presets\armies\customEast.sqf";};
    case 1: {[true] call compile preprocessFileLineNumbers "presets\armies\csat.sqf";};
    case 2: {[true] call compile preprocessFileLineNumbers "presets\armies\customWest.sqf";};
    case 3: {[true] call compile preprocessFileLineNumbers "presets\armies\nato.sqf";};
    default {[true] call compile preprocessFileLineNumbers "presets\armies\customWest.sqf";};
};

// Load enemy preset
switch (KPLIB_param_presetE) do {
    case 0: {[] call compile preprocessFileLineNumbers "presets\armies\customEast.sqf";};
    case 1: {[] call compile preprocessFileLineNumbers "presets\armies\csat.sqf";};
    case 2: {[] call compile preprocessFileLineNumbers "presets\armies\customWest.sqf";};
    case 3: {[] call compile preprocessFileLineNumbers "presets\armies\nato.sqf";};
    default {[] call compile preprocessFileLineNumbers "presets\armies\customEast.sqf";};
};

// Load resistance preset
switch (KPLIB_param_presetR) do {
    case 0: {[] call compile preprocessFileLineNumbers "presets\resistance\custom.sqf";};
    case 1: {[] call compile preprocessFileLineNumbers "presets\resistance\fia.sqf";};
    default {[] call compile preprocessFileLineNumbers "presets\resistance\custom.sqf";};
};

// Load civilian preset
switch (KPLIB_param_presetC) do {
    case 0: {[] call compile preprocessFileLineNumbers "presets\civilians\custom.sqf";};
    case 1: {[] call compile preprocessFileLineNumbers "presets\civilians\vanilla.sqf";};
    default {[] call compile preprocessFileLineNumbers "presets\civilians\custom.sqf";};
};

// TODO: TBD: why does alphabet need to be any different?
// Prepare preset packages, refactored with highly leveraged meta data
private _packageSpecs = [
    ["F", ["KPLIB_preset_name", "KPLIB_preset_alphabet"]]
    , ["E", ["KPLIB_preset_name", "KPLIB_preset_alphabet"]]
    , ["R", ["KPLIB_preset_name"]]
    , ["C", ["KPLIB_preset_name"]]
];
// We will also refer to the SUFFIXES in order to process
private _suffixes = _packageSpecs apply { (_x#0); };

{
    _x params [
        ["_suffix", "", [""]]
        , ["_variableNames", [], [[]]]
    ];

    private _package = _variableNames apply {
        [_x + _suffix, missionNamespace getVariable _x + _suffix];
    };

    private _packageKey = "KPLIB_preset_package" + _suffix;

    missionNamespace setVariable [_packageKey, _package];

} forEach _packageSpecs;

{
    // Process all preset variables
    private _suffix = _x;

    {
        private _variableName = _x;
        [_variableName, _suffix] call KPLIB_fnc_init_processPresetVar;
    } forEach KPLIB_preset_allVariables;

} forEach _suffixes;

// Pack all preset packages and publish them to the clients
KPLIB_preset_allData = _suffixes apply {
    missionNamespace getVariable ("KPLIB_preset_package" + _x);
};

// TODO: TBD: let's figure out whether this is necessary...
publicVariable "KPLIB_preset_allData";

true;
