pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
function init_kickouts()
 -- initialise the capture
 -- elements on the board.
 blastoff_msg = {"blast-off!","multiball!"}
 target_hunt_msg = {"calibrate","lasers!","hit targets!"}

 kickouts = {
  -- target hunt capture
  create_capture(
   vec(68.5,58.5),
   vec(-1,1),
   1111,
   start_target_hunt
  ),
  -- escape velocity capture
  create_capture(
   vec(11.5,56.5),
   vec(1,0),
   1111,
   escape_velocity_action
  ),
  -- rocket fuel capture
  create_capture(
   vec(45.5,58.5),
   vec(0.4,0.4),
   0,
   empty_fuel_action
  )
 }
 add_group_to_board(kickouts,{static_under,static_colliders})
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

function escape_velocity_action(_cap)
 if not _cap.bonus_enabled then
  sfx(24)
  return
 end
 increase_score(50,1)
 add(msgs,{"slingshot!",t=90})
 light_orbit(1)
 sfx(10,3)
end

function empty_fuel_action(_cap)
 -- action for when fuel capture
 -- triggered.
 if blastoff_mode then
  increase_score(50,1)
  sfx(24)
  return
 end

 increase_score(
  3^min(5,refuel_lights_lit),
  1
 )
 if refuel_lights_lit>=#refuel_lights then
  light_orbit(2)
  blastoff_mode = true
  kickouts[2].deactivated=true
  reset_light.lit = true
  add(ongoing_msgs,blastoff_msg)
  sfx(29,1)
  flash(_cap,-99,false)
  cycle_lights(refuel_lights,1,40,6,true)
  add_blastoff_ball()
  add_to_queue(add_blastoff_ball,60)
  add_to_queue(end_blastoff_mode,1200)
 elseif refuel_lights_lit>0 then
  add(msgs,{"partial","refuel",t=90})
  flash(_cap,3,false)
  flash_table(refuel_lights,3,false,true)
  sfx(24)
 else
  sfx(24)
 end
 refuel_lights_lit=0
end

function add_blastoff_ball()
 local _cap = kickouts[2]
 _p = create_pinball(_cap.origin:copy())
 _p.spd=_cap.output_vector:copy()
end

function end_blastoff_mode()
 local _cap = kickouts[2]
 if not blastoff_mode then
  return
 end
 blastoff_mode = false
 reset_light.lit = false
 reactivate(_cap)
 del(ongoing_msgs,blastoff_msg)
 end_flash(_cap,false)
 end_flash_table(refuel_lights,false)
end

function start_target_hunt()
 add_to_queue(end_target_hunt,1800,{true})
 sfx(28)
 if not target_hunt then
  add(ongoing_msgs,target_hunt_msg)
  flash_rnd_target()
  target_hunt = true
  target_hunt_cnt = 0
 end
end

function flash_rnd_target()
 if cur_target then
  end_flash(cur_target.light)
  cur_target.sfx=14
 end
 local _rn = flr(rnd(3))
 local _t = nil
 if _rn==0 then
  _t=rnd(left_targets.elements)
 elseif _rn == 1 then
  _t=rnd(right_targets.elements)
 else
  _t=rnd(rocket_targets.elements)
 end
 flash(_t.light,-99)
 _t.sfx = 28
 cur_target=_t
end

function end_target_hunt(_timeout)
 if not target_hunt then
  return
 end
 del(ongoing_msgs,target_hunt_msg)
 target_hunt = false
 if _timeout then
  sfx(30,2)
  target_hunt_cnt = 0
  update_prog_light_group(pent_lights,target_hunt_cnt)
 end
 if cur_target then
  end_flash(cur_target.light)
  cur_target.sfx=14
  cur_target=nil
 end
end
