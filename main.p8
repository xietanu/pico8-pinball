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
  }
 }
 mode = modes.title
 mode.init()
end

function _update60()
 f+=1

 mode.update()
end

function _draw()
 mode.draw()
end
