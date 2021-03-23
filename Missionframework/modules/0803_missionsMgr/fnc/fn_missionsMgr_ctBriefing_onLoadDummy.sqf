#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_ctBriefing_onLoadDummy

    File: fn_missionsMgr_ctBriefing_onLoadDummy.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-21 16:35:33
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Responds when the BRIEFING CT_CONTROLS_TABLE opens, 'onLoad'.

    Parameter(s):
        _ctBriefing - the BRIEFING CT_CONTROLS_TABLE control opened [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    Referencs:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/createDialog
        https://community.bistudio.com/wiki/CT_CONTROLS_TABLE
 */

params [
    [Q(_ctBriefing), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

// Does what the 'onLoad' event handler should do warming up the control first time
[_ctBriefing, _config] call KPLIB_fnc_missionsMgr_ctBriefing_onLoad;

// Then we load with some dummy data...
private _getSpam = {
    params [
        [Q(_text), "", [""]]
        , [Q(_count), 99, [0]]
    ];
    private _bits = [];
    _bits resize _count;
    _bits apply { _text; } joinString " ";
};

[
    [Q(_overview)] call _getSpam
    , [Q(_success)] call _getSpam
    , [Q(_failure)] call _getSpam
] params [
    Q(_overview)
    , Q(_success)
    , Q(_failure)
];

["", "", "", ""] params [
    Q(_uuid)
    , Q(_templateUuid)
    , Q(_icon)
    , Q(_title)
];

/*
    // TODO: TBD: at least for now, this is the shape...
    // Should track with the 'fn_missions_onPreInit' file
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
        , [QMVAR(_telemetry)    , []                    ]
    ];
*/

// For purposes of dummy data...
private _mission = +[
    _uuid
    , _templateUuid
    , _icon
    , _title
    , KPLIB_zeroPos
    , KPLIB_mission_status_standby
    , KPLIB_timers_default
    , [_overview, _success, _failure]
];

private _viewData = [_mission] call MFUNC(_ctBriefing_toViewData);

_ctBriefing setVariable [QMVAR(_viewData), _viewData];

[_ctBriefing] call MFUNC(_ctBriefing_onRefresh);

true;
