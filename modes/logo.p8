function init_logo()
 stars={}
 for i=1,400 do
  local star=vec(
   flr(rnd(400))-136,
   flr(rnd(400))-66
  )
  star.c=rnd({12,7,6,5,13,15,1})
  add(stars,star)
 end

 logo_cols={0,0,0,2,2,4,8,14,15,6,7}
 logo_cols_off={0,0,0,0,0,0,0,0,0,0,2,4,8,14,15,6,7}

 modes.title.init()
end

function draw_logo()
 cls(0)
 for _s in all(stars) do
  pset(_s.x,_s.y,_s.c)
 end
 print_version_credits()

 local max_col = 0

 if f < 90 then
  max_col=limit(flr(f/4)+1,0,6)
 elseif f < 125 then
  max_col=limit(5-flr((f-90)/4),0,6)
 elseif f < 140 then
  max_col=limit(flr((f-125)/4)+1,0,6)
  for grad in all(col_grads) do
   for i=1,6 do
    pal(grad[i],grad[min(i,max_col)])
   end
  end

  even_circ(63,63,24,1)
  even_circ(63,63,23,12)

  spr(160,40,40,6,6)

  print_shadow("terra nova",44,31,7,1)
  print_shadow("pinball",50,92,7,1)

  pal()
  return
 else
  mode = modes.title
  mode.init()
  mode.draw()
  return
 end

 for grad in all(col_grads) do
  for i=1,6 do
   pal(grad[i],grad[min(i,max_col)])
  end
 end
 
 spr(130,29,56,2,2)
 
 print_shadow("spaghettieis",47,59,7,8)
 print_shadow("games",47,65,7,8)
 pal()
end

function print_version_credits(_y_off)
 _y_off = _y_off or 0
 print("v "..version,2,2+_y_off,13)
 print("by matt sutton",71,2+_y_off,13)
 print("@xietanu",95,10+_y_off,13)
end
