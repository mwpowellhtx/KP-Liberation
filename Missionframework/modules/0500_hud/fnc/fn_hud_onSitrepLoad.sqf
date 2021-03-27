#include "script_component.hpp"

// ...

params [
    [Q(_rsc), displayNull, [displayNull]]
    , [Q(_config), configNull, [configNull]]
];

// Lift the SITREP from the display config for use internally
private _sitrep = getText (_config >> Q(sitrep));

// TODO: TBD: in the event we need to register anything, in the uiNamespace, etc...

systemChat format ["[onLoad] [_rsc::idd, _sitrep]", str [ctrlIDD _rsc, _sitrep]];
