## Build FOB sequence

There are a lot of hoops that this jumps through choreographing the FOB building sequence. We will attempt to document that sequence of events here. We also think that, potentially, we can at least template building factory sector storage based on this sequence. A secondary goal is to generalize the sequence to support both use cases, if possible.

### It starts with a FOB box

_Box_ or _truck_, that is.

* `KPLIB_fnc_core_handleVehicleSpawn`
  * Adds the `"STR_KPLIB_ACTION_DEPLOY"` action menu to the _FOB box_ or _truck_
    * Action callback kicks off a `"KPLIB_fob_build_requested"` _local CBA event_ with the target object (i.e. _box_ or _truck_), or the `KPLIB_fnc_build_onFobBuildRequested` function

* `KPLIB_fnc_build_onFobBuildRequested` invokes the `KPLIB_fnc_build_start_single` function with a callback to `KPLIB_fnc_build_onConfirmBuildFob` upon confirmation

