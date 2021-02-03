/*
    KPLIB_fnc_config_getPresetSettingValue

    File: fn_config_getPresetSettingValue.sqf
    Author: Michael W. Powell [22nd MEU SOD]
    Created: 2021-01-29 09:14:41
    Last Update: 2021-01-29 09:14:44
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns a presets setting value specification.

    Parameter(s):
        _count - the number of preset specs being requested [SCALAR, default: 0]
        _prefix - the prefix used to identify each of the presets [STRING, default ""]
        _selectedIndex - the default preset value being selected [SCALAR, default: 0]

    Returns:
        Function reached the end [BOOL]
*/

params [
    ["_count", 0, [0]]
    , ["_prefix", "", [""]]
    , ["_selectedIndex", 0, [0]]
];

// Caps the _selectedIndex given _count.
_selectedIndex = _selectedIndex max (_count - 1);

// TODO: TBD: we are unclear what the precise verbiage should be...
// TODO: TBD: street names and corner cases could change at a moment's notice...
// TODO: TBD: research the CBA combo box, we think, for a clue what the verbiage might be...

private _values = [];

for [{}, {_count > 0}, {_count = _count - 1}] do {
    private _presetIndex = count _values;
    private _presetDisplayName = format ["%1%2", _prefix, _presetIndex];
    _values pushBack [_presetIndex, _presetDisplayName];
};

[
    _values apply {_x#0}
    , _values apply {_x#1}
    , _selectedIndex
]
