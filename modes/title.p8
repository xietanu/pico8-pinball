function init_title()
 stars={}
 for i=1,150 do
  local star=vec(
   flr(rnd(180))-26,flr(rnd(180))-26
  )
  star.c=rnd({12,7,6,5,13,15,1})
  add(stars,star)
 end
end

function update_title()
 stars=rotate_pnts(stars,vec(64,64),-1/(min(f,1000)*10))
 if btnp(⬇️) or btnp(❎) or btnp(🅾️) then
  mode=modes.game
  mode.init()
 end
end

function draw_title(_off_x)
 function even_circ(_x,_y,_r,_c)
  for i=0,1 do
   for j=0,1 do
    circfill(_x+i,_y+j,_r,_c)
   end
  end
 end

 cls(0)
 for _s in all(stars) do
  pset(_s.x,_s.y,_s.c)
 end

 even_circ(63,63,24,1)
 even_circ(63,63,23,12)

 if f==25 then
  music(0)
 end
 if f>30 and f<88 then
  base_angle=(f-30)/120
   for angle=0,0.07,0.001 do
   line(
    64-sin(-0.125-angle-base_angle)*23.5,
    64-cos(-0.125-angle-base_angle)*23.5,
    64-sin(-0.125+angle+base_angle)*23.5,
    64-cos(-0.125+angle+base_angle)*23.5,
    7
   )
  end
 end

 spr(160,40,40,6,6)

 print_shadow("terra nova",44,31,7,1)
 print_shadow("pinball",50,92,7,1)

 if f%60>25 then
  print("⬇️",60,110,7)
 end
end
