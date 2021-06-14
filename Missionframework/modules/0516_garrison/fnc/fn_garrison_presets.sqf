#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_presets

    File: fn_garrison_presets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-06-01 12:54:51
    Last Update: 2021-06-14 17:12:02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges for the module PRESET variables.

    Parameter(s):
        NONE

    Returns:
        The callback has finished [BOOL]
 */

if (isServer) then {

    MPRESET(_keys)                                      = [
        QMVAR(_resources)
        , QMVAR(_intel)
        , QMVAR(_mines)
        , QMVAR(_units)
        , QMVAR(_assets)
    ];

    MPRESET(_minePosDelta)                              = [0, 0, -0.15];

    MPRESET(_roadTypes)                                 = [
        "ROAD"
        , "MAIN ROAD"
        , "TRACK"
        , "TRAIL"
    ];

    MPRESET(_buildingRadius)                            = 40;
    MPRESET(_buildingUnitRadius)                        = 20;
    MPRESET(_unitPosDelta)                              = [0, 0, 0.1];

    // /* Except for LIGHT VEHICLES, whether they should include APCs, the rest of the map
    //  * remains the same. Therefore we shall present a consistent master map from which
    //  * to initialize SECTOR GARRISON maps. Because these are PRESET module variables,
    //  * we also need to be careful of our module dependencies, i.e. IEDs.
    //  */
    // MPRESET(_masterMap) = createHashMapFromArray [
    //     [QMVAR(_resourceClassesF), +KPLIB_resources_crateClassesF]
    //     , [QMVAR(_intelClassesE), +KPLIB_preset_resources_intelClassNames]
    //     , [QMVAR(_mineClassesR), +KPLIB_preset_ieds_classNames]
    // ];
};

true;
