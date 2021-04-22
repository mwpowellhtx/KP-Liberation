#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_getStatusReport

    File: fn_sectors_getStatusReport.sqf
    Author: Michael W. Powell [22nd MSU SOC]
    Created: 2021-04-22 12:30:29
    Last Update: 2021-04-22 12:30:31
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Enumerates the STATUS bits by decomposing the flags and translating into
        human readable text.

    Parameter(s):
        _namespace - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        An array of decomposed human readable flags [ARRAY]
 */

private _debug = MPARAM(_getStatusReport_debug);

params [
    [Q(_namespace), locationNull, [locationNull]]
];

private _status = _namespace getVariable [QMVAR(_status), MSTATUS(_standby)];

private _candidates = MVAR(_statusReportTable) select {
    [_status, (_x#0)] call KPLIB_fnc_namespace_checkStatus;
};

private _report = _candidates apply { toUpper (_x#1); };

_report;
