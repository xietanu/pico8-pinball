function init_launch_triggers()
 launch_triggers={
  create_trigger_area(
   vec(0,0),
   create_box_collider(71,22,78,27),
   exit_launch_mode
  ),
  create_trigger_area(
   vec(0,0),
   create_box_collider(65,22,71,37),
   exit_launch_mode
  )
 }
 for _l in all(launch_triggers) do
  add(static_colliders,_l)
 end
end

function create_trigger_area(
 _origin,
 _simple_collider,
 _action
)
 return {
  origin=_origin,
  simple_collider=_simple_collider,
  check_collision=_action
 }
end

function exit_launch_mode(_l)
 if mode!=modes.launch then
  return
 end
 mode=modes.game
 add(always_colliders,launch_block)
 skillshot_target.reset_timer=80
end

