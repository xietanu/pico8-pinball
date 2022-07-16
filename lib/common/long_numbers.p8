function init_long(_l)
 local _o={}
 for i=1,_l do
  add (_o,0)
 end
 return _o
end

function add_to_long(_long,_to_add,_offset)
 _offset=_offset or 0
	_long[_offset+1]+=_to_add
 for i=_offset+2,#_long do
  if _long[i-1]>=1000 then
   _long[i]+=flr(_long[i-1]/1000)
   _long[i-1]=_long[i-1]%1000
  end
 end
end

function print_long(
	_long,
	_x,_y,_zero_col,_col
)
	local _n,_c=1,_zero_col
	for _plc = 1,#_long do
  local _num=_long[#_long-_plc+1]
		local _check_size = 100
		while _num < _check_size and 
			_check_size >= 1 do
   if _check_size==1 and _plc==#_long then
    _c=_col
   end
			print("0",_x,_y,_c)
			_x+=4
			_check_size/=10
		end
		if _num > 0 then
			_c=_col
			print(_num,_x,_y,_c)
			_x+=4*#tostr(_num)
		end
		if _n < #_long then
			print(",",_x,_y)
			_x+=3
		end
		_n+=1
	end
end