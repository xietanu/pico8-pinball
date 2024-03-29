function init_flippers()
 -- initialize flippers
 flippers={
  create_flipper(
   vec(29.5,118.5),
   pad_con.l,
   false,
   shift_light_left
  ),
  create_flipper(
   vec(50.5,118.5),
   pad_con.r,
   true,
   shift_light_right
  )
 }
end

function create_flipper(
 _origin,
 _button,
 _flip_x,
 _shift_light
)
 -- create a flipper
 local _flip=1
 local _base_angle=0
 local _spr_off=vec(-1,-5)
 if _flip_x then
  _spr_off.x=-9
  _flip*=-1
  _base_angle=0.5
 end
 local _f = {
  origin=_origin,
  simple_collider=create_box_collider(
   -7+5*_flip,-6,
   7+5*_flip,6
  ),
  collider_base=gen_polygon(
   "-2,-1,-1,-2,9.5,-1,10.5,0,9.5,1,-1,2,-2,1"
  ),
  check_collision=check_collision_with_flipper,
  spr_off=_spr_off,
  angle=0,
  angle_inc=0.07,
  button=_button,
  moving=0,
  bounce_frames=0,
  c=12,
  flip_x=_flip_x,
  flip=_flip,
  complete=true,
  shift_light=_shift_light
 }
 _f.collider = _f.collider_base
 
 return _f
end

function update_flipper(_f)
 -- update flipper each frame
 if btn(_f.button) then
		if _f.angle<0.09 then
			_f.moving=1
		else
			_f.moving=0
		end
	else
		if _f.angle> -0.09 then
			_f.moving=-1/3
		else
			_f.moving=0
		end
	end

 if btnp(_f.button) then
  _f.shift_light(top_rollovers.elements)
  sfx(0)
 end

 return ceil(_f.moving*5)
end

function update_flipper_pos(_f,_dt)
 -- update the position of the
 -- flipper each time the
 -- physics sim is updated
 if _f.moving!=0 then
  _f.angle=limit(
   _f.angle+_f.moving*_f.angle_inc/_dt,
   -0.09,
   0.09
  )
  update_flipper_collider(_f)
 end
end

function check_collision_with_flipper(_f,_pin)
 -- check collision with line
 -- segments of flipper
 if _f.moving==0 then
  check_collision_with_collider(_f,_pin)
  return
 end

 if point_collides_poly(_pin.origin,_f) then
  local _flp_spd = 2*_f.moving*dist_between_vectors(
   _f.origin,_pin.origin
   )*sin(-_f.angle_inc)
  local _flp_spd_vec = vec(
   _f.flip*_flp_spd*sin(-_f.angle+.035),
   _flp_spd*cos(_f.angle-.035)
  )
  rollback_pinball_pos(_pin)
  _f.angle=limit(
   _f.angle-_f.moving*_f.angle_inc/dt,
   -0.09,
   0.09
  )
  _pin.spd=_pin.spd:plus(_flp_spd_vec)
  update_flipper_collider(_f)
  _f.moving=0
  update_pinball_pos(_pin,dt)
 end
end


function update_flipper_collider(_f)
 -- update the vertex points
 -- based on the angle of the
 -- flipper.
 local _ang=_f.angle
 if _f.flip_x then
  _ang=0.5-_ang
 end
	_f.collider=rotate_pnts(
		_f.collider_base,
		vec(0,0),
		_ang
	)
end

function draw_flipper(_f)
 -- draw a flipper
 local i=4-flr(
  4.99*(
   _f.angle+0.09
  )/0.18
 )
 
 -- if draw_outlines then
 --  draw_collider(_f)
 -- end

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
