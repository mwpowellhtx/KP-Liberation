#include "script_component.hpp"

// ...
// https://community.bistudio.com/wiki/Arma_3:_Mission_Event_Handlers#PlayerConnected

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

// // TODO: TBD: for that matter, do we even need to respond with this...
// // TODO: TBD: or just lean into 'allPlayers' itself
// private _players = allPlayers select { (owner _x) isEqualTo _owner; };
// if (_players isEqualTo []) then {
//     // TODO: TBD: no players matched OWNER    
// };

true;
