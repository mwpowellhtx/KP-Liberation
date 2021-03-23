#include "script_component.hpp"
/*
    KPLIB_fnc_missionsSM_onPublish

    File: fn_missionsSM_onPublish.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-22 14:30:58
    Last Update: 2021-03-22 14:31:00
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Posts the CBA MISSIONS namespaces converted to tuple form to the requesting
        client, especially responding to the 'KPLIB_missionsSM_requestMissions' server
        side event.

    Parameters:
        _cid - the 'clientOwner' announced to the server [SCALAR, default: -1]

    Returns:
        The event handler finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/events/fnc_ownerEvent-sqf.html
 */

private _debug = [
    [
        {MPARAM(_onPublish_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_cid), -1, [0]]
    , [Q(_payload), [], [[]]]
];

if (_debug) then {
    [format ["[KPLIB_fnc_missionsSM_onPublish] Entering: [_cid]: %1"
        , str [_cid]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
};

// TODO: TBD: and perhaps do some logging...
if (_cid < 0) exitWith {
    if (_debug) then {
        [format ["[KPLIB_fnc_missionsSM_onPublish] Invalid client identifier: [_cid]: %1"
            , str [_cid]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
    };
    false;
};

// Converts the payload to a form that is acceptable by the client if necessary
if (count _payload > 0) then {
    // May convert each HOMOGENOUS PAYLOAD element
    _payload = switch (true) do {
        // Based strictly on a sniff of the first element
        case ((_payload#0) isEqualType locationNull): {
            _payload apply { [_x] call KPLIB_fnc_missions_namespaceToArray; }
        };
        // Otherwise, assumes that the payload is ready to ship
        default { _payload; };
    };
};

[KPLIB_missionsMgr_onMissionsPublished, [_payload], _cid] call CBA_fnc_ownerEvent;

if (_debug) then {
    [format ["[KPLIB_fnc_missionsSM_onPublish] Fini: [_cid, count _payload]: %1"
        , str [_cid, count _payload]], "MISSIONSSM", true] call KPLIB_fnc_common_log;
};

true;
