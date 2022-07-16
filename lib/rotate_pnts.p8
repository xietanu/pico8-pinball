function rotate_pnts(
	_points,_origin,_angle
)
	local _new_points={}
	for _pnt in all(_points) do
		local _pnt_o=subtract_vectors(_pnt,_origin)
		add(_new_points,
			add_vectors(
				_origin,
				{
					x=_pnt_o.x*cos(_angle)-_pnt_o.y*sin(_angle),
					y=_pnt_o.y*cos(_angle)+_pnt_o.x*sin(_angle)
				}
			)
		)
	end
	return _new_points
end