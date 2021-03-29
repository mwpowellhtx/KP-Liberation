/*
    KPLIB_fnc_enemy_strengthInc

    File: fn_enemy_strengthInc.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2019-02-18
    Last Update: 2019-06-15
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        CBA loop to increase the enemy strength in given interval depending
        on the remaining military bases.

    Parameter(s):
        NONE

    Returns:
        The function has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/common/fnc_waitAndExecute-sqf.html
 */

// TODO: TBD: this may or may not be necessary depending on the timing of the invocation during post init
waitUntil {
    KPLIB_campaignRunning;
};

// TODO: TBD: consider, is this the best formula? is there a better formula?
// Increase strength by remaining enemy military bases
[
    (count (KPLIB_sectors_military - KPLIB_sectors_blufor)) * 10
] call KPLIB_fnc_enemy_addStrength;

// (Re-)schedule the next call, by definition if we are here then CAMP RUNNING
[
    { [] call KPLIB_fnc_enemy_strengthInc; }
    , []
    , KPLIB_param_enemy_strengthDeltaPeriod
] call CBA_fnc_waitAndExecute;

true;
