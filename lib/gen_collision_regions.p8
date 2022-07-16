function gen_collision_regions(
 _collider_objs,
 _x1,_y1,
 _x2,_y2,
 _side_length
)
 local _col_regions = {}
 for i=_x1,_x2,_side_length do
  local _col_col={}
  for j=_y1,_y2,_side_length do
   local _r_x1=i-1
   local _r_x2=i+_side_length+1
   local _r_y1=j-1
   local _r_y2=j+_side_length+1
   local _col_row={}
   for _obj in all(_collider_objs) do
    local _col = _obj.simple_collider
    local _org = _obj.origin
    if (_r_x1 <= _col.x2+_org.x and _r_x2 >= _col.x1+_org.x and
     _r_y1 <= _col.y2+_org.y and _r_y2 >= _col.y1+_org.y) then
     add(_col_row,_obj)
    end 
   end
   add(_col_col,_col_row)
  end
  add(_col_regions,_col_col)
 end
 return _col_regions
end