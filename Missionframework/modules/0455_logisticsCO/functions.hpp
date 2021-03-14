/*
    KP LIBERATION MODULE FUNCTIONS

    File: functions.hpp
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-03-06 10:16:28
    Last Update: 2021-03-13 17:30:33
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for all functions, which are brought by this module.
 */

class logisticsCO {
    file = "modules\0455_logisticsCO\fnc";

    // Module post initialization phase event handler
    class logisticsCO_onPostInit {
        postInit = 1;
    };

    // Module pre initialization phase event handler
    class logisticsCO_onPreInit {
        preInit = 1;
    };

    // Returns whether the caller should perform debugging
    class logisticsCO_debug {};

    // Client requests that the server build a LOGISTIC LINE TRANSPORT
    class logisticsCO_onRequestTransportBuild {};

    // Client requests that the server recycle a LOGISTIC LINE TRANSPORT
    class logisticsCO_onRequestTransportRecycle {};

    // Screens the target LOGISTIC LINE whether the activity may be performed
    class logisticsCO_onTransportBuildEntering {};

    // Performs the activity on the target LOGISTIC LINE
    class logisticsCO_onTransportBuild {};

    // Screens the target LOGISTIC LINE whether the activity may be performed
    class logisticsCO_onTransportRecycleEntering {};

    // Performs the activity on the target LOGISTIC LINE
    class logisticsCO_onTransportRecycle {};

    // Client requests server side confirmation starting the corresponding LOGISTIC LINE given ENDPOINTS
    class logisticsCO_onRequestMissionConfirm {};

    // Client request server side REROUTE in response to LOGISTIC status ABANDONED
    class logisticsCO_onRequestMissionReroute {};

    // Client requests server side LOGISTIC LINE operation be aborted
    class logisticsCO_onRequestMissionAbort {};

    // ...
    class logisticsCO_onMissionConfirmEntering {};

    // ...
    class logisticsCO_onMissionConfirm {};

    // ...
    class logisticsCO_onMissionAbandonedEntering {};

    // ...
    class logisticsCO_onMissionAbandoned {};

    // ...
    class logisticsCO_onMissionRerouteEntering {};

    // ...
    class logisticsCO_onMissionReroute {};

    // ...
    class logisticsCO_onMissionAbortEntering {};

    // ...
    class logisticsCO_onMissionAbort {};

    // ...
    class logisticsCO_onMissionBlockedEntering {};

    // ...
    class logisticsCO_onMissionBlocked {};

    // Handles aborting when the line was 'KPLIB_logistics_status_enRoute'
    class logisticsCO_onAbortEnRoute {};

    // Handles aborting when the line was 'KPLIB_logistics_status_loading'
    class logisticsCO_onAbortLoading {};

    // Handles aborting when the line was 'KPLIB_logistics_status_unloading'
    class logisticsCO_onAbortUnloading {};

    // Request to either add or remove some UUID to or from the CBA logistic namespaces
    class logisticsCO_onRequestAddOrRemoveLines {};
};
