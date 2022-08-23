function increase_score(
 _scr,_offset,_not_multi
)
 if (not _not_multi) _scr*=multiplier
 add_to_long(score,_scr,_offset)
end