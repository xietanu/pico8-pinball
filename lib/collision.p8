function check_collision(_pin,_obj)
 if point_collides_box(_pin.origin,_obj) then
  _obj:check_collision(_pin)
 end
end

function create_box_collider(_x1,_y1,_x2,_y2)
 -- create a simple box collider
 -- args:
 -- _x1: x coord of top left
 -- _y1: y coord of top left
 -- _x2: x coord of bottom right
 -- _y2: y coord of bottom right
 return {x1=_x1, y1=_y1,x2=_x2, y2=_y2}
end

function lines_cross(_l1_1,_l1_2,_l2_1,_l2_2)
 local _a1,_b1,_c1=calc_inf_line_abc(_l1_1,_l1_2)
 local _a2,_b2,_c2=calc_inf_line_abc(_l2_1,_l2_2)
 local _d1 = (_a1*_l2_1.x)+(_b1*_l2_1.y)+_c1
 local _d2 = (_a1*_l2_2.x)+(_b1*_l2_2.y)+_c1

 if sign(_d1)==sign(_d2) then
  return false
 end
 
 local _d1 = (_a2*_l1_1.x)+(_b2*_l1_1.y)+_c2
 local _d2 = (_a2*_l1_2.x)+(_b2*_l1_2.y)+_c2

 if sign(_d1)==sign(_d2) then
  return false
 end
 
 return true
end

function calc_inf_line_abc(_l1,_l2)
 local _a=_l2.y-_l1.y
 local _b=_l1.x-_l2.x
 local _c=(_l2.x*_l1.y)-(_l1.x*_l2.y)
 return _a,_b,_c
end

function check_collision_with_collider(_obj,_pin)
 _obj.c=10
 local _crossed_line = pin_entered_poly(_pin,_obj)
 if _crossed_line != nil then
  _obj.c=8
  local _pnts = _crossed_line.p or _obj.p or 0
  if _pnts > 0 then
   increase_score(_pnts)
   _obj.hit = 7
  end
  rollback_pinball_pos(_pin)
  bounce_off_line(_pin,_crossed_line)
  return true
 end
end

function pin_entered_poly(_pin,_obj)
 local _pnts,_origin=_obj.collider,_obj.origin
 local _n_pnts=#_pnts
 if not _obj.complete then
  _n_pnts-=1
 end
	for i=1,_n_pnts do
		local j=i%#_pnts+1
		if lines_cross(
    _pin.origin,
    _pin:get_last_pos(),
				_pnts[i]:plus(_origin),
			 _pnts[j]:plus(_origin)
			) then
   local output=_pnts[i]:minus(_pnts[j])
   output.p=_pnts[i].p
   output.ref_spd=_pnts[i].ref_spd
   output.only_ref=_pnts[i].only_ref
   return output
		end
	end
 return nil
end

