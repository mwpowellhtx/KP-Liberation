/*
    KPLIB_fnc_common_renderActionTitle

    File: fn_common_renderActionTitle.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-05 10:41:28
    Last Update: 2021-06-14 16:38:20
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        REnders the ACTION TITLE

    Parameter(s):
        _title - a TITLE string, may be a STRING TABLE key, or the simple text;
            either direct or localized text may be a FORMAT STRING [STRING, default: ""]
        _options - an ASSOCIATIVE ARRAY of options [ARRAY, default: []]
            _localize - whether the ACTION ARRAY TITLE should be localized [BOOL, default: true]
            _color - an optional COLOR string, [STRING, default, '']
            _formatArgs - format arguments relayed during the localize [ARRAY, default: []]

    Returns:
        The rendered title [STRING]

    References:
        https://community.bistudio.com/wiki/addAction#Syntax
        https://community.bistudio.com/wiki/getOrDefault
        https://community.bistudio.com/wiki/createHashMapFromArray
 */

params [
    ["_title", "", [""]]
    , ["_options", [], [[]]]
];

private _optionMap = createHashMapFromArray _options;

[
    ["_localize", true]
    , ["_color", ""]
    , ["_formatArgs", []]
] apply { _optionMap getOrDefault _x; } params [
    "_localize"
    , "_color"
    , "_formatArgs"
];

// Optionally LOCALIZE the given TITLE first
if (_localize) then { _title = localize _title; };

// Allow for FORMAT arguments in either case
private _formatted = format ([_title] + _formatArgs);

// Finally allow for COLOR rendering
private _rendered = if (_color == "") then { _formatted; } else {
    [format ["<t color='%1'>", _color], _formatted, "<\t>"] joinString "";
};

_rendered;
