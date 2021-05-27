#include "script_component.hpp"
/*
    KPLIB_fnc_hudFob_presets

    File: fn_hudFob_presets.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-26 09:40:07
    Last Update: 2021-05-26 22:29:27
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Arranges for the nominal module settings.

    Parameters:
        NONE

    Returns:
        The callback has finished [BOOL]
 */

if (isServer) then {

    MPRESET_SP(_suffixNone,"");
    MPRESET_SP(_suffixPct,"%");

    MPRESET_SP(_formatStringSimple,"%1");
    MPRESET_SP(_formatStringCountOf,"%1/%2");

    // Be prepared to resize the images to a consistent size, width, etc
    MPRESET_SP(_unitsPath,"\A3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_CA.paa");
    MPRESET_SP(_flightCtrlPath,"\a3\ui_f\data\map\diary\signal_ca.paa");
    MPRESET_SP(_rotaryPath,"\A3\air_f_beta\Heli_Transport_01\Data\UI\Map_Heli_Transport_01_base_CA.paa");
    MPRESET_SP(_fixedWingPath,"\A3\Air_F_EPC\Plane_CAS_01\Data\UI\Map_Plane_CAS_01_CA.paa");
    MPRESET_SP(_awarenessRatioPath,"\A3\ui_f\data\map\markers\handdrawn\unknown_CA.paa");
    MPRESET_SP(_strengthRatioPath,"\A3\ui_f\data\map\markers\handdrawn\warning_CA.paa");
    MPRESET_SP(_civRepPath,"\A3\ui_f\data\map\mapcontrol\tourism_CA.paa");

    private _mobileClassNames                           = [
        Q(Plane)
        , Q(Helicopter)
    ];
    MPRESET_SP(_mobileClassNames,_mobileClassNames);

    // Assumes that these presets have already been defined
    private _staticClassNames = [
        KPLIB_preset_airBuildingF
        , KPLIB_preset_slotJetF
        , KPLIB_preset_slotHeliF
    ];
    MPRESET_SP(_staticClassNames,_staticClassNames);

    private _viewDataOptionKeys                         = [
        Q(_fobOptions)
        , Q(_supplyOptions)
        , Q(_ammoOptions)
        , Q(_fuelOptions)
        , Q(_intelOptions)
        , Q(_unitOptions)
        , Q(_flightCtrlOptions)
        , Q(_rotaryOptions)
        , Q(_fixedWingOptions)
        , Q(_awarenessOptions)
        , Q(_strengthOptions)
        , Q(_civRepOptions)
    ];

    MPRESET_SP(_viewDataOptionKeys,_viewDataOptionKeys);

    // TODO: TBD: these should go in the RESOURCES module if they are not already...
    [
        [0, 0.95, 0, 1]
        , [0.95, 0, 0, 1]
        , [0.95, 0.95, 0, 1]
    ] params [
        Q(_supplyColor)
        , Q(_ammoColor)
        , Q(_fuelColor)
    ];
    MPRESET_SP(_supplyColor,_supplyColor);
    MPRESET_SP(_ammoColor,_ammoColor);
    MPRESET_SP(_fuelColor,_fuelColor);
};

if (hasInterface) then {
    MPRESET(_reportUuid)                                = [] call KPLIB_fnc_uuid_create_string;
};

true;
