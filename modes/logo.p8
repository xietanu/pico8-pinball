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
  pset(_s.x,_s.y+127/2.5,_s.c)
 end

 if f < 100 then
  local max_col=min(11,flr(f/3)+1)
  for i=1,11 do
   pal(logo_cols[i],logo_cols[min(max_col,i)])
  end
 elseif f < 135 then
  local max_col=max(1,7-flr((f-120)/3))
  for i=1,11 do
   pal(logo_cols[i],logo_cols[min(max_col,i)])
  end
 elseif f < 177 then
  draw_title(max(0,127-(f-135)*3))
  return
 else
  mode = modes.title
  mode.init()
  mode.draw()
  return
 end
 
 spr(130,29,56,2,2)
 
 print_shadow("spaghettieis",47,59,7,8)
 print_shadow("games",47,65,7,8)
 print("v "..version,2,2,13)
 print("by matt sutton",71,2,13)
 print("@xietanu",95,10,13)

 pal()
end