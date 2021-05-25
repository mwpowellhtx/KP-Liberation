# KP Liberation Module Description

## Resources Module
!TODO! Description

### Dependencies
* Init
* Common

### Consumed events
**KPLIB_doLoad** (server side)
Calls KPLIB_fnc_resources_loadData to process saved module data

**KPLIB_doSave** (server side)
Calls KPLIB_fnc_resources_saveData to add the module data to the save array

**KPLIB_vehicle_created** (server side)
Calls KPLIB_fnc_addCrateActions to apply actions to spawned crates

### Emitted events


### Scripts

