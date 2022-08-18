function init_launch()
 cur_pinball=create_pinball(74,75)
 add(
  pinballs,
  cur_pinball
 )
 add(ongoing_msgs,launch_msg)
 released=false
 del(always_colliders,launch_block)
end

function update_launch()
 modes.game.update()

 if released then
  launcher.origin.y=min(cur_pinball.origin.y+0.51,80)
  if launcher.origin.y<=80 then
   released=false
  end
 else
  launcher.origin.y=limit(
   launcher.origin.y+(tonum(btn(⬇️))-tonum(btn(⬆️)))/4,
   80,
   100
  )
  if cur_pinball.origin.y>=launcher.origin.y then
   cur_pinball.origin.y=launcher.origin.y-0.51
   cur_pinball:get_last_pos().y=launcher.origin.y-0.511
  end
  if btnp(🅾️) or btnp(❎) then
   released=true
   cur_pinball.spd.y=launcher.origin.y-80
  end
 end
end
