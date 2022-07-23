function gen_simple_collider(_col)
 local _out={
  x1=_col[1].x,
  y1=_col[1].y,
  x2=_col[1].x,
  y2=_col[1].y,
 }
 for _pnt in all(_col) do
  _out.x1=min(_out.x1,_pnt.x)
  _out.y1=min(_out.y1,_pnt.y)
  _out.x2=max(_out.x2,_pnt.x)
  _out.y2=max(_out.y2,_pnt.y)
 end
 _out.x1-=1
 _out.y1-=1
 _out.x2+=1
 _out.y2+=1
 return _out
 
end
