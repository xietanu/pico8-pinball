function print_shadow(
 _text,
 _x,
 _y,
 _col,
 _s_col
)
 -- print text with drop shadow
 for i=-1,1 do
  for j=-1,1 do
   print(
    _text, _x+i, _y+j, _s_col
   )
  end
 end
 print(_text, _x, _y, _col)
end
