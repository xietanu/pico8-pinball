function init_highscores()
 reset_highscores_cnt=0
end

function update_highscores()
 rotate_stars()
 if btnp(❎) then
  init_transition(modes.menu)
 end
 if btn(🅾️) then
  reset_highscores_cnt+=0.5
  if reset_highscores_cnt>=61 then
   gen_highscores()
   read_highscores()
   reset_highscores_cnt=0
  end
 else
  reset_highscores_cnt=0
 end
end

function draw_highscores()
 print_shadow("highscores",44,3,7,8)
 for i = 1,10 do
  print(i..".",35,10*i+2,12)
  print_long(highscores[i],50,10*i+2,5,highscores[i].c)
 end
 print_shadow("❎: back",7,114,7,13)
 if reset_highscores_cnt>0 then
  rectfill(62,112,61+reset_highscores_cnt,120,8)
 end
 print_shadow("hold 🅾️: reset",64,114,7,13)
end
