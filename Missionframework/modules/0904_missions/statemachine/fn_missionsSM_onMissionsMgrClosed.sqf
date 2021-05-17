#include "script_component.hpp"
/*
    KPLIB_fnc_missionsSM_onMissionsMgrClosed

    File: fn_missionsSM_onMissionsMgrClosed.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-19 19:46:01
    Last Update: 2021-03-20 12:59:43
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

// TODO: TBD: review this, rinse and repeat for MISSIONS
private _debug = [
    [
        {MPARAM(_onMissionsMgrClosed_debug)}
    ]
] call MFUNC(_debug);

params [
    ["_cid", -1, [0]]
];

if (_debug) then {
    [format ["[fn_missionsSM_onMissionsMgrClosed] Entering: [_cid]: %1"
        , str [_cid]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
};

private _objSM = [MVAR(_objSM)] call {
    params [
        [Q(_objSM), locationNull, [locationNull]]
    ];

    ([_objSM, [
        [QMVAR(_cids), []]
        , [QMVAR(_cidsToPublish), []]
    ]] call KPLIB_fnc_namespace_getVars) params [
        "_cids"
        , "_cidsToPublish"
    ];

    [_objSM, [
        [QMVAR(_cids), +(_cids - [_cid])]
        , [QMVAR(_cidsToPublish), +(_cidsToPublish - [_cid])]
    ]] call KPLIB_fnc_namespace_setVars;

    _objSM;
};

if (_debug) then {
    [format ["[fn_missionsSM_onMissionsMgrClosed] Fini: [_cid]: %1"
        , str [_cid]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
};

true;
