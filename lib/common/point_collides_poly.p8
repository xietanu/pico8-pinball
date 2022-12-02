function point_collides_poly(
 _p,_obj
)
	local _pnts={}
 
 for _pnt in all(_obj.collider) do
  add(
   _pnts,
   {
    x=_pnt.x+_obj.origin.x,
    y=_pnt.y+_obj.origin.y
   }
  )
 end
	
	for i=1,#_pnts do
		local j=mod(i+1,#_pnts)
		if not below_line(
				_p,_pnts[i],_pnts[j]
			) then
   return false
  end
	end
 return true
end


function below_line(_p,_l1,_l2)
 local v1 = vec(
  _l2.x-_l1.x,
  _l2.y-_l1.y
 )
 local v2 = vec(
  _p.x-_l1.x,
  _p.y-_l1.y
 )
 return v1.x*v2.y - v1.y*v2.x > 0
end
