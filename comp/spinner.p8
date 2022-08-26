function init_spinners()
 -- create spinner
 spinner={
  origin=vec(11.5,26.5),
  simple_collider={x1=-2,y1=-5,x2=2,y2=4},
  check_collision=check_collision_with_spinner,
  draw=draw_spinner,
  update=update_spinner,
  to_score=0
 }
 add(static_colliders,spinner)
 add(static_over,spinner)
end

function draw_spinner()
 -- draw spinner animation frame
 local spr_i = 33+16*flr((spinner.to_score/50)%4)
 spr(spr_i,spinner.origin.x-3,spinner.origin.y-4)
end

function check_collision_with_spinner(_s,_pin)
 -- check collision with spinner
 if spinner.deactivated then
  return
 end
 spinner.to_score = max(spinner.to_score,flr(min(6.123,abs(_pin.spd.y))*1000))
 if _pin.spd.y < 0 and not kickouts[2].bonus_enabled then
  sfx(23,3)
  enable_bonus(kickouts[2],180)
  cycle_lights(spinner_lights,1,3,flr(60/#spinner_lights))
 end
 spinner.deactivated = true
 add_to_queue(reactivate,30,{spinner})
end

function update_spinner()
 -- update spinner each frame
 if spinner.to_score > 0 then
  if f%ceil(5000/spinner.to_score)==0 then
   sfx(22)
  end
  local scr_change = min(spinner.to_score,max(10,flr(spinner.to_score*0.02)))
  spinner.to_score-=scr_change
  increase_score(scr_change)
 end
end
