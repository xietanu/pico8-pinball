function draw_collider(_obj)
 local _pnts=_obj.collider
 local _origin=_obj.origin
 local _n_pnts=#_pnts
 if not _obj.complete then
  _n_pnts-=1
 end
	for i=1,_n_pnts do
  j=i%#_pnts+1
  local _col= _pnts[i].c or _obj.c
  line(
   _pnts[i].x+_origin.x,
   _pnts[i].y+_origin.y,
   _pnts[j].x+_origin.x,
   _pnts[j].y+_origin.y,
   _col
  )
 end
end
