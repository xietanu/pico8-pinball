function init_game_over()
 for _sc in all(static_over) do
  _sc.lit = false
 end
 for _sc in all(static_under) do
  _sc.lit = false
 end
 f=0

 options = {
  {
   text={"play","again"},
   action=quick_restart,
   base_y = 0
  },
  {
   text={"menu"},
   action=game_over_to_menu,
   base_y = 20
  }
 }

 selected_option = 1
end

function update_game_over()
 selected_option=mod(
  selected_option+tonum(btnp(⬇️))-tonum(btnp(⬆️)),
  #options
 )

 if btnp(🅾️) or btnp(❎) then
  options[selected_option].action()
 end
end

function draw_game_over()
 cls()
 draw_table()
 draw_headboard(get_frame({10,7,12,7},f,10))
 
 clip(82,40,45,min(87,f*2))

 rectfill(82,40,126,126,0)

 print("game over!",84,42,10)

 for i=1,#options do
  local _o=options[i]
  local _y = _o.base_y+55
  if selected_option == i then
   print(chr(23),84.5+sin(f/60),_y+(3*(#_o.text-1)),8)
   local _yo = 0
   for _text in all(_o.text) do
    print_shadow(_text,90,_y+_yo,7,8)
    _yo+=6
   end
  else
   local _yo = 0
   for _text in all(_o.text) do
    print(_text,90,_y+_yo,7)
    _yo+=6
   end
  end
 end
end

function quick_restart()
 mode = modes.game
 mode.init()
end

function game_over_to_menu()
 init_transition(modes.menu)
end
