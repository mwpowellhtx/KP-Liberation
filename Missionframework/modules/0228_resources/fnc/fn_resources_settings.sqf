#include "script_component.hpp"
#include "defines.hpp"
/*
    KPLIB_fnc_resources_settings

    File: fn_resources_settings.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2018-12-14
    Last Update: 2021-05-06 01:58:40
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        CBA settings initialization for this module.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]

    References:
        https://cbateam.github.io/CBA_A3/docs/files/settings/fnc_addSetting-sqf.html
 */

/*
    ----- RESOURCES SETTINGS -----
 */

if (isServer) then {

    MPARAM(_loadData_debug)                 =   false;
    MPARAM(_saveData_debug)                 =   false;

    MPARAM(_onGatherIntel_debug)            =   false;
    MPARAM(_onIntelGC_debug)                =   false;

    MPARAM(_onIntelLevelChanged_debug)      =   false;
};

// TODO: TBD: instead of thresholds, just use the "dice" MO...
// TODO: TBD: and then we may also want to incorporate AWARENESS/STRENGTH/CIVREP...
// Thresholds, CHANCE of seeing the respective INTEL
MPARAM(_intelThresholdS)                    =      10;
MPARAM(_intelRewardMinS)                    =       1;
MPARAM(_intelRewardRangeS)                  =       5;

// REWARD MIN, RANGE, what it says: MIN+RANGE, RANGE range: [0,RANGE)
MPARAM(_intelThresholdM)                    =      60;
MPARAM(_intelRewardMinM)                    =       3;
MPARAM(_intelRewardRangeM)                  =      10;

MPARAM(_intelThresholdL)                    =      85;
MPARAM(_intelRewardMinL)                    =       5;
MPARAM(_intelRewardRangeL)                  =      15;

[
    QMPARAM(_defaultIntel)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_RESOURCES_INTEL_DEFAULT", localize "STR_KPLIB_SETTINGS_RESOURCES_INTEL_DEFAULT_TT"]
    , localize "STR_KPLIB_SETTINGS_RESOURCES"
    , [0, 100000, 0, 0] // range: [0, 100000], default: 0
    , 1
    , {}
] call CBA_fnc_addSetting;

[
    QMPARAM(_maxIntel)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_RESOURCES_INTEL_MAX", localize "STR_KPLIB_SETTINGS_RESOURCES_INTEL_MAX_TT"]
    , localize "STR_KPLIB_SETTINGS_RESOURCES"
    , [1000, 100000, 5000, 0] // range: [1000, 100000], default: 5000
    , 1
    , {}
] call CBA_fnc_addSetting;

// Allow for INTEL LEVEL changes, incluences the number of D4 dice to roll when calculating INTEL VALUE
for Q(_intelLevel) from 0 to 3 do {

    /* Generally there are FOUR levels of INTEL:
     *      - 0: PAPER DOCUMENTS
     *      - 1: PHONES, low level recording devices and electronics
     *      - 2: TABLETS, medium level recording devices and electronics
     *      - 3: LAPTOPS, higher level recording devices and electronics
     *
     * Which, also, if it did not also mean adopting pay level DLC dependencies, we might also
     * consider 'rugged' versions of the same, which is more typical of military style genres.
     */
    private _milal = toUpper ([_intelLevel] call KPLIB_fnc_common_indexToMilitaryAlpha);

    [_intelLevel + 1, _intelLevel + 3] params [Q(_min), Q(_max)];

    [
        QMPARAM(_intelLevel) + (_milal select [0, 1])
        , Q(SLIDER)
        , [
            format [localize "STR_KPLIB_SETTINGS_RESOURCES_INTEL_LEVEL", _milal]
            , localize "STR_KPLIB_SETTINGS_RESOURCES_INTEL_LEVEL_TT"
        ]
        , localize "STR_KPLIB_SETTINGS_RESOURCES"
        , [_min, _max, _min, 0] // range: [_min, _max], default: _min
        , 1
        , {}
    ] call CBA_fnc_addSetting;
};

