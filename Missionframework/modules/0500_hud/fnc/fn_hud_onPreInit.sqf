#include "script_component.hpp"

// ...

if (isServer) then {
    // TODO: TBD: add logging
};

// The view mode set on PLAYER variables [BOOL, default: false]
MVAR(_reportAllResources)                   = QMVAR(_reportAllResources);

// We use the flags to indicate which bits require an update
MSTATUS(_standby)                           = 0;
MSTATUS(_fob)                               = 1;
MSTATUS(_sector)                            = 2;

// Which signals to handle the HUD OVERLAY state
MSTATUS(_overlay)                           = MSTATUS(_fob) + MSTATUS(_sector);


// Setup some variables which reach across client and server for purposes of coordinating reports
MFOB(_markerText)                           = QMFOB(_markerText);
MFOB(_supply)                               = QMFOB(_supply);
MFOB(_ammo)                                 = QMFOB(_ammo);
MFOB(_fuel)                                 = QMFOB(_fuel);
MFOB(_intel)                                = QMFOB(_intel);
MFOB(_enemyAwareness)                       = QMFOB(_enemyAwareness);
MFOB(_enemyStrength)                        = QMFOB(_enemyStrength);
MFOB(_unitCount)                            = QMFOB(_unitCount);
MFOB(_rotaryCount)                          = QMFOB(_rotaryCount);
MFOB(_fixedWingCount)                       = QMFOB(_fixedWingCount);

MSECTOR(_markerText)                        = QMSECTOR(_markerText);
MSECTOR(_gridref)                           = QMSECTOR(_gridref);
MSECTOR(_captured)                          = QMSECTOR(_captured);
MSECTOR(_engaged)                           = QMSECTOR(_engaged);
MSECTOR(_tower)                             = QMSECTOR(_tower);
MSECTOR(_bluforCount)                       = QMSECTOR(_bluforCount);
MSECTOR(_opforCount)                        = QMSECTOR(_opforCount);
MSECTOR(_civilianCount)                     = QMSECTOR(_civilianCount);
MSECTOR(_resistanceCount)                   = QMSECTOR(_resistanceCount);

MOVERLAY(_fobSitrep)                        = QMOVERLAY(_fobSitrep);
MOVERLAY(_sectorSitrep)                     = QMOVERLAY(_sectorSitrep);


// TODO: TBD: we could count more/other things as well, but this gets us parity, more or less, with legacy


if (isServer) then {
    // Server side init
};

if (hasInterface) then {
    // Client side init

    // TODO: TBD: status should be sufficient to determine whether we have one report or another
    // TODO: TBD: but just in case, we bundle the report names for use throughout

    // Which can be useful when determining whether report include FOB
    MFOB(_variableNames)                    = [
        MFOB(_markerText)
        , MFOB(_supply)
        , MFOB(_ammo)
        , MFOB(_fuel)
        , MFOB(_intel)
        , MFOB(_unitCount)
        , MFOB(_rotaryCount)
        , MFOB(_fixedWingCount)
    ];

    // Ditto including SECTOR bits
    MSECTOR(_variableNames)                 = [
        MSECTOR(_markerText)
        , MSECTOR(_gridref)
        , MSECTOR(_captured)
        , MSECTOR(_engaged)
        , MSECTOR(_tower)
        , MSECTOR(_bluforCount)
        , MSECTOR(_opforCount)
        , MSECTOR(_civilianCount)
        , MSECTOR(_resistanceCount)
    ];

    MOVERLAY(_blank)                        = QMOVERLAY(_blank);
    MOVERLAY(_overlay)                      = QMOVERLAY(_overlay);
};

if (isServer) then {
    // TODO: TBD: add logging
};

true;
