#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_imgBriefing_toViewData

    File: fn_missionsMgr_imgBriefing_toViewData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:33:58
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Dissects the MISSION TUPLE for its current BRIEFING IMAGE element.

    Parameter(s):
        _mission - a MISSION TUPLE array [ARRAY, default: []]

    Returns:
        The BRIEFING IMAGE element [STRING]
 */

params [
    [Q(_mission), [], [[]]]
];

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

// All but IMAGE PATH are unused
_mission params [
    Q(_0)
    , Q(_1)
    , Q(_2)
    , Q(_3)
    , Q(_4)
    , Q(_5)
    , Q(_6)
    , Q(_7)
    , [Q(_imagePath), "", [""]]
];

_imagePath;
