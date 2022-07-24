function init_flippers()
 -- initialize flippers
 flippers={
  create_flipper(
   vec(29.5,118.5),
   pad_con.l,
   false
  ),
  create_flipper(
   vec(50.5,118.5),
   pad_con.r,
   true
  )
 }
end

function create_flipper(
 _origin,
 _button,
 _flip_x
)
 -- create a flipper
 local _flip=1
 local _base_angle=0
 local _spr_off=vec(-1,-5)
 if _flip_x then
  _spr_off.x=-9
  _flip*=-1
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
  angle_max=0.09,
  angle_min=-0.09,
  angle_inc=0.07,
  button=_button,
  moving=0,
  bounce_frames=0,
  c=12,
  flip_x=_flip_x,
  flip=_flip,
  hit=false
 }
 _f.collider = _f.collider_base
 
 return _f
end

function update_flipper(_f)
 -- update flipper each frame
 -- args:
 -- _f (table): the flipper
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
 -- update the position of the
 -- flipper each time the
 -- physics sim is updated
 -- args:
 -- _f (table): the flipper
 -- _dt (int): number of times 
 --  this frame the sim is
 --  updated.
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
 -- check collision with line
 -- segments of flipper
 if _f.hit then
  return
 end

 if point_collides_poly(_pin.origin,_f) then
  -- _f.hit=true
  local _flp_spd = dist_between_vectors(
   _f.origin,_pin.origin
   )*_f.moving*sin(-_f.angle_inc)
   msg=_flp_spd

   local _flp_spd_vec = vec(
    -_f.flip*_flp_spd*sin(_f.angle),
    _flp_spd*cos(_f.angle)
   )

   _pin.spd=_pin.spd:plus(_flp_spd_vec)

  -- if _f.moving!=0 then
  --  _f.angle=limit(
  --   _f.angle-_f.moving*_f.angle_inc/dt,
  --   _f.angle_min,
  --   _f.angle_max
  --  )
  --  update_flipper_collider(_f)
  -- end

  local _ln=nil
  local _dist=99
  local _pin_pos=nil

  local _col={}
  for _pnt in all(_f.collider) do
   add(_col,_pnt:plus(_f.origin))
  end
  for i=1,#_col do
		 local j=i%#_col+1
   local line_dir=_col[j]:minus(_col[i]):normalize()
   local _pnt = _col[i]:plus(
    line_dir:multiplied_by(
     _pin.origin:minus(_col[i]):dot(line_dir)
    )
   )
   local _d = dist_between_vectors(_pnt,_pin.origin)
   if _d < _dist then
    _dist=_d
    _ln = line_dir
    _pin_pos=_pnt
   end
  end

  _pin.origin=_pin_pos

  -- add(hit_pnts,_pnt_hit)

  bounce_off_line(_pin,_ln)
  
  -- local _crossed_line = pin_entered_poly(
  --  _pin,_f
  -- )
  -- if _crossed_line != nil then
  --  

  --  bounce_off_line(_pin,_crossed_line)
  -- end

  -- 

  update_pinball_pos(_pin,dt)
 end
end

-- function nearest_pnt(_pnt1,_pnt2,_pin)

-- end

-- //linePnt - point the line passes through
-- //lineDir - unit vector in direction of line, either direction works
-- //pnt - the point to find nearest on line for
-- public static Vector3 NearestPointOnLine(Vector3 linePnt, Vector3 lineDir, Vector3 pnt)
-- {
--     lineDir.Normalize();//this needs to be a unit vector
--     var v = pnt - linePnt;
--     var d = Vector3.Dot(v, lineDir);
--     return linePnt + lineDir * d;
-- }

function update_flipper_collider(_f)
 -- update the vertex points
 -- based on the angle of the
 -- flipper.
 -- args:
 -- _f (table): flipper
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
 -- args:
 -- _f (table): flipper to draw
 local i=4-flr(
  4.99*(
   _f.angle-_f.angle_min
  )/(
   _f.angle_max-_f.angle_min
  )
 )
 
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
