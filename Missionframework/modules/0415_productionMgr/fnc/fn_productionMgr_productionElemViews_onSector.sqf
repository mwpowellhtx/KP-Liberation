/*
    KPLIB_fnc_productionMgr_productionElemViews_onSector

    File: fn_productionMgr_productionElemViews_onSector.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-10 13:46:44
    Last Update: 2021-02-10 13:46:46
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns a view based on the '_productionElem' tuple.

    Parameter(s):
        _this - the production element tuple [ARRAY, default: []]

    Returns:
        The view based on the '_productionElement' tuple.
*/

private _productionElem = _this;

private _markerName = (_productionElem#0#0);

private _pos = markerPos _markerName;

[[mapGridPosition _pos, (_productionElem#0#1)], _markerName];
