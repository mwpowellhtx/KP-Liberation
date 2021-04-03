#include "script_component.hpp"
/*
    KPLIB_fnc_hudDispatchSM_createReportContext

    File: fn_hudDispatchSM_createReportContext.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-03 00:31:59
    Last Update: 2021-04-03 00:32:05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns a newly created DISPATCH REPORT context. Will be populated with
        the required HUD elements for FOB, SECTOR, etc.

    Parameters:
        _player - the player for whom to obtain the context [OBJECT, default: objNull]

    Returns:
        The DISPATCH REPORT context [LOCATION]
 */

private _debug = [
    [
        {MPARAM(_createReportContext_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

// For use throughout, caller assumes responsibility for deletion
private _context = [] call KPLIB_fnc_namespace_create;

// Each report must receive a unique UUID so that the client refreshes only what/when it must
_context setVariable [QMVAR(_reportUuid), [] call KPLIB_fnc_uuid_create_string];

// Initialize the CONTEXT with bits that inform FOB and SECTOR reports
[_player, _context] call MFUNC(_onCreateReportContext_initFob);
[_player, _context] call MFUNC(_onCreateReportContext_initSector);

// Reset for a fresh compiled report
_context setVariable [Q(_compiledReport), []];

_context;
