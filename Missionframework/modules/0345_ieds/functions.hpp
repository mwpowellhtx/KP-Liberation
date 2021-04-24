/*
    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-22 17:58:41
    Last Update: 2021-04-22 17:58:43
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

// TODO: TBD: IED effort is a distance second or third bit behind the actual sector state machine
// TODO: TBD: next bits are to get the sector state machine garrison properly engaged

// ? https://forums.bohemia.net/forums/topic/142802-spawning-explosion-bombs-other-than-the-good-ol-gbu12-lgb/ ?
// !!! https://forums.bohemia.net/forums/topic/139384-how-do-i-make-this-ied-work-in-arma-3/#post2365122
// # ArmA 3 Eden ➤ How to create / use IEDs VBIEDs SVBIEDs Part 01 ( Mission editor tutorial ) / https://www.youtube.com/watch?v=4yZyWItcTeo
// # ArmA 3 Editor Tutorial - IEDs and Ambushes / https://www.youtube.com/watch?v=0cQ3C-4W_BI
// # Simple IED Script | ArmA 3 / https://www.youtube.com/watch?v=NCBCBI-uNuY
// https://community.bistudio.com/wiki/Category:Command_Group:_Mines
// also need to know about triggers, the bomb explosions, etc

class sectorsSM {
    file = "modules\0345_ieds\fnc";

    // Initialization phase event handler
    class ieds_onPreInit {
        preInit = 1;
    };

    // Initialization phase event handler
    class ieds_onPostInit {
        postInit = 1;
    };

    // CBA Settings for this module
    class ieds_settings {};
};
