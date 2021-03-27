#include "script_component.hpp"

// ...

private _debug = [
    [
        {MPARAM(_onBlankEntered_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_player), objNull, [objNull]]
];

// TODO: TBD: if we are here then there is either NO STATUS REPORT
// TODO: TBD: or a dialog has opened, in either event, BLANK the HUD

systemChat format [["[fn_hudSM_onBlankEntered] Entering..."]];

true;
