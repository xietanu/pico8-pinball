pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
function init_captures()
 -- initialise the capture
 -- elements on the board.
 refuel_msg = {"rocket","fully","fueled!"}

 captures = {
  -- right capture
  create_capture(
   vec(68,58),
   vec(-1,1),
   250
  ),
  -- escape velocity capture
  create_capture(
   vec(9,53),
   vec(1,0),
   250
  ),
  -- rocket fuel capture
  create_capture(
   vec(40,74),
   vec(0.2,0.5),
   0,
   empty_fuel_action
  )
 }
 for _r in all(captures) do
  add(static_under,_r)
  add(static_colliders,_r)
  add(to_update,_r)
 end
end

function create_capture(
 _origin,
 _eject_vector,
 _points,
 _action
)
 return {
  origin=_origin,
  simple_collider=create_box_collider(
   -1.5,-1.5,
   1.5,1.5
  ),
  timer=0,
  reset_timer=0,
  bonus_timer=0,
  captured_pinball=nil,
  output_vector=_eject_vector,
  update=update_capture,
  draw=draw_capture,
  check_collision=check_collision_with_capture,
  action=_action,
  p=_points
 }
end

function check_collision_with_capture(
 _cap,
 _pin
)
 -- action to take when pinball
 -- collides with box collider.
 -- args:
 -- _cap (table): the capture
 -- _pin (table): the pinball
 if _cap.captured_pinball != nil or 
 _cap.reset_timer > 0 then
  return
 end
 _pin.captured=true
 _pin.origin=vec(
  _cap.origin.x,
  _cap.origin.y
 )
 _pin.spd=vec(0,0)
 _cap.captured_pinball=_pin
 _cap.timer=90
 _cap.reset_timer = 30
 increase_score(_cap.p)
 if _cap.action != nil then
  _cap:action()
 end
end

function update_capture(_cap)
 -- update capture each frame
 if _cap.captured_pinball == nil then
  _cap.reset_timer=max(
   0,_cap.reset_timer-1
  )
  if _cap.bonus_timer > 0 then
   _cap.bonus_timer-=1
  end
  return
 end

 if _cap.timer <= 0 then
  _cap.captured_pinball.spd=_cap.output_vector:copy()
  _cap.captured_pinball.captured=false
  _cap.captured_pinball = nil
  _cap.bonus_timer = 0
  return
 end

 _cap.timer -= 1
end

function draw_capture(_cap)
 circfill(
  _cap.origin.x,
  _cap.origin.y,
  2,
  0
 )
 local _c = get_frame(
  {4,10},
  _cap.bonus_timer,
  10
 )
 if _cap.captured_pinball != nil and 
 _cap.bonus_timer > 0 then
  _c = 10
 end
 circ(
  _cap.origin.x,
  _cap.origin.y,
  2,
  _c
 )
end

function empty_fuel_action(_cap)
 -- action for when fuel capture
 -- triggered.
 local _cnt, _pnts = 1, {
  111,555,2800,14,70,350
 }
 for _l in all(
  refuel_lights
 ) do
  _cnt+=tonum(_l.lit)
  _l.lit = false
 end
 increase_score(
  _pnts[_cnt],
  max(0,min(1,_cnt-3))
 )
 del(ongoing_msgs,refuel_msg)
 if _cnt==6 then
  add(msgs,{"full refuel!",t=90})
 elseif _cnt>1 then
  add(msgs,{"partial","refuel",t=90})
 else
  add(msgs,{"no fuel","ready!",t=90})
 end
end
