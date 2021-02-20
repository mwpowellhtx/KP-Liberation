/*
    KPLIB_fnc_production_verifyQueue

    File: fn_production_verifyQueue.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-19 19:03:01
    Last Update: 2021-02-19 19:03:06
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether the production '_queue' is considered valid.

    Parameter(s):
        _queue - a candidate queue of potential 'KPLIB_resources_indexes' [ARRAY, default: []]

    Returns:
        Whether the production '_queue' is considered valid [BOOL]
 */

params [
    ["_queue", [], [[]]]
];

[
    _queue isEqualTo []
    , _queue isEqualTo (_queue select { _x in KPLIB_resources_indexes; })
] params [
    "_queueEmpty"
    , "_contentsValid"
];

_queueEmpty || _contentsValid;
