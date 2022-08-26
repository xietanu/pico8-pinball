function _init()
 f=0

 version="1.0.0"
 cartdata("xietanu_terranovapinball_v1")
 if dget(0) == 0 then
  gen_highscores()
 end
 read_highscores()

 paddle_controls={
  {
   l=⬅️,
   r=➡️,
   ls="⬅️",
   rs="➡️",
   lc=12,
   rc=12
  },
  {
   l=🅾️,
   r=❎,
   ls="🅾️",
   rs="❎",
   lc=9,
   rc=8
  },
  {
   l=🅾️,
   r=➡️,
   ls="🅾️",
   rs="➡️",
   lc=9,
   rc=12
  }
 }

 pc_option=1

 modes={
  game={
   init=init_game,
   update=update_game,
   draw=draw_game
  },
  title={
   init=init_title,
   update=update_title,
   draw=draw_title
  },
  menu={
   init=init_menu,
   update=update_menu,
   draw=draw_menu
  },
  launch={
   init=init_launch,
   update=update_launch,
   draw=draw_game
  },
  game_over={
   init=init_game_over,
   update=update_game_over,
   draw=draw_game_over
  },
  logo={
   init=init_logo,
   update=update_title,
   draw=draw_logo
  },
  highscores={
   init=pass,
   update=update_highscores,
   draw=draw_highscores
  }
 }
 mode = modes.logo
 mode.init()
 music(3,0,1)
 menuitem(4,"music on",toggle_music)
end

function _update60()
 f+=1

 if transitioning then
  update_transition()
 end

 mode.update()
end

function _draw()
 cls()
 if show_stars then
  for _s in all(stars) do
   pset(_s.x,_s.y,_s.c)
  end
 end
 if show_credits then
  print_version_credits()
 end
 if transitioning then
  draw_transition()
 end
 mode.draw()
 pal()
end

function gen_highscores()
 dset(0,1)
 for i=1,40 do
  if i%4==0 then
   dset(i,13)
  else
   dset(i,0)
  end
 end
 dset(3,1)
 for i=0,9 do
  dset(6+i*4,900-i*100)
 end
end

function read_highscores()
 highscores={}
 for i = 0,36,4 do
  add(highscores,{dget(1+i),dget(2+i),dget(3+i),c=dget(4+i)})
 end
end

function write_highscores()
 for i=0,9 do
  for j=1,3 do
   dset(i*4+j,highscores[i+1][j])
  end
  dset(i*4+4,highscores[i+1].c)
 end
end

function toggle_music()
 local music_option
 music_off=not music_off
 if music_off then
  music_option="music off"
  music(-1,1000)
 else
  music_option="music on"
  music(3,0,1)
 end
 menuitem(4)
 menuitem(4,music_option,toggle_music)
end
