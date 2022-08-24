function init_round_bumpers()
 -- initialise circular bumpers
 r_bumpers={
  create_round_bumper(
   vec(42,28),
   1
  ),
  create_round_bumper(
   vec(51,34),
   4
  ),
  create_round_bumper(
   vec(29,30),
   3
  ),
  create_round_bumper(
   vec(37,38),
   2
  )
 }
 for _rb in all(r_bumpers) do
  add(static_colliders,_rb)
  add(static_over,_rb)
 end
end

function create_round_bumper(
 _origin,
 _spr_i
)
 -- create a round bumper
 return {
  origin=_origin,
  simple_collider={
   x1=-5,y1=-5,x2=5,y2=5
  },
  spr_off=vec(-4,-4),
  spr_coords=vec(0,8*_spr_i),
  r=4.5,
  ref_spd=0.375,
  p=500,
  draw=draw_spr,
  spr_w=8,
  spr_h=8,
  hit=0,
  check_collision=check_collision_with_r_bumper
 }
end

function check_collision_with_r_bumper(_b,_pin)
 -- check for collision with the
 -- bumper
 if dist_between_vectors(_b.origin, _pin.origin)<=_b.r then
  increase_score(_b.p)
  planet_lights_lit+=0.5
  _b.hit = 8
  local normalized_perp_vec = _pin.origin:minus(_b.origin):normalize()
  rollback_pinball_pos(_pin)
  _pin.spd = calc_reflection_vector(
   _pin.spd,
   normalized_perp_vec
  )
  _pin.spd = _pin.spd:plus(normalized_perp_vec:multiplied_by(_b.ref_spd))
 end
end

function set_planet_lights()
 if planet_lights_lit>=10 then
  add(ongoing_msgs,planet_msg)
  flash(terra_lights[2],3,true)
  add(msgs,{"star system","mapping","complete!",t=120})
  increase_score(250,1)
  planet_lights_lit=0
  for i=1,10 do
   flash(planet_lights[i],2,false)
  end
  return
 end
 for i=1,10 do
  if planet_lights_lit>=i then
   planet_lights[i].lit=true
  else
   planet_lights[i].lit=false
  end
 end
end
