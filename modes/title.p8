function init_title()
 f = 0
 off_y=0
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

function draw_title()
 draw_title_foreground(off_y)

 if off_y==0 then
  print("⬇️",60,110,7)
 end
end

function even_circ(_x,_y,_r,_c)
 for i=0,1 do
  for j=0,1 do
   circfill(
    _x+i,
    _y+j,
    _r,
    _c
   )
  end
 end
end

function draw_title_foreground(_y_off)
 even_circ(63,63+_y_off,24,1)
 even_circ(63,63+_y_off,23,12)

 if f==25 then
  sfx(16)
 end
 if f>30 and f<88 then
  base_angle=(f-30)/120
   for angle=0,0.07,0.001 do
   line(
    64-sin(-0.125-angle-base_angle)*23.5,
    64-cos(-0.125-angle-base_angle)*23.5+_y_off,
    64-sin(-0.125+angle+base_angle)*23.5,
    64-cos(-0.125+angle+base_angle)*23.5+_y_off,
    7
   )
  end
 end

 spr(160,40,40+_y_off,6,6)

 print_shadow("terra nova",44,31+_y_off,7,1)
 print_shadow("pinball",50,92+_y_off,7,1)
end
