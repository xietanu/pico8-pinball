pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
function _init()
 tick=0
 cursor={x=40,y=64,c=7}
 xspd=0
 yspd=0
 pnts={}
 selected = nil
 printh("","@clip")
 paste_buffer=stat(4)
 msg_t=0
 msg=""
end

function _update()
 tick+=1
 if tick%15 == 0 then
  cursor.c=13-cursor.c
 end

 if btn(➡️) and btn(⬅️) then
  copy_points()
  paste_buffer=stat(4)
  msg="copied"
  msg_t=30
  return
 end

 if stat(4)!=paste_buffer then
  paste_buffer=stat(4)
  paste_points()
  msg="pasted"
  msg_t=30
  return
 end

 if btn(➡️) or btn(⬅️) then
  xspd=limit(xspd+(tonum(btn(➡️))-tonum(btn(⬅️)))*0.1,-2.5,2.5)
 else
  xspd=0
 end

 if btn(⬇️) or btn(⬆️) then
  yspd=limit(yspd+(tonum(btn(⬇️))-tonum(btn(⬆️)))*0.1,-2.5,2.5)
 else
  yspd=0
 end
 cursor.x+=xspd 
 cursor.y+=yspd

 if btnp(🅾️) then
  if selected then
   selected = nil
  else
   local _npnt = {x=flr(cursor.x),y=flr(cursor.y)}
   local _exists = contains(pnts,_npnt)
   if _exists == nil then
    add(pnts,{x=flr(cursor.x),y=flr(cursor.y)})
   else
    selected = _exists
   end
  end
 end
 if btnp(❎) then
  del(pnts,pnts[#pnts])
 end

 if selected then
  selected.x=flr(cursor.x)
  selected.y=flr(cursor.y)
 end

 msg_t=max(0,msg_t-1)
 if msg_t == 0 then
  msg=""
 end
end

function paste_points()
 local _pnts_coords=split(stat(4))
 for i = 1,#_pnts_coords,2 do
  local _npnt = {x=_pnts_coords[i],y=_pnts_coords[i+1]}
  if contains(pnts,_npnt) == nil then
   add(pnts,{x=_pnts_coords[i],y=_pnts_coords[i+1]})
  end
 end
end

function contains(list,obj)
 local _exists = nil
 for p in all(pnts) do
  if p.x == obj.x and p.y == obj.y then
   _exists = p
  end
 end
 return _exists
end

function copy_points()
 local paste = ""
 for p in all(pnts) do
  paste=paste..p.x..","..p.y..","
 end
 paste=sub(paste,1,-2)
 printh(paste,"@clip")
end

function _draw()
 cls()
 map()
 
 if #pnts > 1 then
  for i = 2,#pnts do
   line(pnts[i].x,pnts[i].y,pnts[i-1].x,pnts[i-1].y,12-5*(flr(tick/15)%2))
  end
 end

 draw_cursor()

 for p in all(pnts) do
  circ(p.x,p.y,1,8)
 end
 print(msg,82,2,8)
end

function limit(v,mn,mx)
 return min(mx,max(v,mn))
end

function draw_cursor()
 line(cursor.x-1, cursor.y,cursor.x-2,cursor.y,cursor.c)
 line(cursor.x+1, cursor.y,cursor.x+2,cursor.y,cursor.c)
 line(cursor.x, cursor.y-1,cursor.x,cursor.y-2,cursor.c)
 line(cursor.x, cursor.y+1,cursor.x,cursor.y+2,cursor.c)
end

__gfx__
000000000000f0000000000077000575660660d068607000dddddddddddddddddddddddddddddddddd777777777777777ddddddddddddddddddddddddddddddd
0000000000072f0000000077700007666886806068607000dddddddddddddddddddddddddddd777777000000000000000777777ddddddddddddddddddddddddd
0070070000072f0000007777000005d5688680d068600000dddddddddddddddddddddddddd7700000000000000000d00000000077ddddddddddddddddddddddd
0007700000788f0000777770000000006806800060600000dddddddddddddddddddddddd77000000000000000000000000000000077ddddddddddddddddddddd
0007700000722f007777700000000000680600000000f000ddddddddddddddddddddd7770000000000000000000000000000000000077ddddddddddddddddddd
0070070000728f0072770000000000000060604000072f00dddddddddddddddddddd7700000000000000000000000000000000000000077ddddddddddddddddd
0000000000728f0077700000000000000660044400072f00ddddddddddddddddddd7700000000000000000000000000000000000000000077ddddddddddddddd
0000000007222f0000000000000000006600604000788f00dddddddddddddddd777000000000000000eeeeeeee0000000000000000000000077ddddddddddddd
0088880007882f0000000000000000006000000000722f00ddddddddddddddd7700000000000000eeeeeeeeeee00000000000000000000000077dddddddddddd
08dddc8007282f0000000000000000004040000007028f00dddddddddddddd770000000000000eee0000000eee000000000000000000000000077ddddddddddd
8dccdcd807222f0000000000000000004440000007028f00ddddddddddddd770000006000000ee00000000000e0000000000000000000000000077dddddddddd
85c88cd87282f00000000000000000000400000070222f00dddddddddddd770000000000000ee000000000000000000000000000000000000000077ddddddddd
81d88dc8f2ff000000000000000000000000000070882f00ddddddddddd77000000000000eee000000d0000000000000000000000000000000000077dddddddd
851cccd80f00000000000000000000000000000070282f00ddddddddddd7000000000000ee00000000000000000000000000060000000000000000077ddddddd
085555800000000000000077770000000000000070222f00ddddddddddd700000000000ee000000000000000000000000000000000000000000000007ddddddd
00888800000000007777777770000000000000007282f000dddddddddd70000000000eee00000000000000000000000000000000000000000050000077dddddd
0088880000080000727777000000000000000000f2ff0000dddddddddd7000000000eee00000000000000ed0000e0000000000000000000000000000077ddddd
08776680000800007770000000000000000600000f000000ddddddddd7000000000eee000000000e00000e00000e00000e0000000000000000000000007ddddd
875776780087800000000000000000000076700000066066ddddddddd7000000000ee0000000000e00000e00000e00000e00000000000000000000000007dddd
867887780087800000000000000000000076700000886086ddddddddd700000000eee0000000000e00000e00000e00000e00000000000000000000000007dddd
857886780082800000000000000000000076700000886086ddddddddd700000000ee00000000000e00000000000000000e000000000000000000000000007ddd
866777780822280000000000000000000076700000086086ddddddddd70000000ee000000e00000000000000000000000000000e000000000000000000007ddd
086556800822280000000000000000000006000000086006dddddddd700000000ee000000e00000000000000000000000000000e000000000000000000007ddd
008888000822280000000000000000000000000000000000dddddddd70000000ee0000000e0000000000000000000d000000000e000000000000000000007ddd
008888000827280000000000000000000000000000000000dddddddd70000000ee0000000e00000060000000000000000000000e000000000000000000007ddd
08cccc800872780000000000000000000006000000000000dddddddd70050000ee00000000000000000000000000000000000000000000000000000000007ddd
877cc7780822280077777700000000000776770000000000dddddddd70000000ee00000000000000000000000000000000000000000000000000000060007ddd
81b88bc88222228072777777777000000776770000000000dddddddd70000000ee000000000000000000000000000000000000d0000000000000000000007ddd
89a887788282828077777700000000000776770000000000dddddddd70000000ee00000000000000000000500000000000000000000000000000000000007ddd
81366bc88288828000000000000000000776770000000000dddddddd70000000ee00000000000000000000000000000000000000000000000000000000007ddd
08133b808800088000000000000000000006000000000000dddddddd70000000ee0000060000000000000000000d0600000000000000000000000000000e7ddd
008888008000008000000000000000000000000000000000dddddddd70000000ee000000000000005000000000000000000000000000000000000000000e7ddd
008888000000000000000000000000000000000000000000dddddddd70000000ee00000000000000000000000000000000000000000000000000000000e07ddd
08eeeb800000000000000000000000000006000000000000dddddddd77000000ee00000000000000000000000000000000000000000000000000000000e07ddd
8bbbbbb80000000000000000000000000066600000000000ddddddddd7000000eee000000000000000000000000000000000000000000000005000000e007ddd
82b88ee80000000000000000000000000066600000000000ddddddddd70000000ee000000000000000000000000000000000000000000000000000007e007ddd
82e88eb80000000000000000000000000066600000000000ddddddddd70060000ee0000000000000006000000000000000000000005000000000000770007ddd
833bbbe80000000077700000000000000066600000000000ddddddddd700000000e0000000000000000000000000000000000000000000000000007770007ddd
08222e800000000072777700000000000006000000000000ddddddddd770000000ee0000000000000000000000d0500000000000000000000000077d70007ddd
008888000000000077777777700000000000000000000000dddddddddd70000000ee00000000000000000000000000000000000000000000000077dd70007ddd
000000000000000000000077770000000000000000000000dddddddddd700000000e0000000000000000000000000000000000000000000000777ddd70007ddd
000000000000000000000000000000000006000000000000dddddddddd770000000ee0000000000000000000000000000000d00000000000777ddddd70007ddd
000000000000000000000000000000000007000000000000ddddddddddd700000000e00000000000000000000000000000000000000007777ddddddd70007ddd
000000000000000000000000000000000007000000000000ddddddddddd700000000000000000000000000000000000000000000007777dddddddddd70007ddd
000000000000000000000000000000000007000000000000ddddddddddd770000000000000000600000000000000000000000000777ddddddddddddd70007ddd
000000000000000000000000000000000007000000000000dddddddddddd700000000000000000000000000000000000000007777ddddddddddddddd70007ddd
000000000000000000000000000000000006000000000000dddddddddddd770000000000000000050000000000600000000777dddddddddddddddddd70007ddd
000000000000000000000000000000000000000000000000ddddddddddddd700000000000000000000000000000000000007dddddddddddddddddddd70007ddd
000000000000000077700000000000000000000000000000dddddddddddd7700000000000000000000000000000000000007dddddddddddddddddddd70007ddd
000000000000000072770000000000000000000000000000dddddddddd7770000000000000000000000000000000000000077ddddddddddddddddddd70007ddd
000000000000000077777000000000000000000000000000ddddddd77770000000000000000000000000000000000000000077dddddddddddddddddd70007ddd
000000000000000000777770000000000000000000000000dddddd7777000000000000000000000000000000000000000000077ddddddddddddddddd70007ddd
000000000000000000007777000000000000000000000000dddddd7700000060000000d000000000000000000500000000000077dddddddddddddddd70007ddd
000000000000000000000077700000000000000000000000dddddd770000000000000000000000000000000000000000000000077ddddddddddddddd70007ddd
000000000000000000000000770000000000000000000000dddddd7700000000000000000000000000000000000000000000000077dddddddddddddd70007ddd
000000000000000000000000000000000000000000000000dddddd77770000000000000000dd0000000000000000000000000000077ddddddd77777d70007ddd
660006600000000000000000000000000000000000000000ddddddd7777777000000000000d200000000000000000000000000000077ddddd777777770007ddd
866008660000000000000000000000000000000000000000dddddddddddddd7770000000001200000000000000000000000d000000077dddd777077770007ddd
886600866000000000000000000000000000000000000000dddddddddddddddd7000000000120000000600000000000006000000000077dd7700007770007ddd
088660086600000000000000000000000000000000000000dddddddddddddddd7000000000112000000000000000000000000000000007777000077770007ddd
008860008600000000000000000000000000000000000000ddddddddddddddd7000000500011200000000000000000000000000000000070000d077770007ddd
000000000000000000000000000000000000000000000000ddddddddddddddd70000000000112000000000000000000000000000d00000000000077d70007ddd
000000000000000000000000000000000000000000000000ddddddddddddddd70000000001112000000000000000d0000000000000000000000077dd70007ddd
000000000000000000000000000000000000000000000000ddddddddddddddd7000000d0011120000000000000000000000d00000000000000007ddd70007ddd
000000000000000000000000000000000000000000000000ddddddddddddddd7005000dd011120000000005000000000000d00000000000000077ddd70007ddd
000000000000000000000000000000000000000000000000dddddddddddddd70000000d221112000000000000000000000012000000000000077dddd70007ddd
000000000000000000000000000000000000000000000000dddddddddddddd7000000011221110000d0000000000000000dd200000000dd0007ddddd70007d22
000000000000000000000000000000000000000000000000dddddddddddddd700000000112110000000000000000000000111200000dd110077ddddd70007222
000000000000000000000000000000000000000000000000dddddddddddddd7000000001121100000000000111111110000112000011110007ddddddf000f222
0000000000000000000000000000000000000000000000002dddddddddddd70000000011121100000111111111111111110112001111100077dddd22f000f222
000000000000000000000000000000000000000000000000222dddddddddd7000000111111100001111111111111111111111111111100007dddd222f000f222
0000000000000000000000000000000000000000000000002222dd22ddddd7000111111111111111111111111111111111111111111111007d222222f000f222
0000000000000000000000000000000000000000000000002222222222222f111111111111111111111111111111111111111111111111111f222222f000f222
0000000000000000000000000000000000000000000000002222222222222f111111111111111111111111111111111111111111111111111f222222f000f222
000000000000000000000000000000000000000000000000222222222222f1111111111111111111111111111111111111122222211111111f222222f000f222
000000000000000000000000000000000000000000000000222222222222f11111111111111111111111111111111111111111112222221111f22222f000f222
000000000000000000000000000000000000000000000000222222222222f11111111112222211111111111555111111111111111111111111f22222f000f222
000000000000000000000000000000000000000000000000222222222222f111112222211112222221111115551111111111111111111111111f2222f000f222
000000000000000000000000000000000000000000000000222222222222f111111111111111111122111115551111111111111111111111111f2222f000f222
00000000000000000000000000000000000000000000000022222222222f1111111111111111111111111115551111111111111111111111111f2222f000f222
00000000000000000000cccccccc0000000000000000000022222222222f11111111111111111111111111155511111111111111111111111111f222f000fe22
0000000000000000cccccc1111cccccc000000000000000022222222222f11111111111111111111111111155511111111111111111111111111f222f000f222
00000000000000cc1111cc11c1cc1111cc0000000000000022222222222ff111111111111111111111111115551111111111111111111111111ff222f000fee2
000000000000cccc11c11c111ccc11c1cccc000000000000222222222222ff1111111111111111111111111555111111111111111111111111ff2222f000f222
00000000000cc1cc11cc1c11c1c11111c11cc000000000002222222222222ff11111111111111111111111155511111111111111111111111ff22222f000fe22
000000000ccc111cc11c1cd666c11c1cc11cccc00000000022222222222222ff111111111111111111111115551111111111111111111111ff222222f000f222
00000000cc1cc111c1ccc5d7776ccc1c11cccccc000000002222222222222ff11111111111111111111111155511111111111111111111111ff22222f000fee2
0000000cc111cc11ccc1556677761ccc11ccc11cc0000000ddddddddd222ff1111111111111111111111111151111111111111111111111111ff2222f000f222
000000cc11c1ccccc111ddd66676111cc11c111ccc000000ddddddddddd2f111111111111111111111111111111111111111111111111111111f2222f000fe22
00000ccc111cccc1111166ddd66d11111cc111ccccc00000d7d7ddddddddf111111111111111111111111111111111111111111111111111111f2222f000f222
00000cccc111cc111111776ddddd111111cc1cccccc00000d7d7ddddd44df111111111111111111111111111111111111111111111111111111f2222f000fee2
0000cccc7c1cc11111111766d5511111111c11c7cccc0000d777d7d7d44df111111111111111111111111111111111111111111111111111111f2222f000f222
000ccccccccc11111177116d551177111111ccccccccc000ddd7dd7dddddf111111111111111111111111111111111111111111111111111111f2222f000fe22
000ccc7cccc11111777771aaaa17777711111cccc7ccc000ddd7d7d7ddddf111e1111111111111111111111111111111111111111111111e111f2222f000f222
00cccccccc11111777e7771aa177e777711111cccccccc00ddddddddddddf111ee11111111111111111111111111111111111111111111ee111f2222f000fee2
00cc77ccc1111177ee77e71a717e7e7ee711111ccc77cc00d777ddddddddf111ee11111111111111111111111111111111111111111111ee111f2222f000f222
0ccc77ccc11117eeeeeeee1771eeeeeeee71111ccc77ccc0ddd7ddddd44df111ee11111111111111111111111111111111111111111111ee111f2222f000fe22
0ccccccc11117eeee2e2e21aa12e2e2eeee71111ccccccc0dd77d7d7d44df111ee11111111111111111111111111111111111111111111ee111f2222f000f222
0cc77ccc111eeeee2e2e2e1a7712e2e2eeeee111ccc77cc0ddd7dd7dddddf111ee11111111111111111111111111111111111111111111ee111f2222f000fee2
0cc77ccc111ee2e2e222221aaa12222e2e2ee111ccc77cc0d777d7d7ddddf111ee11111111111111111111111111111111111111111111ee111f2222f000f222
ccccccc111ee21111111111a7a1111111112ee111cccccccddddddddddddf111ee11111111111111111111111111111111111111111111ee111f2222f000fe22
cc7c7cc111eee199919911aa7a199919991eee111cc7c7ccd777ddddddddf111ee11111111111111111111111111111111111111111111ee111f2222f000f222
ccc7ccc111ee2119119191777a1919191912ee111ccc7cccddd7ddddd44df111ee11111111111111111111111111111111111111111111ee111f2222f000f222
cc7c7cc11ee21219119191aa7719991991112ee11cc7c7ccd777d7d7d44df111ee11111111111111111111111111111111111111111111ee111f2222f000f222
ccccccc11e2121191191911aaa191119191212e11cccccccd7dddd7dddddf111ee11111111111111111111111111111111111111111111ee111f2222fffff222
cc7c7cc112e211191191911aaa19111919112e211cc7c7ccd777d7d7ddddf111ee11111111111111111111111111111111111111111111ee111f222222222222
ccc7ccc11e2111191191911a7a191119991112e11ccc7cccddddddddddddf111ee11111111111111111111111111111111111111111111ee111f222222222222
cc7c7cc112111111111111aa7a111111111111211cc7c7ccd77dddddddddf1111ee111111111111111111111111111111111111111111ee1111f222222222222
0ccccccc11111111111111aa7a11111111111111ccccccc0dd7dddddd44df11111ee1111111111111111111111111111111111111111ee11111f222222222222
0cc7c7cc12111111111111a777a1111111111121cc7c7cc0dd7dd7d7d44df111111eee111111111111111111111111111111111111eee111111f222222222222
0ccc7ccc11111111111111a777aa111111111111ccc7ccc0dd7ddd7dddddf1115111eee1111111111111111111111111111111111eee1115111f222222222222
0cc7c7ccc1111111aa111aa77a88a11111111aaaac7c7cc0d777d7d7ddddf11111111eee11111111111111111111111111111111eee11111111f222222222222
00ccccccc1111111a8811a877aaa891111111a88accccc00ddddddddddd2f5115111111ee111111111111111111111111111111ee1111115115f222222222222
00ccc7c7aaa111111811aa877a8889111111aa888ac7cc00ddddddddd222f55111111111ee1111111111111111111111111111ee11111111155f222222222222
000ccc7c98aa1111111a88a77aaaa911111aaaaaaaacc000222222222222f155111111111ee11111111111111111111111111ee111111111551f222222222222
000cc7c79888a11111aaaa8877a88aaa11aa99999999c000222222222222f115f111111111ee111111111111111111111111ee111111111f511f222222222222
0000cccc9988a11119888aa777a88a8aaa99988888990000222222222222f111ff111111111ee1111111111111111111111ee111111111ff111f222222222222
00000cc7c9988aaa19888a8aaaa8888aa998888888990000222222222222f111fff111111111111111111111111111111111111111111fff111f222222222222
00000cc99888a99a1199888888a899998888988888900000222222222222f111f2ff1111111111111111111111111111111111111111ff2f111f222222222222
000000c988888a99aaaa8889988888888888998889900000222222222222f111f22ff11111111111111111111111111111111111111ff22f111f222222222222
000000098888a999999aaa88888888888888898899000000222222222222f111f222ff111111111111111111111111111111111111ff222f111f222222222222
000000099988aa9aaaa99988888899988988899990000000222222222222f111f2222ff1111111111111111111111111111111111ff2222f111f222222222222
00000000999899aaa9988888898888989988899900000000222222222222fffff22222ff11111111111111111111111111111111ff22222fffff222222222222
00000000009888999988889999888888988899000000000022222222222222222222222ff111111111111111111111111111111ff22222222222222222222222
000000000009888888888888888888899999900000000000222222222222222222222222ff1111111111111111111111111111ff222222222222222222222222
0000000000000999888898888988899999900000000000002222222222222222222222222ff11111111111111111111111111ff2222222222222222222222222
00000000000000099999988999999999900000000000000022222222222222222222222222ff111111111111111111111111ff22222222222222222222222222
000000000000000000099999999990000000000000000000222222222222222222222222222ff1111111111111111111111ff222222222222222222222222222
__map__
060708090a0b0c0d0e0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
161718191a1b1c1d1e1f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
262728292a2b2c2d2e2f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
363738393a3b3c3d3e3f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
464748494a4b4c4d4e4f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
565758595a5b5c5d5e5f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
666768696a6b6c6d6e6f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
767778797a7b7c7d7e7f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
868788898a8b8c8d8e8f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
969798999a9b9c9d9e9f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
a6a7a8a9aaabacadaeaf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
b6b7b8b9babbbcbdbebf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
c6c7c8c9cacbcccdcecf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
d6d7d8d9dadbdcdddedf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e6e7e8e9eaebecedeeef00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
f6f7f8f9fafbfcfdfeff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
