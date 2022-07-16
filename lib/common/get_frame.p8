function get_frame(_frames,_f,_spd,_f_start)
 _f_start=_f_start or 0
	return _frames[
		flr((_f-_f_start)/_spd)%#_frames+1
	]
end