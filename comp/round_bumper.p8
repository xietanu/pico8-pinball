function init_round_bumpers()
 -- initialise circular bumpers
 r_bumpers={
  create_round_bumper(vec(40,30),16),
  create_round_bumper(vec(51,35),64),
  create_round_bumper(vec(29,35),48),
  create_round_bumper(vec(51,52),32)
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
 -- args:
 -- _origin (vector): centre point
 -- _spr_i (int): sprite index
 return {
  origin=_origin,
  simple_collider={
   x1=-5,y1=-5,x2=5,y2=5
  },
  spr_off={x=-4,y=-4},
  spr_i=_spr_i,
  r=4.5,
  ref_spd=0.375,
  p=500,
  draw=draw_spr,
  check_collision=check_collision_with_r_bumper
 }
end

function check_collision_with_r_bumper(_b,_pin)
 -- check for collision with the
 -- bumper
 if dist_between_vectors(_b.origin, _pin.origin)<=_b.r then
  increase_score(_b.p)
  local normalized_perp_vec = normalize(subtract_vectors(_pin.origin,_b.origin))
  rollback_pinball_pos(_pin)
  _pin.spd = calc_reflection_vector(
   _pin.spd,
   normalized_perp_vec
  )
  _pin.spd = add_vectors(_pin.spd,multiply_vector(normalized_perp_vec,_b.ref_spd))
 end
end
