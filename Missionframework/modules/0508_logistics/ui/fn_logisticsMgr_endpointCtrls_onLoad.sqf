/*
    KPLIB_fnc_logisticsMgr_endpointCtrls_onLoad

    File: fn_logisticsMgr_endpointCtrls_onLoad.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-09 00:04:07
    Last Update: 2021-03-09 00:04:10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _endpointCtrls - an ENDPOINT control group [CONTROL, default: controlNull]
        _config - the configuration for the ENDPOINT control group [CONFIG, default: configNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/ctrlTextSelection
        https://community.bistudio.com/wiki/ctrlTextSelection
 */

params [
    ["_endpointCtrls", controlNull, [controlNull]]
    , ["_config", configNull, [configNull]]
];

private _display = ctrlParent _endpointCtrls;

private _endpointName = toUpper (getText (_config >> "endpoint"));
private _billIdcs = getArray (_config >> "billIdcs");

{
    private _resourceIndex = _x;
    private _varName = KPLIB_logisticsMgr_edtEndpointHashMap get [_endpointName, _resourceIndex];
    private _ctrl = _display displayCtrl (_billIdcs select _resourceIndex);
    uiNamespace setVariable [_varName, _ctrl];
} forEach KPLIB_resources_indexes;

true;
