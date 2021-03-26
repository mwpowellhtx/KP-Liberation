#include "script_component.hpp"

// ...
// https://community.bistudio.com/wiki/Arma_3:_Mission_Event_Handlers#PlayerDisconnected

private _objSM = MVAR(_objSM);

params [
    Q(_id)
    , Q(_uid)
    , Q(_name)
    , Q(_jip)
    , Q(_owner)
    , Q(_idstr)
];

if (isNull _objSM) exitWith {
    false;
};

// TODO: TBD: ditto connected notes re: allPlayers

true;
