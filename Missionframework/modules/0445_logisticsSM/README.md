### `0445 Logistics Statemachine` (not to be confused with `0400 Logistic`)

Ditto concerning notes for `0440 Logistics`. In this module, we focus on the actual machinery of the _state machine_. What do we mean by that. We will focus on what it means for a healthy logistics line to be moving. When we make certain assumptions about it, the logic of that machinery actually makes perfect sense.

#### Transit from `ALPHA` to `BRAVO`

Always. We make the decision up front to designate `ALPHA` as the starting `ENDPOINT` on a given logistics transit; then BRAVO is always considered the destination `ENDPOINT`. When the delivery is completed during that transit, then the state machine simply submits an automated `CONFIRM MISSION`, whereas `BRAVO` is reassigned the new `ALPHA`, and vice versa. There is nothing different about this event, only the originating source; whereas the `LOGISTICS MANAGER` submits the same event manually to start the line running, when the delivery is completely `UNLOADED`, the state machine submits the same event.

##### Transit states

1. `LOADING` - `LOADING` all of the `CONVOY TRANSPORTS` at `ALPHA`; may be blocked due to `NO RESOURCE`, and stays put until all transports are loaded.
1. `EN ROUTE` - `TRANSIT` moves from `ALPHA` to `BRAVO`; this is simulated by periodically refreshing the `TIMER`, which is used to calculate distance traversed, etc. Transit may be `BLOCKED` when landing in proximity to enemy controlled sectors. Transit may further fall victim to insurgend `AMBUSH`.
1. `UNLOADING` - When the line arrives at `BRAVO`, the `UNLOADING` operation occurs. When all resources have been fully transfered during this transit, then the state machine swaps `BRAVO` to `ALPHA`, and vice versa, and the entire transit sequence begins afresh. `UNLOADING` may be blocked when there is `NO SPACE` to receive the current resource delivery.
1. `AMBUSHED` - This is its own state, which at this point is more or less TBD, while we focus on the core logic for the time being.

##### Aborting states

1. `ABORTING/LOADING` - `ABORTING` while `LOADING` determines whether any `CONVOY TRANSPORTS` have received resources. When there are, then the state shifts to `ABORTING/UNLOADING`. If the line was blocked while `LOADING` for any reason, then the state machine simply ignores this and makes the shift to `UNLOADING` anyway.
1. `ABORTING/UNLOADING` - `ABORTING` while `UNLOADING` simply continues mission for as long as there are `CONVOY TRANSPORTS` to be unloaded. The usual block may occur, i.e. for `NO SPACE`.
1. `ABORTING/EN ROUTE` - This shift is a bit more complex. The base logic determines the nearest `ENDPOINT` to return to and designates the appropriate `BRAVO` accordingly. The `TIMER` may require reversal when `ENDPOINTS` were swapped in the process. When the line was `BLOCKED` due to enemy sectors, then the logic simply returns the `ALPHA` ASAP, whatever that reversal might involve, i.e. which may be a longer route, after all.

##### Change orders

`CHANGE ORDERS` are key to leveraging some common patterns, especially when we treat each `TRANSIT` in exactly the same manner.

1. `BUILD TRANSPORT` - `CONVOY TRANSPORTS` may be _built_, virtually speaking, as long as the line is in `STANDBY`, `LOADING` or `UNLOADING` states.
1. `RECYCLE TRANSPORT` - `CONVOY TRANSPORTS` may be _recycled_ as long as the line is in the same, either in `STANDBY`, `LOADING` or `UNLOADING` states. There must also be at least one empty transport available in order to be able to recycle it while `UNLOADING`. Whereas with `LOADING`, this state effectively _locks_ one of the transports in the current `PENDING` state, so effectively there must be at least two empty transports, such that one of them will be recycled. Of course there is no such restriction when in `STANDBY`.
1. `CONFIRM MISSION` - We can leverage this event, whether the `LOGISTICS MANAGER` submitted it manually, or the state machine processed it automatically at the end of the current transit sequence. Regardless, the result is the same, this is the moment we kick off a brand new transit from the new `ALPHA` to the new `BRAVO`.
1. `ABORT MISSION` - The same is true for the `ABORT` event. Logistics managers may `ABORT` a line as long as it is either not already `ABORTING`, or has not falling victim to `AMBUSH`. Everything else about the `ABORT` event is the same as `UNLOADING` or `EN ROUTE`, and we simply tack on the additional bit flag; see above.

Additionally, `CHANGE ORDERS` are enqueued for each line separately from each other and on a first come first serve basis. The only exception to this is for automated change orders, those issued by the state machine itself, during key moments when states are shifting. These are non-negotiable and must be immediately processed. TBD also whether this automated activity should also clear the change order queue.