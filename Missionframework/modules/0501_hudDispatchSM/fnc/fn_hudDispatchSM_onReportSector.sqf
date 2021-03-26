#include "script_component.hpp"

// ...
// https://cbateam.github.io/CBA_A3/docs/files/arrays/fnc_selectBest-sqf.html

params [
    [Q(_player), objNull, [objNull]]
];

private _emptyReport = [];

// Null player, nothing to report
if (isNull _player) exitWith {
    _emptyReport;
};

[
    getPos _player
    , KPLIB_param_sectorCapRange
    , +KPLIB_sectors_all
    , +KPLIB_sectors_blufor
    , +KPLIB_sectors_tower
] params [
    Q(_playerPos)
    , Q(_targetRange)
    , Q(_allSectors)
    , Q(_bluforSectors)
    , Q(_towerSectors)
];

// TODO: TBD: could allow more or less with a CBA setting on the factor, i.e. (_factor*_targetRange)
private _sectorRanges = _allSectors apply {
    [_x, (markerPos _x) distance2D _playerPos];
} select {
    (_x#1) <= (MPARAM(_sectorReportRange) * _targetRange);
};

// Select the 'best' SECTOR RANGE by INVERTED RANGE
private _markerRange = [_sectorRanges, { -(_x#1); }, ["", -1]] call CBA_fnc_selectBest;
//                       Inverted range: ^^^^^^^
//                              Default:             ^^^^^^^^

// Sector is not one of the available sectors
if (!((_markerRange#0) in _allSectors)) exitWith {
    _emptyReport;
};

_markerRange params [Q(_markerName), Q(_actualRange)];
private _markerPos = markerPos _markerName;

[
    markerText _markerName
    , mapGridPosition _markerPos
    , _markerName in _bluforSectors
    , _actualRange >= 0 && _actualRange <= _targetRange
    // TODO: TBD: because at the moment towers are a different use case, have gridref encoded in their display automatically
    , _markerName in _towerSectors
    , [_markerPos] call MFUNC(_getSectorUnits)
    , [_markerPos, KPLIB_preset_sideE] call MFUNC(_getSectorUnits)
    , [_markerPos, KPLIB_preset_sideC] call MFUNC(_getSectorUnits)
    , [_markerPos, KPLIB_preset_sideR] call MFUNC(_getSectorUnits)
] params [
    Q(_markerText)
    , Q(_gridref)
    , Q(_captured)
    , Q(_engaged)
    , Q(_tower)
    , Q(_bluforUnits)
    , Q(_opforUnits)
    , Q(_civilianUnits)
    , Q(_resistanceUnits)
];

// TODO: TBD: and from this we should have more than sufficient bits for the HUD SM to present accordingly
// TODO: TBD: may factor in system missions, i.e. sector under threat timers...
// TODO: TBD: for status bars, may include both BLUFOR, OPFOR, as well as RESISTANCE ...
[
    [KPLIB_hud_sector_markerText, toUpper _markerText]
    , [KPLIB_hud_sector_gridref, _gridref]
    , [KPLIB_hud_sector_captured, _captured]
    , [KPLIB_hud_sector_engaged, _engaged]
    , [KPLIB_hud_sector_tower, _tower]
    , [KPLIB_hud_sector_bluforCount, count _bluforUnits]
    , [KPLIB_hud_sector_opforCount, count _opforUnits]
    , [KPLIB_hud_sector_civilianCount, count _civilianUnits]
    , [KPLIB_hud_sector_resistanceCount, count _resistanceUnits]
];
