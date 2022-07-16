function init_flippers()
 flippers={
  create_flipper(
   {x=29.5,y=118.5},
   0,
   ⬅️,
   false
  ),
  create_flipper(
   {x=50.5,y=118.5},
   0.5,
   ➡️,
   true
  )
 }
end

function create_flipper(
 _origin,
 _base_angle,
 _button,
 _flip_x
)
 local _flip=1
 local _spr_off={x=-1,y=-5}
 if _flip_x then
  _spr_off.x=-9
  _flip*=-1
 end
 local _f = {
  origin=_origin,
  simple_collider={
   x1=-7+5*_flip,y1=-6,
   x2=7+5*_flip,y2=6
  },
  collider_base={
   {x=-2,y=-1},
   {x=-1,y=-2},
   {x=9.5,y=-1},
   {x=10.5,y=0},
   {x=9.5,y=1},
   {x=-1,y=2},
   {x=-2,y=1}
  },
  check_collision=check_collision_with_flipper,
  spr_off=_spr_off,
  angle=0,
  angle_max=0.09,
  angle_min=-0.09,
  angle_inc=0.06,
  button=_button,
  moving=0,
  bounce_frames=0,
  c=12,
  flip_x=_flip_x,
  flip=_flip
 }
 _f.collider = _f.collider_base
 
 return _f
end

function update_flipper(_f)
 if btn(_f.button) then
		if _f.angle<_f.angle_max then
			_f.moving=1
		else
			_f.moving=0
		end
	else
		if _f.angle>_f.angle_min then
			_f.moving=-1/3
		else
			_f.moving=0
		end
	end
 return ceil(_f.moving*5)
end

function update_flipper_pos(_f,_dt)
 if _f.moving!=0 then
  _f.angle=limit(
   _f.angle+_f.moving*_f.angle_inc/_dt,
   _f.angle_min,
   _f.angle_max
  )
  update_flipper_collider(_f)
 end
end

function check_collision_with_flipper(_f,_pin)
 if point_collides_poly(_pin.origin,_f) then
  
  local _flp_spd = _f.moving*dist_between_vectors(_f.origin,_pin.origin)*sin(_f.angle_inc)
  local _flp_spd_vec = {x=-_f.flip*_flp_spd*sin(_f.angle),y=_flp_spd*cos(_f.angle)}
  _pin.spd=add_vectors(_pin.spd,_flp_spd_vec)
  
  local _crossed_line = pin_entered_poly(_pin,_f)
  if _crossed_line != nil then
   rollback_pinball_pos(_pin)
   if _f.moving!=0 then
    _f.angle=limit(
     _f.angle-_f.moving*_f.angle_inc/dt,
     _f.angle_min,
     _f.angle_max
    )
   end

   bounce_off_line(_pin,_crossed_line)
  end

  
  update_flipper_collider(_f)

  update_pinball_pos(_pin,dt)
 end
end


function update_flipper_collider(_f)
 local _ang=_f.angle
 if _f.flip_x then
  _ang=0.5-_ang
 end
	_f.collider=rotate_pnts(
		_f.collider_base,
		{x=0,y=0},
		_ang
	)
end

function draw_flipper(_f)
 local i=4-flr(4.99*(_f.angle-_f.angle_min)/(_f.angle_max-_f.angle_min))
 
 if draw_outlines then
  draw_collider(_f)
 end

 sspr(
  16,
  0+11*i,
  11,
  11,
  _f.origin.x+_f.spr_off.x,
  _f.origin.y+_f.spr_off.y,
  11,
  11,
  _f.flip_x
 )
end
