function calc_reflection_vector(
 _v,
 _l
)
	return _v:minus(_l:multiplied_by(2*_v:dot(_l)))
end

function bounce_off_line(_pin,_l)
 local normalized_perp_vec = perpendicular(normalize(_l):multiplied_by(0.9))
 if _l.only_ref then
  _pin.spd=normalized_perp_vec:multiplied_by(_l.ref_spd)
 else
  _pin.spd = calc_reflection_vector(
    _pin.spd,
    normalized_perp_vec
  )

  if _l.ref_spd then
   _pin.spd = _pin.spd:plus(normalized_perp_vec:multiplied_by(_l.ref_spd))
  end
 end
end
