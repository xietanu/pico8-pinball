function init_title()
 f = 0
end

function update_title()
 stars=rotate_pnts(stars,vec(64,150),-0.0005)
 if btnp(⬇️) or btnp(❎) or btnp(🅾️) then
  if mode == modes.logo then
   f=20
  end
  mode=modes.menu
  mode.init()
 end
end

function draw_title(_off_y)
 _off_y = _off_y or 0

 function even_circ(_x,_y,_r,_c)
  for i=0,1 do
   for j=0,1 do
    circfill(
     _x+i,
     _y+j+_off_y,
     _r,
     _c
    )
   end
  end
 end

 cls(0)
 for _s in all(stars) do
  pset(_s.x,_s.y+_off_y/2.5,_s.c)
 end

 even_circ(63,63,24,1)
 even_circ(63,63,23,12)

 if f==25 then
  sfx(16)
 end
 if f>30 and f<88 then
  base_angle=(f-30)/120
   for angle=0,0.07,0.001 do
   line(
    64-sin(-0.125-angle-base_angle)*23.5,
    64-cos(-0.125-angle-base_angle)*23.5+_off_y,
    64-sin(-0.125+angle+base_angle)*23.5,
    64-cos(-0.125+angle+base_angle)*23.5+_off_y,
    7
   )
  end
 end

 spr(160,40,40+_off_y,6,6)

 print_shadow("terra nova",44,31+_off_y,7,1)
 print_shadow("pinball",50,92+_off_y,7,1)

 if f%60>25 and _off_y==0 then
  print("⬇️",60,110,7)
 end
 print("v "..version,2,2+min(_off_y,0),13)
 print("by matt sutton",71,2+min(_off_y,0),13)
 print("@xietanu",95,10+min(_off_y,0),13)
end
