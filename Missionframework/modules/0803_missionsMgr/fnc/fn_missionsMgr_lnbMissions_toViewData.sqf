#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_lnbMissions_toViewData

    File: fn_missionsMgr_lnbMissions_toViewData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Transforms the MISSIONS array to a view that is useful to the MISSIONS LISTNBOX/

    Parameter(s):
        _missions - the MISSIONS TUPLES as sent from the server [ARRAY, default: []]

    Returns:
        A transformed set of MISSIONS TUPLES for use with the MISSIONS LISTNBOX [ARRAY]

    Referencs:
        https://community.bistudio.com/wiki/User_Interface_Event_Handlers
        https://community.bistudio.com/wiki/createDialog
 */

params [
    [Q(_missions), [], [[]]]
];

private _toBooleanViewDatum = {
    params [
        [Q(_value), false, [false]]
        , [Q(_trueText), Q(yes), [""]]
        , [Q(_falseText), Q(no), [""]]
    ];
    if (_value) exitWith { _trueText; };
    _falseText;
};

/*
    // TODO: TBD: at least for now, this is the shape...
    // Should track with the 'fn_missions_onPreInit' file
    MVAR1(_variableNamesToPublish) = +[
        [QMVAR1(_uuid)          , ""                    ]
        , [QMVAR1(_templateUuid), ""                    ]
        , [QMVAR1(_icon)        , ""                    ]
        , [QMVAR1(_title)       , ""                    ]
        , [QMVAR1(_pos)         , KPLIB_zeroPos         ]
        , [QMVAR1(_status)      , MSTATUS1(_standby)    ]
        , [QMVAR1(_timer)       , KPLIB_timers_default  ]
        , [QMVAR1(_briefing)    , MVAR1(_zeroBriefing)  ]
        , [QMVAR1(_imagePath)   , ""                    ]
        , [QMVAR1(_telemetry)   , []                    ]
    ];
*/

private _toMissionViewDatum = {
    params [
        [Q(_mission), [], [[]]]
    ];

    // TEMPLATE UUID unused
    _mission params [
        [Q(_uuid), "", [""]]
        , Q(_1)                                             // _templateUuid - unused
        , [Q(_icon), "", [""]]
        , [Q(_title), "", [""]]
        , [Q(_pos), +KPLIB_zeroPos, [[]], 3]
        , [Q(_status), KPLIB_mission_status_standby, [0]]
        , [Q(_timer), +KPLIB_timers_default, [[]], 4]
    ];

    // TODO: TBD: should have a common function for this...
    private _gridref = [mapGridPosition _pos] call {
        params [
            [Q(_gridref), KPLIB_zeroPosGridref, [""]]
        ];
        if (_gridref isEqualTo KPLIB_zeroPosGridref) exitWith {
            KPLIB_zeroPosGridrefDash;
        };
        _gridref;
    };

    [
        [
            _icon
            , toUpper _title
            , _gridref
            , _timer call KPLIB_fnc_timers_renderComponentString
            // TODO: TBD: this is "all" of the status elements...
            // TODO: TBD: may want to restrict that view...
            , [_status] call KPLIB_fnc_mission_getStatusReport
        ]
        , _uuid
    ];
};

_missions apply { [_x] call _toMissionViewDatum; };
