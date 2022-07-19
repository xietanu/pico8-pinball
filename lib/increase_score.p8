function increase_score(
 _scr,_offset,_not_multi
)
 if not _not_multi then
  _scr*=multiplier
 end
 add_to_long(score,_scr,_offset)
end