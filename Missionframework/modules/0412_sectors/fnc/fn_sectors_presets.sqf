#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_presets

    File: fn_sectors_presets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-29 21:12:56
    Last Update: 2021-06-14 16:52:32
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arrranges for the module preset variables.

    Parameter(s):
        NONE

    Returns:
        The callback finished [BOOL]

    References:
        https://www.thefreedictionary.com/arity
        https://en.wikipedia.org/wiki/Arity
 */

if (isServer) then {
    // Server side section

    MPRESET(_defaultUnitRange)                  = -1;

    // With preference, 'in BLUFOR' true (1), false (0), for select indexing purposes
    MPRESET(_sides)                             = [
        KPLIB_preset_sideE
        , KPLIB_preset_sideF
    ];

    MPRESET(_landVehicleKinds)                  = [
        Q(LandVehicle)
        , Q(Tank)
    ];

    MPRESET(_bucketNamePrefixes)                = [
        QMVAR(_actUnits)
        , QMVAR(_capUnits)
        , QMVAR(_actTanks)
        , QMVAR(_capTanks)
        , QMVAR(_actVehicles)
        , QMVAR(_capVehicles)
    ];

    // RATIO that must be achieved in order for SECTOR CAPTURE to occur
    MPRESET(_capRatioThreshold)                 = 0.5;

    // Define a nominal minimum near-zed, but not-zed, divisor value
    MPRESET(_minRatioDivisor)                   = 0.001;

    MPRESET(_ratioKinds)                        = [
        Q(Unit)
        , Q(Tank)
    ];

    MPRESET(_ratioVarNameFormats)               = [
        "KPLIB_sectors_cap%1Dividend"
        , "KPLIB_sectors_cap%1Divisor"
    ];

    // TODO: TBD: we may further dissect modifiers by sector type, but that could get kinda nuts...
    // TODO: TBD: also need to establish proper settings vars (for starters)...
    // TODO: TBD: and also proper CBA settings themselves...
    // Minding the PRESET itself is defined in reference to CBA settings
    MPRESET(_ratioParamVarNameFormats)          = [
        "KPLIB_param_%1%2DividendOffset"
        , "KPLIB_param_%1%2DivisorOffset"
        , "KPLIB_param_%1%2DividendCoef"
        , "KPLIB_param_%1%2DivisorCoef"
        , "KPLIB_param_%1RatioBias"
    ];
};

true;
