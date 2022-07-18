function print_shadow(
 _text,
 _x,
 _y,
 _col,
 _s_col
)
 -- print text with drop shadow
 -- args:
 -- _text (string): text to
 --  print
 -- _x (int): x coord of start
 -- _y (int): y coord of start
 -- _col (int): colour of text
 -- _s_col (int): colour of
 --  the shadow
 for i=-1,1 do
  for j=-1,1 do
   print(
    _text, _x+i, _y+j, _s_col
   )
  end
 end
 print(_text, _x, _y, _col)
end
