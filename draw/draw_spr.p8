function draw_spr(_obj)
 local _spr=_obj.spr_coords
 if _obj.hit > 0 and not transitioning then
  _spr=_obj.hit_spr_coords or _spr
  pal(_obj.unlit_col or 8,9)
  _obj.hit-=1
 elseif _obj.lit and not transitioning then
  pal(_obj.unlit_col or 8,10)
 end
 local _off=_obj.origin:plus(_obj.spr_off)
 local _w,_h=_obj.spr_w,_obj.spr_h
 sspr(_spr.x,_spr.y,_w,_h,_off.x,_off.y,_w,_h,_obj.flip_x,_obj.flip_y)
 if not transitioning then
  pal()
 end
end
