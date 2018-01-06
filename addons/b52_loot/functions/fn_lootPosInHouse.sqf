params ["_obj", "_pos"];
_wh_pos = getPosASL _obj;
_pos set [2, (ATLToASL _pos select 2) -1];
_ins              = lineIntersectsSurfaces [_wh_pos, _pos,_obj,objNull, true, 1,"VIEW","FIRE"];
_surface_distance = if (count _ins > 0) then [{(_ins select 0 select 0) distance _wh_pos},{0}];
_wh_pos set [2, (getPosASL _obj select 2) - (_surface_distance)];
_obj setPosASL _wh_pos;