#include "script_component.hpp"
#include "..\..\KPLIB_actionMenu.hpp"

// ...
// https://cbateam.github.io/CBA_A3/docs/files/common/fnc_addPlayerAction-sqf.html
// https://community.bistudio.com/wiki/addAction
// https://community.bistudio.com/wiki/setUserActionText

if (hasInterface) then {
    // TODO: TBD: setup player actions concerning: resource view: all or local ...

    [] call {

        private _conditionWhenPlayerAtFob = '
            !(([] call KPLIB_fnc_common_getPlayerFob) isEqualTo "")
        ';

        private _args = [
            // Default view is FOB, i.e. we then 'TOGGLE TO ALL' resources
            localize "STR_KPLIB_HUD_ACTION_MENU_VIEW_ALL_RESOURCES"
            , {
                params [
                    Q(_target)
                    , Q(_caller)
                    , Q(_actionId)
                    , Q(_args)
                ];

                private _reportAllResources = _target getVariable [MVAR(_reportAllResources), false];

                private _text = localize (if (_reportAllResources) then {
                    "STR_KPLIB_HUD_ACTION_MENU_VIEW_ALL_RESOURCES";
                } else {
                    "STR_KPLIB_HUD_ACTION_MENU_VIEW_FOB_RESOURCES";
                });

                // 'Toggle' by (re-)setting the user action text accordingly
                _target setUserActionText [_actionId, _text];

                // Then (re-)set the variable, must publish this everywhere, but for SERVER especially to see it
                _target setVariable [MVAR(_reportAllResources), !_reportAllResources, true];
                //                       This is how we toggle: ^^^^^^^^^^^^^^^^^^^^
                //                But this is critical as well:                       ^^^^
            }
            , []
            , KPLIB_ACTION_PRIORITY_REPORT_RESOURCES
            , false
            , true
            , ""
            , _conditionWhenPlayerAtFob
            , -1
        ];

        [_args] call CBA_fnc_addPlayerAction;
    };
};

true;
