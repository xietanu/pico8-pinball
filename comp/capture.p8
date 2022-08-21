pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
function init_captures()
 -- initialise the capture
 -- elements on the board.
 refuel_msg = {"rocket","fully","fueled!"}
 blastoff_msg = {"blast-off!","multiball!","2X bonus!"}

 captures = {
  -- right capture
  create_capture(
   vec(68,58),
   vec(-1,1),
   capture_points
  ),
  -- escape velocity capture
  create_capture(
   vec(9,53),
   vec(1,0),
   capture_points
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
  captured_pinball=nil,
  output_vector=_eject_vector,
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
 if _cap.captured_pinball != nil or 
 _cap.deactivated then
  return
 end
 _pin.captured=true
 _pin.origin=vec(
  _cap.origin.x,
  _cap.origin.y
 )
 _pin.spd=vec(0,0)
 _cap.captured_pinball=_pin
 _cap.deactivated=true
 increase_score(_cap.p)
 if _cap.action != nil then
  _cap:action()
 end
 add_to_queue(eject_captured,90,{_cap})
end

function eject_captured(_cap)
 -- eject the ball
 _cap.captured_pinball.spd=_cap.output_vector:copy()
 _cap.captured_pinball.captured=false
 _cap.captured_pinball = nil
 _cap.bonus_timer = 0
 disable_bonus(_cap)
 add_to_queue(reactivate,30,{_cap})
end

function draw_capture(_cap)
 local _bc = 0
 if _cap.deactivated then
  _bc = 5
 end
 circfill(
  _cap.origin.x,
  _cap.origin.y,
  2,
  _bc
 )
 _c = 4
 if _cap.lit then
  _c=10
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
 if blastoff_mode then
  increase_score(5,1)
  return
 end
 
 local _cnt, _pnts = 1, {
  111,555,2800,14,70,350
 }
 for _l in all(
  refuel_lights
 ) do
  if _l.lit then
   _cnt+=1
   flash(_l,3,false)
  end
 end
 
 increase_score(
  _pnts[_cnt],
  max(0,min(1,_cnt-3))
 )
 del(ongoing_msgs,refuel_msg)
 if _cnt==5 then
  blastoff_mode = true
  add(ongoing_msgs,blastoff_msg)
  flash(_cap,-99,false)
  for _l in all(
   refuel_lights
  ) do
   flash(_l,-99,false)
  end
  add_to_queue(add_blastoff_ball,120,{})
  add_to_queue(add_blastoff_ball,180,{})
  add_to_queue(end_blastoff_mode,2000,{})
 elseif _cnt>1 then
  add(msgs,{"partial","refuel",t=90})
  flash(_cap,3,false)
 else
  add(msgs,{"no fuel","ready!",t=90})
 end
end

function add_blastoff_ball()
 local _cap = captures[2]
 if _cap.captured_pinball != nil or _cap.deactivated then
  add_to_queue(add_blastoff_ball,30,{})
 end
 _cap.deactivated=true
 add_to_queue(reactivate,30,{_cap})
 _p = create_pinball(_cap.origin.x,_cap.origin.y)
 add(pinballs,_p)
 _p.spd=_cap.output_vector:copy()
end

function end_blastoff_mode(_cap)
 if not blastoff_mode then
  return
 end
 blastoff_mode = false
 reactivate(_cap)
 del(ongoing_msgs,blastoff_msg)
 end_flash(_cap,false)
 for _l in all(
  refuel_lights
 ) do
  end_flash(_l,false)
 end
end