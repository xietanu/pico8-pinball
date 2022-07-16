function init_captures()
 captures = {
  create_capture({x=68,y=58},{x=-1,y=1},250),
  create_capture({x=9,y=53},{x=1,y=0},250),
  create_capture({x=40,y=74},{x=0.2,y=0.5},0,empty_fuel_action)
 }
 for _r in all(captures) do
  add(static_under,_r)
  add(static_colliders,_r)
  add(to_update,_r)
 end
end

function create_capture(_origin,_output_vector,_p,_action)
 return {
  origin=_origin,
  simple_collider={x1=-1.5,y1=-1.5,x2=1.5,y2=1.5},
  timer=0,
  reset_timer=0,
  bonus_timer=0,
  captured_pinball=nil,
  output_vector=_output_vector,
  update=update_capture,
  draw=draw_capture,
  check_collision=check_collision_with_capture,
  action=_action,
  p=_p
 }
end

function check_collision_with_capture(_cap,_pin)
 if _cap.captured_pinball != nil or _cap.reset_timer > 0 then
  return
 end
 _pin.captured=true
 _pin.origin={x=_cap.origin.x,y=_cap.origin.y}
 _pin.spd={x=0,y=0}
 _cap.captured_pinball=_pin
 _cap.timer=90
 _cap.reset_timer = 30
 _cap.bonus_timer = 0
 add_to_long(score,_cap.p*multiplier)
 if _cap.action != nil then
  _cap:action()
 end
end

function update_capture(_cap)
 if _cap.captured_pinball == nil then
  _cap.reset_timer=max(0,_cap.reset_timer-1)
  if _cap.bonus_timer > 0 then
   _cap.bonus_timer-=1
  end
  return
 end
 if _cap.timer <= 0 then
  _cap.captured_pinball.spd={x=_cap.output_vector.x,y=_cap.output_vector.y}
  _cap.captured_pinball.captured=false
  _cap.captured_pinball = nil
  return
 end
 _cap.timer -= 1
end

function draw_capture(_cap)
 circfill(_cap.origin.x,_cap.origin.y,2,0)
 local _c = get_frame({4,10},_cap.bonus_timer,10)
 if _cap.captured_pinball != nil and _cap.bonus_timer > 0 then
  _c = 10
 end
 circ(_cap.origin.x,_cap.origin.y,2,_c)
end

function empty_fuel_action(_cap)
 local _cnt, _pnts = 1, {111,555,2800,14,70,350}
 for _l in all(refuel_lights.elements) do
  _cnt+=tonum(_l.lit)
  _l.lit = false
 end
 add_to_long(score,_pnts[_cnt]*multiplier,max(0,min(1,_cnt-3)))
end
