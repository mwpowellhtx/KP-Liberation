#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_getViewDatum

    File: fn_hudFob_getViewDatum.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-26 09:47:52
    Last Update: 2021-05-26 12:31:47
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Renders the REPORT RECORD represented by the OPTIONS. Does this entirely lifting
        meta bits from the REPORT conveyed through the OPTIONS associative array.

    Parameters:
        _player - the PLAYER object [OBJECT, default: player]
        _report - a CBA REPORT namespace [LOCATION, default: locationNull]
        _options - an associative array of OPTIONS [ARRAY, default: []]
            [
                _varNames - an ARRAY of variable names whose corresponding values constitute the record [ARRAY, default: []]
                _formatString - a format string pertaining to the VALUES [STRING, default: '%1']
                _render - callback to be used on the overall VALUES array [CODE, default: KPLIB_fnc_hudFob_renderSimple]
                _suffix - an optional SUFFIX to be appended to the rendered result [STRING, default: '']
                _imagePath - an IMAGE PATH related to the rendered REPORT FIELD [STRING, default: '']
            ]

    Returns:
        A tuple representing a VIEW DATUM corresponding to the resolved OPTIONS meta details
            [
                _rendered - string representing the rendered REPORT RECORD [STRING, default: '']
                _imagePath - a resource path informing the IMAGE column [STRING, default: '']
                _color - a COLOR string used to set the color for the REPORT RECORD row [STRING, default: '']
            ]

    References:
        https://community.bistudio.com/wiki/createHashMapFromArray
        https://community.bistudio.com/wiki/getOrDefault
 */

private _defaultValues = [0];

params [
    [Q(_player), player, [objNull]]
    , [Q(_report), locationNull, [locationNull]]
    , [Q(_optionsKey), "", [""]]
];

private _debug = MPARAM(_getViewDatum_debug)
    || (_player getVariable [QMVAR(_getViewDatum_debug), false])
    || (_report getVariable [QMVAR(_getViewDatum_debug), false])
    ;

private _options = _report getVariable [_optionsKey, []];
private _optionMap = createHashMapFromArray _options;

[
    _optionMap getOrDefault [Q(_varNames), []]
    , _optionMap getOrDefault [Q(_formatString), MPRESET(_formatStringSimple)]
    , _optionMap getOrDefault [Q(_render), MFUNC(_renderSimple)]
    , _optionMap getOrDefault [Q(_suffix), MPRESET(_suffixNone)]
    , _optionMap getOrDefault [Q(_imagePath), ""]
    , _optionMap getOrDefault [Q(_color), []]
] params [
    Q(_varNames)
    , Q(_formatString)
    , Q(_render)
    , Q(_suffix)
    , Q(_imagePath)
    , Q(_color)
];

// Flatten the VALUES regardless of the shape
_varNames = flatten _varNames;

private _values = _varNames apply { _report getVariable [_x, 0]; };

private _formatArgs = flatten [_formatString, _values call _render];

[[format _formatArgs, _suffix] joinString "", _imagePath, _color];
