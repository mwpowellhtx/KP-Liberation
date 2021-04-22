#include "script_component.hpp"
/*
    KPLIB_fnc_garrison_onGarrisoningMakeIntelArgs

    File: fn_garrison_onGarrisoningMakeIntelArgs.sqf
    Author: Michael W. Powell [22nd MEU SOC]
    Created: 2021-04-19 18:02:11
    Last Update: 2021-04-21 11:29:02
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html
    Public: No

    Description:
        Returns a set of ARRAY arguments for use when performing INTEL GARRISON objectives.

    Parameter(s):
        _min - minimum floor to use when calculating [SCALAR, default: 0]
        _count - pseudo-random count to use when calculating [SCALAR, default: 0]
        _ceil - whether the CEIL primitive is requested; otherwise ROUND [BOOL, default: true]
        _coef - coefficient to use when calculating [SCALAR, default: 1]

    Returns:
        The desired functional primitive [CODE]
 */

params [
    [Q(_min), 0, [0]]
    , [Q(_count), 0, [0]]
    , [Q(_ceil), false, [false]]
    , [Q(_coef), 1, [0]]
];

private _targetThresholds = [
    PCT(KPLIB_param_resources_intelThresholdL)
    , PCT(KPLIB_param_resources_intelThresholdM)
    , PCT(KPLIB_param_resources_intelThresholdS)
];

+[
    [_min, _count, _ceil, _coef]
    , _targetThresholds
    , KPLIB_resources_intelClassNames
];
