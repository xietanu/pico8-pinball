function vec(_x,_y)
 -- Create a vector object
 -- args:
 -- _x: The x coordinate
 -- _y: The y coordinate
 return {x=_x, y=_y}

function copy_vec(_v)
 -- Create a copy of a vector
 -- args:
 -- _v: The vector to copy
 return vec(v.x, v.y)

function normalize(_v)
--Normalize a vector
--Makes magniture = 1
	local _mag=magnitude(_v)
	return {
  x=_v.x/_mag,
  y=_v.y/_mag
 }
end

function dot_product(_v1,_v2)
	return _v1.x*_v2.x+_v1.y*_v2.y
end

function perpendicular(_v)
	return {
  x=-_v.y,
  y=_v.x
 }
end

function vector_between(_p1,_p2)
--Returns the vector between 2
--points
	return {
		x=_p2.x-_p1.x,
  y=_p2.y-_p1.y
	}
end

function multiply_vector(_v,_mul)
--Multiple a vector by a scalar.
	return {
  x=_v.x*_mul,
  y=_v.y*_mul
 }
end

function add_vectors(_v1,_v2)
	return {
		x=_v1.x+_v2.x,
  y=_v1.y+_v2.y
	}
end

function subtract_vectors(_v1,_v2)
	return {
		x=_v1.x-_v2.x,
  y=_v1.y-_v2.y
	}
end

function dist_between_vectors(_v1,_v2)
 return sqrt(
  (_v1.x-_v2.x)^2+(_v1.y-_v2.y)^2
 )
end

function magnitude(_v)
 return sqrt(_v.x^2+_v.y^2)
end
