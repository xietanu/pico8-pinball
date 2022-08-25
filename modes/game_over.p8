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

 for i=1,10 do
  if is_bigger_long(score,highscores[i]) then
   score.c=10
   add(highscores,score,i)
   del(highscores,#highscores)
   write_highscores()
   got_highscore=i
   return
  end
 end
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
 local _fc = get_frame({10,7,12,7},f,10)
 draw_table()
 draw_backboard(_fc)
 
 if f>10000 then
  f=0
 end

 local _lb = min(94,f*2)
 
 clip(81,36,47,_lb)

 rect(81,36,127,36+_lb,5)
 rectfill(82,37,126,126,0)

 print("game over!",84,39,10)

 draw_menu_items(90,51)
 if got_highscore>0 then
  print("new #"..got_highscore,84,114,_fc)
  print("highscore!",84,120,_fc)
 end
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
