function init_launch()
 cur_pinball=create_pinball(vec(74,75))
 
 if reset_light.lit then
  add(msgs,{"relaunch",t=90})
 else
  balls-=1
 end
 reset_light.lit = not reset_light.lit
 add(ongoing_msgs,launch_msg)
 released=false
 del(always_colliders,launch_block)

 refuel_lights_lit=-1
 light_refuel_lights()

 disable_bonus(kickouts[2])
 disable_bonus(kickouts[3])

 reset_drain(left_drain)
 reset_drain(right_drain)
 multiplier = 1
end

function update_launch()
 modes.game.update()

 if released then
  launcher.origin.y=max(cur_pinball.origin.y+0.51,80)
  if launcher.origin.y<=80 then
   released=false
  end
 else
  launcher.origin.y=limit(
   launcher.origin.y+(tonum(btn(⬇️))-tonum(btn(⬆️)))/4,
   80,
   100
  )
  if (btn(⬇️) or btn(⬆️)) and f%7==0 then
   sfx(22)
  end
  if cur_pinball.origin.y>=launcher.origin.y then
   cur_pinball.origin.y=launcher.origin.y-0.51
   cur_pinball.last_pos.y=launcher.origin.y-0.511
  end
  if btnp(🅾️) or btnp(❎) then
   released=true
   if cur_pinball.origin.y >=80 then
    cur_pinball.spd.y=-sqrt((launcher.origin.y-80))
    sfx(8)
   end
  end
 end
end
