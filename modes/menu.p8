function init_menu()
 show_stars = true
 show_credits = false
 f_base=f
 options={
  {func=function()
   init_transition(modes.game)
  end,
  text={"start"},
  base_y=75
  },
  {
   text={"highscores"},
   base_y=85,
   func=function()
    init_transition(modes.highscores)
   end
  },
  {
   text={"paddle controls:"},
   base_y=95,
   func=function()
   pc_option=mod(
    pc_option+1,
    #paddle_controls
   )
   end
  }
 }
 selected_option=1
 pad_con=paddle_controls[pc_option]
end

function update_menu()
 off_y=max(-28,-(f-f_base))

 rotate_stars(-0.00025)

 if mode==modes.transition then
  return
 end

 update_menu_items()

 if selected_option == 3 then
  pc_option=mod(
  pc_option+tonum(btnp(➡️))-tonum(btnp(⬅️)),
  #paddle_controls
 )
 end

 pad_con=paddle_controls[pc_option]
end

function update_menu_items()
 if btnp(⬇️) or btnp(⬆️) then
  selected_option=mod(
   selected_option+tonum(btnp(⬇️))-tonum(btnp(⬆️)),
   #options
  )
  sfx(0)
 end

 if btnp(🅾️) or btnp(❎) then
  options[selected_option].func()
  sfx(13)
 end
end

function draw_menu()
 draw_title()
 print_version_credits()

 draw_menu_items(32,28+off_y,true)

 local _off_y_m4=off_y*4

 sspr(
  16,44,
  11,11,
  51,214+_off_y_m4
 )
 sspr(
  16,44,
  11,11,
  66,214+_off_y_m4,
  11,11,
  true
 )
 print_shadow(pad_con.ls,52,228+_off_y_m4,button_cols[pad_con.ls],1)
 print_shadow(pad_con.rs,68,228+_off_y_m4,button_cols[pad_con.rs],1)
 if selected_option == 3 then
  print(chr(22),40.5+sin(f/60),222.5+_off_y_m4+cos(f/143),7)
  print(chr(23),84.5+sin(f/60),222.5+_off_y_m4+cos(f/143),7)
 end
end
