/*
    KPLIB_fnc_core_updateFobMarkers

    File: fn_core_updateFobMarkers.sqf
    Author: KP Liberation Dev Team - https://github.com/KillahPotatoes
            Michael W. Powell
    Created: 2018-05-13
    Last Update: 2021-02-12 11:48:19
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: Yes

    Description:
        Creates the FOB markers on the very first visit, if necessary, and sets some
        nominal initialized values. Updates and sets the _markerText itself according
        to the number of known FOBs.

    Parameters:
        NONE

    Returns:
        Function reached the end [BOOL]
*/

{
    // KPLIB_sectors_fobs: the names are self-explanatory...
    [0, 1, 3, 4] params ["_markerNameIndex", "_markerTextIndex", "_uuidIndex", "_posIndex"];

    private _pos = (_x#_posIndex);

    if ((_x#_uuidIndex) isEqualTo "") then {
        _x set [_uuidIndex, ([] call KPLIB_fnc_uuid_create_string)];
        // TODO: TBD: setting (or re-setting) FOB UUID may also incur event to update asset UUIDs for serialization and other coordination purposes
    };

    if ((_x#_markerNameIndex) isEqualTo "") then {
        _x set [_markerNameIndex, format ["KPLIB_fob_%1", (_x#_uuidIndex)]];
    };

    private _mil = [_forEachIndex] call KPLIB_fnc_common_indexToMilitaryAlpha;

    // Updates the _markerText for the FOB tuple
    _x set [_markerTextIndex, format ["FOB %1", _mil]];

    private _markerName = (_x#_markerNameIndex);

    if (!(_markerName in allMapMarkers)) then {
        createMarker [_markerName, _pos];
    };

    _markerName setMarkerType KPLIB_core_fobMarkerType;
    _markerName setMarkerSize KPLIB_core_fobMarkerSize;
    _markerName setMarkerColor KPLIB_core_fobMarkerColor;
    _markerName setMarkerText (_x#_markerTextIndex);

} forEach KPLIB_sectors_fobs;

true;
