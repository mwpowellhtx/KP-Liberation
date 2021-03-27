#include "script_component.hpp"

// ...

params [
    [Q(_display), displayNull, [displayNull]]
    // TODO: TBD: note, we have to 'help' provide the CONFIG for the DISPLAY because A3 does not do so for this particular event
    , [Q(_config), configNull, [configNull]]
];

// TODO: TBD: in the event we need to register anything, in the uiNamespace, etc...

// Lift the CLASS NAME back from the DISPLAY instance itself
_display setVariable [QMVAR(_className), (configName _config)];
private _className = _display getVariable [QMVAR(_className), ""];

systemChat format ["[fn_hud_onLoad] [ctrlIDD _display, _className]: %1"
    , str [ctrlIDD _display, _className]];

true;
