function draw_spr(_obj)
 if draw_outlines and _obj.collider!=nil then
  draw_collider(_obj)
 end

 local _off=add_vectors(_obj.origin,_obj.spr_off)
 local _w,_h=_obj.spr_w or 1,_obj.spr_h or 1
 spr(_obj.spr_i,_off.x,_off.y,_w,_h,_obj.flip_x,_obj.flip_y)
end
