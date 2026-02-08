params ["_obj", "_pos"];

private _wh_pos = getPosASL _obj;
private _targetZ = ((ATLToASL _pos) select 2) - 1;
_pos set [2, _targetZ];

private _ins = lineIntersectsSurfaces [_wh_pos, _pos, _obj, objNull, true, 1, "VIEW", "FIRE"];
private _surfaceDistance = if (count _ins > 0) then [{(_ins select 0 select 0) distance _wh_pos}, {0}];

_wh_pos set [2, ((getPosASL _obj) select 2) - _surfaceDistance];
_obj setPosASL _wh_pos;
