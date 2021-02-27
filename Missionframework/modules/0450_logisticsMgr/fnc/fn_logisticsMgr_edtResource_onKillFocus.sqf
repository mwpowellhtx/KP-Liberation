/*
    KPLIB_fnc_logisticsMgr_edtResource_onKillFocus

    File: fn_logisticsMgr_edtResource_onKillFocus.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-27 17:53:20
    Last Update: 2021-02-27 17:53:22
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _edtResource - the logistics resource CT_EDIT control [CONTROL, default: controlNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/ctrlTextSelection
        https://community.bistudio.com/wiki/ctrlTextSelection
 */

params [
    ["_edtResource", controlNull, [controlNull]]
];

private _selection = ctrlTextSelection _edtResource;

// Which respects the selection position, direction, and clears the selection to zero (0)
_edtResource ctrlSetTextSelection [(_selection#0)+(_selection#1), 0];

true;
