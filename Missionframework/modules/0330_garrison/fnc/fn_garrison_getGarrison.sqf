#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_getGarrison

    File: fn_garrison_getGarrison.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
    Created: 2021-04-17 12:35:35
    Last Update: 2021-04-21 12:41:34
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Returns the GARRISON ARRAY corresponding to the references SECTOR MARKER NAME.

    Parameter(s):
        _markerName - a SECTOR marker name [STRING, default: ""]

    Returns:
        GARRISON ARRAY corresponding to the SECTOR MARKER NAME [ARRAY]
 */

params [
    [Q(_markerName), "", [""]]
];

private _namespace = [_markerName] call KPLIB_fnc_sectors_getNamespace;

[_namespace] call MFUNC(_namespaceToArray);
