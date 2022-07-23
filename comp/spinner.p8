function init_spinners()
 -- create spinner
 spinner={
  origin=vec(35,4),
  simple_collider={x1=-2,y1=-5,x2=2,y2=4},
  check_collision=check_collision_with_spinner,
  draw=draw_spinner,
  update=update_spinner,
  to_score=0
 }
 add(static_colliders,spinner)
 add(static_over,spinner)
 add(to_update,spinner)
end

function draw_spinner(_s)
 -- draw spinner animation frame
 local spr_i = 36+16*flr((_s.to_score/400)%4)
 spr(spr_i,_s.origin.x-3,_s.origin.y-4)
end

function check_collision_with_spinner(_s,_pin)
 -- check collision with spinner
 _s.to_score = max(_s.to_score,flr(min(6.123,magnitude(_pin.spd))*5000))
 captures[2].bonus_timer=90
end

function update_spinner(_s)
 -- update spinner each frame
 if _s.to_score > 0 then
  local scr_change = min(_s.to_score,max(25,flr(_s.to_score*0.02)))
  _s.to_score-=scr_change
  increase_score(scr_change)
 end
end
