#include "script_component.hpp"

// ...

params [
    [Q(_rsc), displayNull, [displayNull]]
];

// TODO: TBD: in the event we need to unregister anything, from the uiNamespace, etc...

systemChat format ["[onUnload] [_rsc::idd]", str [ctrlIDD _rsc]];
