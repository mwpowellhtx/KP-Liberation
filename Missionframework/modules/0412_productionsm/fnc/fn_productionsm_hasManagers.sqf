/*
    KPLIB_fnc_productionsm_hasManagers

    File: fn_productionsm_hasManagers.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-21 13:38:13
    Last Update: 2021-02-21 13:38:15
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns whether there are managers have announced themselves to the running statemachine.

    Parameter(s):
        NONE

    Returns:
        Whether the production timer is considered to be elapsed [BOOL]
 */

private _objSM = KPLIB_productionsm_objSM;

private _cids = _objSM getVariable ["KPLIB_productionsm_cids", []];

!(_cids isEqualTo []);
