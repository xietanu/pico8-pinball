function gen_polygon(_pnts_str)
 -- create a list of vertices
 -- by unpacking a string
 -- args:
 -- _pnts_str (string): 
 --  string of a list of points
 local _pnts=split(_pnts_str)
 local _output = {}
 for i = 1,#_pnts,2 do
  add(_output,vec(_pnts[i],_pnts[i+1]))
 end
 return _output
end