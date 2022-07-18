function rotate_pnts(
	_points,_origin,_angle
)
	local _new_points={}
	for _pnt in all(_points) do
		local _pnt_o=subtract_vectors(_pnt,_origin)
  local _np =	add_vectors(
   _origin,
   vec(
    _pnt_o.x*cos(_angle)-_pnt_o.y*sin(_angle),
    _pnt_o.y*cos(_angle)+_pnt_o.x*sin(_angle)
   )
  )
  _np.c=_pnt.c
		add(_new_points,_np)
	end
	return _new_points
end