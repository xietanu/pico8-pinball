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

 show_stars=true
 show_credits=true

 off_y=0

 modes.title.init()
end

function draw_logo()
 local max_col = limit(flr(f/4)+1,0,6)

 if f == 90 then
  init_transition(modes.title)
 elseif f < 90 then
  for grad in all(col_grads) do
   for i=1,6 do
    pal(grad[i],grad[min(i,max_col)])
   end
  end
 end

 spr(130,29,56,2,2)
 
 print_shadow("spaghettieis",47,59,7,8)
 print_shadow("games",47,65,7,8)
end

function print_version_credits()
 print("v "..version,2,2+off_y,13)
 print("by matt sutton",71,2+off_y,13)
 print("@xietanu",95,10+off_y,13)
end
