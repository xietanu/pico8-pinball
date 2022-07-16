function calc_reflection_vector(
 _v,
 _l
)
--Args:
-- _p_v (vector): velocity
--   vector of object.
-- _l_v (vector): vector to 
--   bounce off of.
	
	local _d=dot_product(
		_v,_l
	)
	
	return subtract_vectors(
			_v,multiply_vector(_l,2*_d)
		)
end

function bounce_off_line(_pin,_l)
 local normalized_perp_vec = perpendicular(
    multiply_vector(normalize(_l),0.9)
   )
 if _l.only_ref then
  _pin.spd=multiply_vector(normalized_perp_vec,_l.ref_spd)
 else
  _pin.spd = calc_reflection_vector(
    _pin.spd,
    normalized_perp_vec
  )

  if _l.ref_spd != nil then
   _pin.spd = add_vectors(_pin.spd,multiply_vector(normalized_perp_vec,_l.ref_spd))
  end
 end
end
