#include "script_component.hpp"
/*
    KPLIB_fnc_missionsSM_onMissionsMgrOpened

    File: fn_missionsSM_onMissionsMgrOpened.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 12:49:34
    Last Update: 2021-03-20 12:49:36
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Server module 'onDialogClosed' event handler, responds when the client closes the
        dialog. Which effectively takes the client out of any further notification loops.

    Parameter(s):
        _cid - the clientOwner, A.K.A. '_clientIdentifier', A.K.A. '_cid' for short [SCALAR, default: -1]

    Returns:
        NONE
 */

// TODO: TBD: ditto 'closed' ... review, rinse and repeat for MISSIONS...
private _debug = [
    [
        {MPARAM(_onMissionsMgrOpened_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_cid), -1, [0]]
];

if (_debug) then {
    [format ["[fn_missionsSM_onMissionsMgrOpened] Entering: [_cid]: %1"
        , str [_cid]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
};

private _objSM = [MVAR(_objSM), _cid] call {
    params [
        [Q(_objSM), locationNull, [locationNull]]
        , [Q(_cid), -1, [0]]
    ];

    if (_cid >= 0) then {
        ([_objSM, [
            [QMVAR(_cids), []]
            , [QMVAR(_cidsToPublish), []]
        ]] call KPLIB_fnc_namespace_getVars) params [
            Q(_cids)
            , Q(_cidsToPublish)
        ];

        private _opened = _cids pushBackUnique _cid;

        _cidsToPublish pushBackUnique _cid;

        // There is no 'forced' just receive the manager announcement and await next cycles
        [_objSM, [
            [QMVAR(_cids), _cids]
            , [QMVAR(_cidsToPublish), _cidsToPublish]
        ]] call KPLIB_fnc_namespace_setVars;
    };

    _objSM;
};

// // TODO: TBD: could do this here... or just wait for the state machine to pick it up, which we will do eventually...
// // TODO: TBD: but while we are working out initial client server bits, respond with the list
// And publishes the known set of MISSION TEMPLATES and RUNNING MISSIONS
if (true) then {

    ([] call KPLIB_fnc_missions_onGetLists) params [
        Q(_missionTemplates)
        , Q(_runningMissions)
    ];

    [_cid, (_missionTemplates+_runningMissions)] call MFUNC(_onPublish);
};

if (_debug) then {
    [format ["[fn_missionsSM_onMissionsMgrOpened] Fini: [_cid]: %1"
        , str [_cid]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
};

true;
