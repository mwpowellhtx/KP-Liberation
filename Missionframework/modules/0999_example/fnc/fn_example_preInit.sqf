/*
    KPLIB_fnc_example_preInit

    File: fn_example_preInit.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell [22nd MEU SOC]
    Created: 2019-02-02
    Last Update: 2021-06-14 17:24:54
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        The preInit function defines global variables, adds event handlers and set some vital settings which are used in this module.

    Parameter(s):
        NONE

    Returns:
        Module preInit finished [BOOL]

    Remarks:
        From time to time it is useful to illustrate a table for various reasons. The
        following characters may be useful in the Visual Studio Code editor to help
        convey just such a table. Several styles are encouraged, single line, double
        line, and with various adjoining intersecting combinations. Spacing intentional
        in order for the characters to stand out. Assuming the Visual Studio Code font
        is Consolas.

            T/L:    ┌ ╒ ╓ ╔

            T/R:    ┐ ╕ ╖ ╗

            B/R:    ┘ ╛ ╜ ╝

            B/L:    └ ╘ ╙ ╚

            H:      ─ ╌ ┄ ┈ ═

            V:      │ ╎ ┆ ┊ ║

            T:      ┬ ╤ ╥ ╦

            L:      ├ ╞ ╟ ╠

            R:      ┤ ╡ ╢ ╣

            M:      ┼ ╪ ╫ ╬

            B:      ┴ ╧ ╨ ╩

            Key:
                B - bottom
                H - horizontal
                L - left
                M - middle
                R - right
                T - top
                V - vertical

            Example:
                ┌──────┬──────┐
                │      │      │
                ├──────┼──────┤
                │      │      │
                └──────┴──────┘

        See: https://stackoverflow.com/questions/46533200/default-font-they-use-for-visual-studio-code
*/

if (isServer) then {
    ["Module initializing...", "PRE] [EXAMPLE", true] call KPLIB_fnc_common_log;
};

/*
    ----- Module Globals -----
*/


/*
    ----- Module Initialization -----
*/

// Process CBA Settings
[] call KPLIB_fnc_example_settings;

if (isServer) then {
    // Server section (dedicated and player hosted)

    // Register load event handler
    ["KPLIB_doLoad", {[] call KPLIB_fnc_example_loadData;}] call CBA_fnc_addEventHandler;

    // Register save event handler
    ["KPLIB_doSave", {[] call KPLIB_fnc_example_saveData;}] call CBA_fnc_addEventHandler;
};

if (!(hasInterface || isDedicated)) then {
    // HC section
};

if (hasInterface) then {
    // Player section
};

if (isServer) then {
    ["Module initialized", "PRE] [EXAMPLE", true] call KPLIB_fnc_common_log;
};

true
