#include "script_component.hpp"
/*
    KPLIB_fnc_sectors_onActivating

    File: fn_sectors_onActivating.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-05-30 00:47:37
    Last Update: 2021-06-14 16:51:13
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Responds to the 'KPLIB_sectors_activating' server side CBA event. How we got
        here is not as important as that we must ensure the SECTOR activates.

    Parameters:
        _sector - a CBA SECTOR namespace [LOCATION, default: locationNull]

    Returns:
        The event handler has finished [BOOL]

    Remarks:
        The 'KPLIB_captured' flag is cleared for the next activation life cycle to occur.
        Additionally, we mark the 'KPLIB_sectors_sideOnActivation' which is critical to
        know about as there are essentially four scenarios, in which only two of them
        potentially require CAPTURE responses. The following truth table indicates SECTOR
        ALIGNMENT versus CAPTURING SIDE, as to whether a CAPTURE event is expected.

            ╔═══════╤══════╤══════╗
            ║#######│BLUFOR│OPFOR ║
            ╟───────┼──────┼──────╢
            ║ BLUFOR│  yes │ no   ║
            ╟───────┼──────┼──────╢
            ║  OPFOR│  no  │ yes  ║
            ╚═══════╧══════╧══════╝

        Essentially, when the sector ratio threshold has been met, the strongest side NOT
        ALIGNED WITH the sector may CAPTURE. As long as the stronger side IS ALIGNED WITH
        the sector, then capture MAY NOT occur.

        So the key take aways are two fold. First, we must have an accurate indcator of the
        SECTOR ALIGNMENT ON ACTIVATION for use throughout the activation life cycle. Second,
        we must have an accurate bookkeeping of the stronger side, ratios, etc, throughout
        the activation life cycle.

    References:
        https://stackoverflow.com/questions/46533200/default-font-they-use-for-visual-studio-code
 */

params [
    [Q(_sector), locationNull, [locationNull]]
];

private _debug = MPARAM(_onActivating_debug)
    || (_sector getVariable [QMVAR(_onActivating_debug), false])
    ;

private _markerName = _sector getVariable [QMVAR(_markerName), ""];

/* See notes especially REMARKS above for clarification, this is CRITICAL. While we could
 * simply ask for (_markerName in KPLIB_sectors_blufor), here we have side definitively at
 * the moment of activation.
 */
private _side = [_sector] call MFUNC(_getSide);

// These should be cleared or otherwise set
{ _sector setVariable _x; } forEach [
    [QMVAR(_captured), nil]
    , [QMVAR(_sideOnActivation), _side]
];

MVAR(_allActive) pushBackUnique _sector;

true;
