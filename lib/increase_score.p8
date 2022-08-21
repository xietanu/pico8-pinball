function increase_score(
 _scr,_offset,_not_multi
)
 if not _not_multi then
  _scr*=multiplier
 end
 if blastoff_mode then
  _scr*=2
 end
 add_to_long(score,_scr,_offset)
end