function point_collides_box(
 _p,_box
)
 local _box_collider=_box.simple_collider
 local _origin=_box.origin
	return _p.x>=_box_collider.x1+_origin.x and
		_p.x<=_box_collider.x2+_origin.x and
		_p.y>=_box_collider.y1+_origin.y and
		_p.y<=_box_collider.y2+_origin.y
end