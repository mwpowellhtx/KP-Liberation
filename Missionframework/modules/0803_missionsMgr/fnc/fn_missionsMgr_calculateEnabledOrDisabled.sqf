#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_calculateEnabledOrDisabled

    File: fn_missionsMgr_calculateEnabledOrDisabled.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Reads the data backing the selected item from the MISSIONS LISTNBOX.

    Parameter(s):
        _lnbMissions - The MISSIONS LISTNBOX control which contains the data [CONTROL, default: controlNull]
        _index - The selected index of the MISSIONS LISTNBOX [SCALAR, default: 0]

    Returns:
        Data backing the MISSIONS LISTNBOX selected row [STRING]
 */

private _toDisable = [];

[uiNamespace, [
    [QMVAR(_lnbMissions), controlNull]
    , [QMVAR(_selectedMission), []]
]] params [
    Q(_lnbMissions)
    , Q(_selectedMission)
];

// TODO: TBD: do we really need to know anything else from the tuple?
_selectedMission params [
    [Q(_uuid), "", [""]]
    , [Q(_templateUuid), "", [""]]
];

[
    _uuid isEqualTo ""
] params [
    Q(_template)
];

private _onAddDisabled = {
    params [
        [Q(_idcs), [], [[]]]
        , [Q(_predicate), { false; }, [{}]]
    ];
    if ([] call _predicate) exitWith {
        { _toDisable pushBackUnique _x; } forEach _idcs;
        true;
    };
    false;
};

// "Not" a TEMPLATE meaning it is a RUNNING MISSION
[MVAR(_abortIdcs), { _template; }] call _onAddDisabled;
[MVAR(_runIdcs), { !_template; }] call _onAddDisabled;

// Default assumes enable everything unless otherwise instructed
private _allIdcs = +MVAR(_allIdcs);

[
    (_allIdcs - _toDisable)
    , _toDisable
];
