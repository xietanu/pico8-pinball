function init_pinball()
 -- itinitialise the pinball
 pinballs={
  create_pinball(30,80)
 }
end

function create_pinball(_x,_y)
 -- create a pinball
 -- args:
 -- _x (int): x position
 -- _y (int): y position
 local _pos=vec(_x,_y)
 return {
   origin=_pos,
   prev={copy_vec(_pos)},
   spd=vec(0,0),
   acc=vec(0,0),
   simple_collider=create_box_collider(
    -1.5,-1.5,
    1.5,1.5
   ),
   check_collision=check_collision_with_pinball,
   captured=false,
   trackers={},
   get_last_pos=(function(_pin) return _pin.prev[#_pin.prev] end)
  }
end

function update_pinball_spd_acc(_pin)
 local _acc,_spd=_pin.acc,_pin.spd
 _acc.x=-0.0075*_spd.x
 _acc.y=-0.0075*_spd.y+0.03
 _spd.x+=_acc.x
 _spd.y+=_acc.y

 local _dt = ceil(
  max(abs(_spd.x),abs(_spd.y))*2
 )

 return _dt
end

function update_pinball_pos(_pin,_dt)
 if _pin.captured then
  return
 end

 local _pos,_spd=_pin.origin,_pin.spd
 add(_pin.prev,{x=_pos.x,y=_pos.y})
 while #(_pin.prev) > 30 do
  del(_pin.prev,_pin.prev[1])
 end
 _pos.x+=_spd.x/_dt
 _pos.y+=_spd.y/_dt

 if _pin.origin.y > 127 then
  del(pinballs,_pin)
 else
  local _col_region = collision_regions[flr(_pin.origin.x/16)+1][flr(_pin.origin.y/16)+1]
  for _sc in all(_col_region) do
   check_collision(_pin,_sc)
  end
  for _f in all(flippers) do
   check_collision(_pin,_f)
  end
  for _p in all(pinballs) do
   if _pin != _p then
    check_collision(_pin,_p)
   end
  end
  if #_pin.trackers==0 then
   add_tracker(_pin)
  elseif not pos_are_equal(_pin.origin,_pin.trackers[#_pin.trackers]) then
   add_tracker(_pin)
  end
 end

end

function rollback_pinball_pos(_pin)
 local _last_pos = _pin:get_last_pos()
 _pin.origin=_last_pos
 del(_pin.prev,_last_pos)
end

function draw_pinball(_pin)
 sspr(
  29,0,
  3,3,
  _pin.origin.x-1,
  _pin.origin.y-1
 )
end

function check_collision_with_pinball(_pin1,_pin2)
 if dist_between_vectors(_pin1.origin, _pin2.origin)<=3 then
  local normalized_perp_vec = normalize(subtract_vectors(_pin1.origin,_pin2.origin))
  while dist_between_vectors(_pin1.origin, _pin2.origin)<=3 do
   rollback_pinball_pos(_pin1)
   rollback_pinball_pos(_pin2)
  end
  _pin1.spd = calc_reflection_vector(
   _pin1.spd,
   normalized_perp_vec
  )
  normalized_perp_vec=multiply_vector(normalized_perp_vec,-1)
  _pin2.spd = calc_reflection_vector(
   _pin2.spd,
   normalized_perp_vec
  )
 end
end
