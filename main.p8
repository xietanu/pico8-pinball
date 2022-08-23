function _init()
 f=0

 version="0.1.0a"

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
  }
 }
 mode = modes.logo
 mode.init()
end

function _update60()
 f+=1

 if transitioning then
  update_transition()
 end

 mode.update()
end

function _draw()
 if transitioning then
  draw_transition()
 end
 mode.draw()
 pal()
end
