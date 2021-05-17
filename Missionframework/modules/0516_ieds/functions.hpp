/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-22 17:58:41
    Last Update: 2021-05-17 14:48:49
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

// TODO: TBD: IED effort is a distance second or third bit behind the actual sector state machine
// TODO: TBD: next bits are to get the sector state machine garrison properly engaged

// createTrigger [type, position, makeGlobal]
// _trg = createTrigger ["EmptyDetector", getPos player];
// _trg setTriggerArea [5, 5, 0, false];
// _trg setTriggerActivation ["CIV", "PRESENT", true];
// _trg setTriggerStatements ["this", "hint 'Civilian near player'", "hint 'no civilian near'"];

// ? https://forums.bohemia.net/forums/topic/142802-spawning-explosion-bombs-other-than-the-good-ol-gbu12-lgb/ ?
// !!! https://forums.bohemia.net/forums/topic/139384-how-do-i-make-this-ied-work-in-arma-3/#post2365122
// # ArmA 3 Eden ➤ How to create / use IEDs VBIEDs SVBIEDs Part 01 ( Mission editor tutorial ) / https://www.youtube.com/watch?v=4yZyWItcTeo
// # ArmA 3 Editor Tutorial - IEDs and Ambushes / https://www.youtube.com/watch?v=0cQ3C-4W_BI
// # Simple IED Script | ArmA 3 / https://www.youtube.com/watch?v=NCBCBI-uNuY
// https://community.bistudio.com/wiki/Category:Command_Group:_Mines
// also need to know about triggers, the bomb explosions, etc

class ieds {
    file = "modules\0516_ieds\fnc";

    //
    class ieds_canDisarm {};

    //
    class ieds_onMineSpawned {};

    //
    class ieds_onPlayerRespawned {};

    //
    class ieds_onPlayerRedeployed {};

    //
    class ieds_setupPlayerActions {};

    // CBA Settings for this module
    class ieds_settings {};

    // Initialization phase event handler
    class ieds_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class ieds_onPostInit {
        postInit = 1;
    };

    // Creates ONE IED object given position and class name
    class ieds_createOne {};

    //
    class ieds_getRoads {};

    //
    class ieds_getSpawnPos {};

    //
    class ieds_onDisarm {};

    //
    class ieds_onGC {};

    //
    class ieds_onTriggerActivation {};

    //
    class ieds_onTriggerBigCondition {};

    //
    class ieds_onTriggerSmallCondition {};
};
