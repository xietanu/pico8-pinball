function create_pinball(_pos)
 -- create a pinball
 local _p = {
   origin=_pos,
   last_pos=_pos:copy(),
   spd=vec(0,0),
   spd_mag=0,
   simple_collider=create_box_collider(
    -1.5,-1.5,
    1.5,1.5
   ),
   check_collision=check_collision_with_pinball,
   captured=false,
   trackers={}
  }
 add(
  pinballs,
  _p
 )
 return _p
end

function update_pinball_spd_acc(_pin)
 _pin.spd=_pin.spd:multiplied_by(0.995)
 _pin.spd.y+=0.03
 _pin.spd_mag=_pin.spd:magnitude()

 local _dt = min(
  ceil(
   _pin.spd_mag
  ),
  4
 )

 return _dt
end

function update_pinball_pos(_pin,_dt)
 if _pin.captured then
  return
 end

 _pin.last_pos = _pin.origin:copy()

 if _pin.spd_mag > _dt then
  _pin.origin=_pin.origin:plus(
   _pin.spd:normalize()
  )
 else
  _pin.origin=_pin.origin:plus(
   _pin.spd:multiplied_by(1/_dt)
  )
 end

 if _pin.origin.y > 140 or _pin.origin.y < 0 or _pin.origin.x < 2 or _pin.origin.x > 78 then
  del(pinballs,_pin)
  if blastoff_mode then
   add_blastoff_ball()
  end
 else
  for _col_grp in all({collision_regions[flr(_pin.origin.x/16)+1][flr(_pin.origin.y/16)+1],always_colliders,flippers,pinballs}) do
   for _sc in all(_col_grp) do
    if _pin != _sc then
     check_collision(_pin,_sc)
    end
   end
  end
  if #_pin.trackers==0 then
   add_tracker(_pin)
  elseif not pos_are_equal(_pin.origin,_pin.trackers[#_pin.trackers]) then
   add_tracker(_pin)
  end
 end
end

function add_tracker(pinball)
 add(pinball.trackers,{
   x=pinball.origin.x,y=pinball.origin.y,l=7
  })
end

function rollback_pinball_pos(_pin)
 _pin.origin=_pin.last_pos
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
  if not _pin1.captured then
   rollback_pinball_pos(_pin1)
  end
  if not _pin2.captured then
   rollback_pinball_pos(_pin2)
  end

  local perp_vec = _pin1.origin:minus(_pin2.origin):normalize()

  local u1 = perp_vec:dot(_pin1.spd)
  local u2 = perp_vec.x*_pin1.spd.y - perp_vec.y*_pin1.spd.x
  local u3 = perp_vec:dot(_pin2.spd)
  local u4 = perp_vec.x*_pin2.spd.y - perp_vec.y*_pin2.spd.x

  _pin2.spd.x = perp_vec.x * u1 - perp_vec.y * u4
  _pin2.spd.y = perp_vec.y * u1 + perp_vec.x * u4
  _pin1.spd.x = perp_vec.x * u3 - perp_vec.y * u2
  _pin1.spd.y = perp_vec.y * u3 + perp_vec.x * u2

 end
end
