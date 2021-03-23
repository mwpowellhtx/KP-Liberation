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

([uiNamespace, [
    [QMVAR(_lnbMissions), controlNull]
    , [QMVAR(_selectedMission), []]
]] call KPLIB_fnc_namespace_getVars) params [
    Q(_lnbMissions)
    , Q(_selectedMission)
];

/*
    MVAR(_variableNamesToPublish) = +[
        [QMVAR(_uuid)           , ""                    ]
        , [QMVAR(_templateUuid) , ""                    ]
        , [QMVAR(_icon)         , ""                    ]
        , [QMVAR(_title)        , ""                    ]
        , [QMVAR(_pos)          , KPLIB_zeroPos         ]
        , [QMVAR(_status)       , MSTATUS(_standby)     ]
        , [QMVAR(_timer)        , KPLIB_timers_default  ]
        , [QMVAR(_briefing)     , MVAR(_zeroBriefing)   ]
        , [QMVAR(_imagePath)    , ""                    ]
    ];
 */

// All but the STATUS are ignored at the moment...
_selectedMission params [
    Q(_0)
    , Q(_1)
    , Q(_2)
    , Q(_3)
    , Q(_4)
    , [Q(_status), KPLIB_mission_status_standby, [0]]
];

[
    [_status] call KPLIB_fnc_missions_checkStatus
    , [_status, KPLIB_mission_status_template] call KPLIB_fnc_missions_checkStatus
    , [_status, KPLIB_mission_status_running] call KPLIB_fnc_missions_checkStatus
] params [
    Q(_standby)
    , Q(_template)
    , Q(_running)
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
[MVAR(_runIdcs), { _running; }] call _onAddDisabled;

// Default assumes enable everything unless otherwise instructed
private _allIdcs = +MVAR(_allIdcs);

[
    (_allIdcs - _toDisable)
    , _toDisable
];
