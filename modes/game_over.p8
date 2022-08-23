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
 draw_table()
 draw_headboard(get_frame({10,7,12,7},f,10))
 
 if f>10000 then
  f=0
 end
 clip(82,40,45,min(87,f*2))

 rectfill(82,40,126,126,0)

 print("game over!",84,42,10)

 draw_menu_items(55)
 clip()
end

function quick_restart()
 mode = modes.game
 mode.init()
end

function game_over_to_menu()
 init_transition(modes.menu)
end

function draw_menu_items(_x,_y_off,_i_multi)
 for i=1,#options do
  local _o=options[i]
  local _y = _o.base_y
  if _i_multi then
   _y+=_y_off*(i*2)
  else
   _y+=_y_off
  end
  if selected_option == i then
   print(chr(23),_x-5.5+sin(f/60),_y+(3*(#_o.text-1)),8)
   local _yo = 0
   for _text in all(_o.text) do
    print_shadow(_text,_x,_y+_yo,7,8)
    _yo+=6
   end
  else
   local _yo = 0
   for _text in all(_o.text) do
    print(_text,_x,_y+_yo,7)
    _yo+=6
   end
  end
 end
end