{
    _x params [
        [Q(_sectorType), "", [""]]
        , [Q(_dieSides), "", [""]]
        , [Q(_dieTimes), "", [""]]
        , [Q(_dieOffset), "3", [""]]
    ];

    [
        format [KPLIB_RESOURCES_SECTORTYPE_PARAM_FORMAT_RESOURCE_DIE_BIAS, toLower _sectorType]
        , Q(SLIDER)
        , [
            format [localize "STR_KPLIB_SETTINGS_RESOURCES_RESOURCE_CIVREP_BIAS_FORMAT", _sectorType]
            , localize "STR_KPLIB_SETTINGS_RESOURCES_RESOURCE_CIVREP_BIAS_TT"
        ]
        , localize "STR_KPLIB_SETTINGS_RESOURCES"
        , [-100, 100, 25, 0] // range: [-100, 100], default: 25
        , 1
        , {}
    ] call CBA_fnc_addSetting;

    [
        format [KPLIB_RESOURCES_SECTORTYPE_PARAM_FORMAT_RESOURCE_DIE_SIDES, toLower _sectorType]
        , Q(EDITBOX)
        , [
            format [localize "STR_KPLIB_SETTINGS_RESOURCES_RESOURCE_DIE_SIDES_FORMAT", _sectorType]
            , localize "STR_KPLIB_SETTINGS_RESOURCES_RESOURCE_DIE_TT"
        ]
        , localize "STR_KPLIB_SETTINGS_RESOURCES"
        , _dieSides
        , 1
        , {}
    ] call CBA_fnc_addSetting;

    [
        format [KPLIB_RESOURCES_SECTORTYPE_PARAM_FORMAT_RESOURCE_DIE_TIMES, toLower _sectorType]
        , Q(EDITBOX)
        , [
            format [localize "STR_KPLIB_SETTINGS_RESOURCES_RESOURCE_DIE_TIMES_FORMAT", _sectorType]
            , localize "STR_KPLIB_SETTINGS_RESOURCES_RESOURCE_DIE_TT"
        ]
        , localize "STR_KPLIB_SETTINGS_RESOURCES"
        , _dieTimes
        , 1
        , {}
    ] call CBA_fnc_addSetting;

    [
        format [KPLIB_RESOURCES_SECTORTYPE_PARAM_FORMAT_RESOURCE_DIE_OFFSETS, toLower _sectorType]
        , Q(EDITBOX)
        , [
            format [localize "STR_KPLIB_SETTINGS_RESOURCES_RESOURCE_DIE_OFFSETS_FORMAT", _sectorType]
            , localize "STR_KPLIB_SETTINGS_RESOURCES_RESOURCE_DIE_TT"
        ]
        , localize "STR_KPLIB_SETTINGS_RESOURCES"
        , _dieOffset
        , 1
        , {}
    ] call CBA_fnc_addSetting;

} forEach [
    [Q(City)]
    , [Q(Factory)]
];

// The amount of resources which can be stored in a crate.
[
    Q(KPLIB_param_crateVolume)
    , Q(SLIDER)
    , [localize "STR_KPLIB_SETTINGS_RESOURCES_CRATEVOLUME", localize "STR_KPLIB_SETTINGS_RESOURCES_CRATEVOLUME_TT"]
    , localize "STR_KPLIB_SETTINGS_RESOURCES"
    , [50, 400, 100, 0] // range: [50, 400], default: 100
    , 1
    , {}
] call CBA_fnc_addSetting;

[Q(CBA_SettingChanged), {
    params [Q(_setting), Q(_value)];
    switch (toLower _setting) do {
        case (toLower QMPARAM(_intelLevelA));
        case (toLower QMPARAM(_intelLevelB));
        case (toLower QMPARAM(_intelLevelC));
        case (toLower QMPARAM(_intelLevelD)): {
            // Must do some auto-correction on the values for best results
            [MVAR(_intelLevelChanged), [_setting, round _value]] call CBA_fnc_serverEvent;
            //       Because the SLIDER does not: ^^^^^^^^^^^^
        };
    };
}] call CBA_fnc_addEventHandlerArgs;

true;
