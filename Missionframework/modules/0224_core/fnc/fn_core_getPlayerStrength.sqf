/*
    KPLIB_fnc_core_getPlayerStrength

    File: fn_core_getPlayerStrength.sqf
    Author: Michael W. Powell (22nd MEU SOC)
    Created: 2021-04-18 19:23:24
    Last Update: 2021-05-25 22:36:03
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns the PLAYER STRENGTH as a ratio of the connected players to playable slots.
        Expecting SIDE to be either 'KPLIB_preset_sideF' or 'KPLIB_preset_sideE'.

        By default, returns the PLAYER STRENGTH expressed in terms of a RATIO. Otherwise,
        returns a tuple in the form of: [PLAYERCOUNT, SLOTCOUNT]

    Parameter(s):
        _side - the SIDE for which to consider strength [SIDE, default: KPLIB_preset_sideF]
        _ratio - returns the PLAYER STRENGTH expressed as a RATIO [BOOL, default: true]

    Returns:
        Ratio of the connected players to playable slots [SCALAR]
        Or a tuple: [SCALAR, SCALAR]

    References:
        https://community.bistudio.com/wiki/playableSlotsNumber
 */

params [
    ["_side", KPLIB_preset_sideF, [sideEmpty]]
    , ["_ratio", true, [true]]
];

if (!(_side in [KPLIB_preset_sideF, KPLIB_preset_sideE])) exitWith {
    if (_ratio) then { -1; } else { [-1, -1]; };
};

private _playerCount = ({ side _x isEqualTo _side; } count allPlayers);
private _slotCount = playableSlotsNumber _side;

if (_ratio) exitWith {
    ((_playerCount / _slotCount)
        min KPLIB_param_core_maxPlayerStrength)
            max KPLIB_param_core_minPlayerStrength;
};

[_playerCount, _slotCount];
