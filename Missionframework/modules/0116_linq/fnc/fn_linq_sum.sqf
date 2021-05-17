// ...

params [
    ["_values", [], [[]]]
    , ["_selector", { (_this#0); }, [{}]]
    , ["_includeIndex", true, [true]]
];

private _zed = 0;

// SELECT a VIEW over the range of VALUES, defaulting to itself
private _selected = [_values, _selector, _includeIndex] call KPLIB_fnc_linq_select;

// Performs the SUM as a shorthand form of the AGGREGATE function
private _sum = [_zed, _selected] call KPLIB_fnc_linq_aggregate;

_sum;
