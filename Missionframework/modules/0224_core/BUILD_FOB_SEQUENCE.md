## Deploy FOB sequence

There are a lot of hoops that this jumps through choreographing the FOB building sequence. We will attempt to document that sequence of events here. We also think that, potentially, we can at least template building factory sector storage based on this sequence. A secondary goal is to generalize the sequence to support both use cases, if possible.

### It starts with a FOB box

_Box_ or _truck_, that is.

* `KPLIB_fnc_fobs_onVehicleSpawn`
  * Adds the `"STR_KPLIB_ACTION_FOBS_DEPLOY"` action menu to the _FOB box_ or _truck_
    * Action callback kicks off a `"KPLIB_fob_deploy_requested"` _local CBA event_ with the target object (i.e. _box_ or _truck_), or the `KPLIB_fnc_fobs_onDeployRequested` function

* `KPLIB_fnc_fobs_onDeployRequested` invokes the `KPLIB_fnc_build_start_single` function with a callback to `KPLIB_fnc_fobs_onConfirmDeploy` upon confirmation; we respond with a client side and a server side anonymous callback. Client side does some bookkeeping to delete the FOB BOX or TRUNK. Server side adds the newly created FOB BUILDING to the array of FOB BUILDINGS and resequences them, sets appropriate bits, updates markers, etc.
