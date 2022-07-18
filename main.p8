function _init()
 f=0

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
