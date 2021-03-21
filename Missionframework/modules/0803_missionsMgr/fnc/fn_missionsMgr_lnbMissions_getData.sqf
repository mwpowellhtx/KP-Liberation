/*
    KPLIB_fnc_missionsMgr_lnbMissions_getData

    File: fn_missionsMgr_lnbMissions_getData.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-20 21:02:35
    Last Update: 2021-03-20 21:02:37
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Reads the data backing the currently selected row and returns that parsed
        to useful form, [_uuid, _templateUuid]

    Parameter(s):
        _lnbMissions - The MISSIONS LISTNBOX control which contains the data [CONTROL, default: controlNull]
        _index - The selected index of the MISSIONS LISTNBOX [SCALAR, default: 0]

    Returns:
        Data backing the MISSIONS LISTNBOX selected row parsed to useful form: [ARRAY, [_uuid, _templateUuid]]
 */

params [
    ["_lnbMissions", controlNull, [controlNull]]
    , ["_selectedIndex", 0, [0]]
];

private _data = _lnbMissions lnbData [_selectedIndex, 0];

// Which we know is a simple ARRAY: [_uuid, _templateUuid]
parseSimpleArray _data;
