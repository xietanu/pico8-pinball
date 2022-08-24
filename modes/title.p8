function init_title()
 show_stars = true
 show_credits = true
 f = 0
 off_y=0
end

function update_title()
 rotate_stars()
 if btnp(⬇️) or btnp(❎) or btnp(🅾️) then
  if (mode == modes.logo) f=20
  mode=modes.menu
  mode.init()
 end
end

function rotate_stars(_angle)
 stars=rotate_pnts(stars,vec(64,150+off_y/2.5),_angle or -0.0005)
end

function draw_title()
 draw_title_foreground(off_y)

 if off_y==0 then
  print("⬇️",60,110,7)
 end
end

function draw_title_foreground(_y_off)

 if f==25 then
  sfx(16)
 end

 spr(160,40,40+_y_off,6,6)

 print_shadow("terra nova",44,31+_y_off,7,1)
 print_shadow("pinball",50,92+_y_off,7,1)
end
