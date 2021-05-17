#include "..\ui\defines.hpp"
#include "script_components.hpp"
/*
    KPLIB_fnc_build_displayFillList

    File: fn_build_displayFillList.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Date: 2018-09-09
    Last Update: 2019-04-30
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Fill list of buildable items

    Parameter(s):
        NONE

    Returns:
        Mode was changed [BOOL]
*/

private _debug = [
    [
        {KPLIB_param_build_displayFillList_debug}
    ]
] call KPLIB_fnc_debug_debug;

// CfgVehicles config for shorter/faster access
private _config = configFile >> "CfgVehicles";
// Get categories list
private _categoriesList = LGVAR(display) displayCtrl KPLIB_IDC_BUILD_CATEGORY_LIST;
private _categoryIdx = lbCurSel _categoriesList;
// Get search query box
private _searchBox = LGVAR(display) displayCtrl KPLIB_IDC_BUILD_SEARCH;
private _searchQuery = toLower ctrlText _searchBox;
// Get list box with buildables
private _lnbBuildItems = LGVAR(display) displayCtrl KPLIB_IDC_BUILD_ITEM_LIST;
_lnbBuildItems lbSetCurSel -1; // Unselect current row as it sticks between clearing
lnbClear _lnbBuildItems;

// Get category items
(LGVAR(buildables) select _categoryIdx) params ["", "_categoryItems"];

// Fill the item list
{
    // If item is a code execute it
    if (_x isEqualType {}) then {
        _x = [] call _x;
    };

    // Fill the list with items from currently selected category
    {
        // TODO: TBD: eventually rename "price" in terms of "cost" or even "debit" ...
        _x params ["_className", "_priceSupp", "_priceAmmo", "_priceFuel"];

        private _displayName = [_className, _config] call KPLIB_fnc_build_getClassDisplayName;

        // Filter list
        if (!((toLower _displayName find _searchQuery) isEqualTo -1)) then {

            private _rowIndex = _lnbBuildItems lnbAddRow [_displayName, str _priceSupp, str _priceAmmo, str _priceFuel];

            // Serialize classname and price
            _lnbBuildItems lnbSetData [[_rowIndex, 0], str _x];

            if (_debug) then {
                systemChat format ["[fn_build_displayFillList] Added: [_className, _supply, _ammo, _fuel]: %1", str _x];
            };

            private _icon = _className call KPLIB_fnc_common_getIcon;

            _lnbBuildItems lnbSetPicture [[_rowIndex, 0], _icon];
        };
    } forEach _x;

} foreach _categoryItems;

true;
