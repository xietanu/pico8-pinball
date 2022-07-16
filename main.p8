function _init()
 f=0

 modes={
  game={
   init=init_game,
   update=update_game,
   draw=draw_game
  }
 }
 mode = modes.game
 mode.init()
end

function _update60()
 f+=1

 mode.update()
end

function _draw()
 mode.draw()
end
