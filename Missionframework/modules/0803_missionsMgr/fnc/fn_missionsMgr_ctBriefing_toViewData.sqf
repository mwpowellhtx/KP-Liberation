#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    KPLIB_fnc_missionsMgr_ctBriefing_toViewData

    File: fn_missionsMgr_ctBriefing_toViewData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-21 20:57:24
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Dissects the MISSION TUPLE for its current BRIEFING CONTROL TABLE elements.

    Parameter(s):
        _mission - a MISSION TUPLE array [ARRAY, default: []]

    Returns:
        The BRIEFING CONTROL TABLE view dat [ARRAY]
 */

params [
    [Q(_mission), [], [[]]]
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

// All but BRIEFING are unused
_mission params [
    Q(_0)
    , Q(_1)
    , Q(_2)
    , Q(_3)
    , Q(_4)
    , Q(_5)
    , Q(_6)
    , [Q(_briefing), ["", "", ""], [[]], 3]
];

// We just need the three part briefing itself
_briefing;
