/*
    KPLIB_fnc_logisticsMgr_lnbConvoy_onLoadDummyData

    File: fn_logisticsMgr_lnbConvoy_onLoadDummyData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-02-27 15:14:51
    Last Update: 2021-02-27 15:14:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        ...

    Parameters:
        _lnbConvoy - the logistics convoy LISTNBOX control [CONTROL, default: controlNull]
        _config - the config [CONFIG, default: configNull]

    Returns:
        The event handler finished [BOOL]

    References:
        https://community.bistudio.com/wiki/lnbAddRow
        https://community.bistudio.com/wiki/lnbSetPicture
        https://community.bistudio.com/wiki/lnbSetTextRight
 */

params [
    ["_lnbConvoy", controlNull, [controlNull]]
    , ["_config", configNull, [configNull]]
];

// "Get" random convoy resource values, in the shape of 'KPLIB_resources_storageValue'
private _getRandomResourceValue = { random [0, 150, 300]; };

private _convoy = [];

while {count _convoy < 10} do {
    _convoy pushBack [
        [] call _getRandomResourceValue
        , [] call _getRandomResourceValue
        , [] call _getRandomResourceValue
    ];
};

_lnbConvoy setVariable ["KPLIB_logisticsMgr_convoy", _convoy];

// TODO: TBD: for initial use only...
systemChat format ["[fn_logisticsMgr_lnbConvoy_onLoadDummyData] [typeName _config]: %1", str [typeName _config]];

[_lnbConvoy, _config] call KPLIB_fnc_logisticsMgr_lnbConvoy_onLoad;

true;
