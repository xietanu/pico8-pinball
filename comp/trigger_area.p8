function init_launch_triggers()
 launch_triggers={
  create_trigger_area(
   create_box_collider(71,22,78,27)
  ),
  create_trigger_area(
   create_box_collider(65,22,71,37)
  )
 }
 for _l in all(launch_triggers) do
  add(static_colliders,_l)
 end
end

function create_trigger_area(
 _simple_collider
)
 return {
  origin=vec(0,0),
  simple_collider=_simple_collider,
  check_collision=exit_launch_mode
 }
end

function exit_launch_mode(_l)
 if mode!=modes.launch then
  return
 end
 mode=modes.game
 add(always_colliders,launch_block)
 del(ongoing_msgs,launch_msg)
 if reset_light.lit then
  enable_bonus(skillshot_target,80)
 end
 add_to_queue(set_light,900,{reset_light,false})
end

