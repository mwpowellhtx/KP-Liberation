
<!-- TODO: TBD: reformat and gather the thought process... -->

So... in the mission there are the named _startbases_, right... `"KPLIB_eden_startbase"`, `"KPLIB_eden_startbase_0"`, `"KPLIB_eden_startbase_1"`, ...
I want to do a similar thing for the FOB buildings, when, 1. they are _deployed_ (and/or _deserialized_), i.e. _resequenced_; best guess, apparently it is a two step procedure
```sqf
// Assuming I've got a well formed FOB marker name in hand
_fobBuilding setVehicleVarName _markerName;
missionNamespace setVariable [_markerName, _fobBuilding, true];
```
2. undo the operation on _tear down_, i.e. _repackage_
```sqf
_fobBuilding setVehicleVarName "";
missionNamespace setVariable [_markerName, _nil, true];
```
Embracing the marker name approach, that is the moniker for identifying a sector, zone, start base, FOB, etc.
With the object in hand, i.e. _building_, _startbase proxy_, etc, we are able to do more, i.e. get a precise position.
Otherwise, getting positions for markers is, _awkward_..., returns `[_x, _y, 0]`, which might be fine for most things, but is potentially undesirable for sea-faring startbases, for instance.

