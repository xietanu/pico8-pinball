function init_title()
 show_stars = true
 show_credits = true
 f = 0
 off_y=0
end

function update_title()
 rotate_stars()
 if btnp(⬇️) or btnp(❎) or btnp(🅾️) then
  sfx(16)
  mode=modes.menu
  mode.init()
 end
end

function rotate_stars(_angle)
 stars=rotate_pnts(stars,vec(64,150+off_y/2.5),_angle or -0.0005)
end

function draw_title()
 draw_title_foreground(off_y)

 if off_y==0 and f%60>20 then
  print_shadow("⬇️",60,110,7,1)
 end
end

function draw_title_foreground(_y_off)
 spr(112,40,30+_y_off,6,2)
 spr(160,40,48+_y_off,6,6)
end
