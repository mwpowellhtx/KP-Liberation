#include "..\ui\defines.hpp"
#include "script_component.hpp"

// ...
// https://community.bistudio.com/wiki/ctAddHeader
// https://community.bistudio.com/wiki/createHashMapFromArray

private _debug = [
    [
        {MPARAM(_ctFob_onLoad_debug)}
    ]
] call MFUNC(_debug);

params [
    [Q(_ctFob), controlNull, [controlNull]]
    , [Q(_config), configNull, [configNull]]
];

if (_debug) then {
    [format ["[fn_hud_ctFob_onLoad] Entering: [ctrlIDC _ctFob, isNull _ctFob, isNull _config]: %1"
        , str [ctrlIDC _ctFob, isNull _ctFob, isNull _config]], "HUD", true] call KPLIB_fnc_common_log;
};

// Clear during a (re-)load, and in the event the CT_CONTROLS_TABLE itself has meta
MVAR(_ctFob_ctrlIdcs) = [ctrlIDC _ctFob];

// For debug logging later on
[[], []] params [
    Q(_metaKeysAdded)
    , Q(_ctrlsAdded)
];

// Report does not need to provide all of these elements, but may provide any of them
private _createMetaHashMap = {
    params [
        [Q(_hashMapKey), "", [""]]
        , [Q(_hashMapColorKey), "", [""]]
    ];

    // Select only those keys that have meta bits
    private _selectedKeys = [
        [Q(_hashMapKey), _hashMapKey]
        , [Q(_hashMapColorKey), _hashMapColorKey]
    ] select { !((_x#1) isEqualTo ""); };

    // Append the META keys themselves for metrics
    _metaKeysAdded = _metaKeysAdded + (_selectedKeys apply { (_x#1); });

    createHashMapFromArray _selectedKeys;
};

private _populateCtrlMetaKeys = {

    params [
        [Q(_lblBg), controlNull, [controlNull]]
        , [Q(_lblReport), controlNull, [controlNull]]
        , [Q(_lblPicture), controlNull, [controlNull]]
        , [Q(_metaBgHashKeys), emptyHashMap, [emptyHashMap]]
        , [Q(_metaReportHashKeys), emptyHashMap, [emptyHashMap]]
        , [Q(_metaPictureHashKeys), emptyHashMap, [emptyHashMap]]
    ];

    {
        _x params [
            [Q(_ctrl), controlNull, [controlNull]]
            , [Q(_hashMap), emptyHashMap, [emptyHashMap]]
        ];

        // For use during status update
        MVAR(_ctFob_ctrlIdcs) pushBackUnique (ctrlIDC _ctrl);

        { _ctrl setVariable [_x, _hashMap get _x]; } forEach (keys _hashMap);

    } forEach [
        [_lblBg, _metaBgHashKeys]
        , [_lblReport, _metaReportHashMap]
        , [_lblPicture, _metaPictureHashMap]
    ];

    true;
};

{
    // Expecting meta keys in this shape
    _x params [
        [Q(_lblBgMetaKeys), [], [[]]]
        , [Q(_lblReportMetaKeys), [], [[]]]
        , [Q(_lblPictureMetaKeys), [], [[]]]
    ];

    private _fobReportIndex = _forEachIndex;

    // And for 'either' HEADER or ROW template controls
    private _added = if (_fobReportIndex == 0) then {
        ctAddHeader _ctFob;
    } else {
        ctAddRow _ctFob;
    };

    // Recalling that yes we need to de-con an added CT_CONTROLS_TABLE HEADER/ROW response
    _added params [Q(_addedIndex), Q(_ctrls)];
    _ctrls params [Q(_bgCtrl), Q(_lblReport), Q(_lblPicture)];

    if (_debug) then {
        [format ["[fn_hud_ctFob_onLoad::forEach::_ctrlHashMapKeys] Added: [_fobReportIndex, _addedIndex, count _ctrls]: %1"
            , str [_fobReportIndex, _addedIndex, count _ctrls]], "HUD", true] call KPLIB_fnc_common_log;
    };

    // Convert the META bits to HASHMAP and relay to the CTRLS
    private _metaHashMaps = [_lblBgMetaKeys, _lblReportMetaKeys, _lblPictureMetaKeys] apply {
        _x call _createMetaHashMap;
    };

    // Accumulate the CTRLS as metrics
    _ctrlsAdded = _ctrlsAdded + _ctrls;

    // Finally acknowledge the CTRLS were ADDED by populating their META
    (_ctrls + _metaHashMaps) call _populateCtrlMetaKeys;

} forEach KPLIB_hudDispatchSM_ctrlHashMapKeys;

if (_debug) then {
    [format ["[fn_hud_ctFob_onLoad] Fini: [count _ctrlsAdded, count _metaKeysAdded, KPLIB_hud_ctFob_ctrlIdcs]: %1"
        , str [count _ctrlsAdded, count _metaKeysAdded, KPLIB_hud_ctFob_ctrlIdcs]], "HUD", true] call KPLIB_fnc_common_log;
};

true;
