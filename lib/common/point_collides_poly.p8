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
	
	local _collides=true
	
	for i=1,#_pnts do
		local j=mod(i+1,#_pnts)
		_collides=_collides and
			below_line(
				_p,_pnts[i],_pnts[j]
			)
	end
 return _collides
end


function below_line(_p,_l1,_l2)
 if _l1.x==_l2.x then
  return sgn(_p.x-_l1.x)==sgn(_l1.y-_l2.y)
 end


	local _m,_c = calc_m_c(
		_l1,_l2
	)
	return sgn(_m*_p.x-_p.y+_c)==sgn(_l1.x-_l2.x)
end

function crossed_line(
	_p1,_p2,_l1,_l2
)
 if _l1.x==_l2.x then
  return sgn(_p1.x-_l1.x)!=sgn(_p2.x-_l1.x)
 end

	local _m,_c=calc_m_c(_l1,_l2)
	return sgn(
		_m*_p1.x-_p1.y+_c
	)!=sgn(
		_m*_p2.x-_p2.y+_c
	)
end

function calc_m_c(_p1,_p2)
--Calculate gradient and
--intercept for line going
--though _p1 and _p2.
--Returns nils if vertical.
 if _p1.x==_p2.x then
  return nil,nil
 end

	local _m=_p1.y-_p2.y
	_m/=_p1.x-_p2.x
 
	return _m,_p1.y-_m*_p1.x
end
