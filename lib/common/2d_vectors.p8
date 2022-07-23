function vec(_x,_y,_ref_spd,_pnts,_only_ref)
 -- Create a vector object
 return {
  x=_x,
  y=_y,
  p=_pnts,
  ref_spd=_ref_spd,
  only_ref=_only_ref,
  plus=add_vectors,
  minus=subtract_vectors,
  copy=copy_vec,
  dot=dot_product,
  magnitude=magnitude,
  multiplied_by=multiply_vector,
  normalize=normalize,
  perpendicular=perpendicular
 }
end

function copy_vec(_v)
 -- Create a copy of a vector
 return vec(_v.x, _v.y,_v.ref_spd,_v.p,_v.only_ref)
end

function normalize(_v)
--Makes magnitude = 1
	return _v:multiplied_by(1/_v:magnitude())
end

function dot_product(_v1,_v2)
	return _v1.x*_v2.x+_v1.y*_v2.y
end

function perpendicular(_v)
	return vec(-_v.y,_v.x)
end

function multiply_vector(_v,_mul)
--Multiple a vector by a scalar.
	return vec(_v.x*_mul,_v.y*_mul)
end

function add_vectors(_v1,_v2)
	return vec(_v1.x+_v2.x,_v1.y+_v2.y)
end

function subtract_vectors(_v1,_v2)
	return vec(_v1.x-_v2.x,_v1.y-_v2.y)
end

function dist_between_vectors(_v1,_v2)
 return sqrt(
  (_v1.x-_v2.x)^2+(_v1.y-_v2.y)^2
 )
end

function magnitude(_v)
 return sqrt(_v.x^2+_v.y^2)
end
