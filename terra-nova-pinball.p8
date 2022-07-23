pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
-- main
#include main.p8

--draw
#include draw/draw_collider.p8
#include draw/draw_spr.p8
#include draw/print_shadow.p8

--modes
#include modes/game.p8
#include modes/title.p8
#include modes/menu.p8
#include modes/launch.p8

--components
#include comp/flippers.p8
#include comp/walls.p8
#include comp/pinball.p8
#include comp/round_bumper.p8
#include comp/poly_bumper.p8
#include comp/targets.p8
#include comp/spinner.p8
#include comp/rollover.p8
#include comp/elem_group.p8
#include comp/capture.p8
#include comp/light.p8
#include comp/launcher.p8
#include comp/trigger_area.p8

--lib
#include lib/bounce.p8
#include lib/rotate_pnts.p8
#include lib/collision.p8
#include lib/pos_are_equal.p8
#include lib/gen_simple_collider.p8
#include lib/gen_collision_regions.p8
#include lib/increase_score.p8

-- common
#include lib/common/2d_vectors.p8
#include lib/common/mod_base_1.p8
#include lib/common/point_collides_box.p8
#include lib/common/point_collides_poly.p8
#include lib/common/limit.p8
#include lib/common/sign.p8
#include lib/common/long_numbers.p8
#include lib/common/get_frame.p8
#include lib/common/gen_polygon.p8

__gfx__
000000000000800000000000770000700700000022000000cccccccccccccccccccccccccccccccccc777777777777777ccccccccccccccccccccccccccccccc
000000000008280000000077700007650700000028800000cccccccccccccccccccccccccccc777777000000000000000777777ccccccccccccccccccccccccc
007007000008280000007777000000500000000028800000cccccccccccccccccccccccccc7700000000000000000d00000000077ccccccccccccccccccccccc
000770000082280000777770000000000000000028000000cccccccccccccccccccccccc77000000000000000000000000000000077ccccccccccccccccccccc
000770000082280077777000000000000000000028000000ccccccccccccccccccccc7770000000000000000000000000000000000077ccccccccccccccccccc
007007000082880072770000000000000000000000000000cccccccccccccccccccc7700000000000000000000000000000000000000077ccccccccccccccccc
000000000082880077700000000000000000000000000000ccccccccccccccccccc7700000000000000000000000000000000000000000077ccccccccccccccc
000000000822280000000000000000000000000000000000cccccccccccccccc777000000000000000cccccccc0000000000000000000000077ccccccccccccc
008888000888280000000000000000000000000022000000ccccccccccccccc7700000000000000ccccccccccc00000000000000000000000077cccccccccccc
0888e880082828000000000000000000000000002aa00000cccccccccccccc770000000000000ccc0000000ccc000000000000000000000000077ccccccccccc
882282e8082228000000000000000000000000002aa00000ccccccccccccc770000006000000cc00000000000c0000000000000000000000000077cccccccccc
882282e8828280000000000000000000000000002a000000cccccccccccc770000000000000cc000000000000000000000000000000000000000077ccccccccc
8e8888e8828800000000000000000000000000002a000000ccccccccccc77000000000000ccc000000d0000000000000000000000000000000000077cccccccc
88eeee880800000000000000000000000000000000000000ccccccccccc7000000000000cc00000000000000000000000000060000000000000000077ccccccc
088222800000000000000077770000000000000000000000ccccccccccc700000000000cc000000000000000000000000000000000000000000000007ccccccc
008888000000000077777777700000000000000000000000cccccccccc70000000000ccc00000000000000000000000000000000000000000050000077cccccc
00888800000000007277770000000000000000000d000000cccccccccc7000000000ccc00000000000000cd0000c0000000000000000000000000000077ccccc
087766800000000077700000000000000006000006000000ccccccccc7000000000ccc000000000c00000c00000c00000c0000000000000000000000007ccccc
87576678000000000000000000000000007670000d000000ccccccccc7000000000cc0000000000c00000c00000c00000c00000000000000000000000007cccc
877777780000000000000000000000000076700000000000ccccccccc700000000ccc0000000000c00000c00000c00000c00000000000000000000000007cccc
857776780000000000000000000000000076700000000000ccccccccc700000000cc00000000000c00000000000000000c000000000000000000000000007ccc
866777780000000000000000000000000076700004000000ccccccccc70000000cc000000c00000000000000000000000000000c000000000000000000007ccc
086557800000000000000000000000000006000044400000cccccccc700000000cc000000c00000000000000000000000000000c000000000000000000007ccc
008888000000000000000000000000000000000004000000cccccccc70000000cc0000000c0000000000000000000d000000000c000000000000000000007ccc
00888800000000000000000000000000000000000d000000cccccccc70000000cc0000000c00000000000000000000000000000c000000000000000000007ccc
08cccc800000000000000000000000000006000006000000cccccccc70050000cc00000000000000000000000000000000000000000000000000000000007ccc
877cc778000000007777770000000000077677000d000000cccccccc70000000cc00000000000000000000000000000000000000000000000000000060007ccc
8cbbbbc80000000072777777777000000776770000000000cccccccc70000000cc000000000000000000000000000000000000d0000000000000000000007ccc
89a777780000000077777700000000000776770000000000cccccccc70000000cc00000000000000000000500000000000000000000000000000000000007ccc
86666bc8000000000000000000000000077677000a000000cccccccc70000000cc00000000000000000000000000000000000000000000000000000000007ccc
08ddbb8000000000000000000000000000060000aaa00000cccccccc70000000cc0000060000000000000000000d0600000000000000000000000000000c7ccc
00888800000000000000000000000000000000000a000000cccccccc70000000cc000000000000005000000000000000000000000000000000000000000c7ccc
008888000000000000000000000000000000000018000000cccccccc70000000cc00000000000000000000000000000000000000000000000000000000c07ccc
08eeeb800000000000000000000000000006000018000000cccccccc77000000cc00000000000000000000000000000000000000000000000000000000c07ccc
8bbbbbb80000000000000000000000000066600018000000ccccccccc7000000ccc000000000000000000000000000000000000000000000005000000c007ccc
82bbbee80000000000000000000000000066600010000000ccccccccc70000000cc000000000000000000000000000000000000000000000000000007c007ccc
82eeeeb80000000000000000000000000066600000000000ccccccccc70060000cc0000000000000006000000000000000000000005000000000000770007ccc
833bbbe80000000077700000000000000066600000000000ccccccccc700000000c0000000000000000000000000000000000000000000000000007770007ccc
08222e800000000072777700000000000006000000000000ccccccccc770000000cc0000000000000000000000d0500000000000000000000000077c70007ccc
008888000000000077777777700000000000000000000000cccccccccc70000000cc00000000000000000000000000000000000000000000000077cc70007ccc
00000000000000000000007777000000000000001a000000cccccccccc700000000c0000000000000000000000000000000000000000000000777ccc70007ccc
00000000000000000000000000000000000600001a000000cccccccccc770000000cc0000000000000000000000000000000d00000000000777ccccc70007ccc
00000000000000000000000000000000000700001a000000ccccccccccc700000000c00000000000000000000000000000000000000007777ccccccc70007ccc
000000000000000000000000000000000007000010000000ccccccccccc700000000000000000000000000000000000000000000007777cccccccccc70007ccc
000000000000000000000000000000000007000000000000ccccccccccc770000000000000000600000000000000000000000000777ccccccccccccc70007ccc
000000000000000000000000000000000007000000000000cccccccccccc700000000000000000000000000000000000000007777ccccccccccccccc70007ccc
000000000000000000000000000000000006000000000000cccccccccccc770000000000000000050000000000600000000777cccccccccccccccccc70007ccc
000000000000000000000000000000000000000000000000ccccccccccccc700000000000000000000000000000000000007cccccccccccccccccccc70007ccc
000800000000000077700000000000000000000000000000cccccccccccc7700000000000000000000000000000000000007cccccccccccccccccccc70007ccc
000800000000000072770000000000000000000000000000cccccccccc7770000000000000000000000000000000000000077ccccccccccccccccccc70007ccc
008780000000000077777000000000000000000000000000ccccccc77770000000000000000000000000000000000000000077cccccccccccccccccc70007ccc
008780000000000000777770000000000000000000000000cccccc7777000000000000000000000000000000000000000000077ccccccccccccccccc70007ccc
008280000000000000007777000000000000000000000000cccccc7700000060000000d000000000000000000500000000000077cccccccccccccccc70007ccc
082228000000000000000077700000000000000000000000cccccc770000000000000000000000000000000000000000000000077ccccccccccccccc70007ccc
082228000000000000000000770000000000000000000000cccccc7700000000000000000000000000000000000000000000000077cccccccccccccc70007ccc
082228000000000000000000000000000000000000000000cccccc77770000000000000000dd0000000000000000000000000000077ccccccc77777c70007ccc
082728000000000000000000000000000000000000000000ccccccc7777777000000000000d200000000000000000000000000000077ccccc777777770007ccc
087278000000000000000000000000000000000000000000cccccccccccccc7770000000001200000000000000000000000d000000077cccc777077770007ccc
082228000000000000000000000000000000000000000000cccccccccccccccc7000000000120000000600000000000006000000000077cc7700007770007ccc
822222800000000000000000000000000000000000000000cccccccccccccccc7000000000112000000000000000000000000000000007777000077770007ccc
828282800000000000000000000000000000000000000000ccccccccccccccc7000000500011200000000000000000000000000000000070000d077770007ccc
828882800000000000000000000000000000000000000000ccccccccccccccc70000000000112000000000000000000000000000d00000000000077c70007ccc
880008800000000000000000000000000000000000000000ccccccccccccccc70000000001112000000000000000d0000000000000000000000077cc70007ccc
800000800000000000000000000000000000000000000000ccccccccccccccc7000000d0011120000000000000000000000d00000000000000007ccc70007ccc
000000000000000000000000000000000000000000000000ccccccccccccccc7005000dd011120000000005000000000000d00000000000000077ccc70007ccc
000000000000000000000000000000000000000000000000cccccccccccccc70000000d221112000000000000000000000012000000000000077cccc70007ccc
000000000000000000000000000000000000000000000000cccccccccccccc7000000011221110000d0000000000000000dd200000000dd0007ccccc70007cee
000000000000000000000000000000000000000000000000cccccccccccccc700000000112110000000000000000000000111200000dd110077ccccc70007eee
000000000000000000000000000000000000000000000000cccccccccccccc7000000001121100000000000111111110000112000011110007ccccccf000feee
000000000000000000000000000000000000000000000000ecccccccccccc70000000011121100000111111111111111110112001111100077cccceef000feee
000000000000000000000000000000000000000000000000eeecccccccccc7000000111111100001111111111111111111111111111100007cccceeef000feee
000000000000000000000000000000000000000000000000eeeecceeccccc7000111111111111111111111111111111111111111111111007ceeeeeef000feee
000000000000000000000000000000000000000000000000eeeeeeeeeeeeef111111111111111111111111111111111111111111111111111feeeeeef000feee
000000000000000000000000000000000000000000000000eeeeeeeeeeeeef111111111111111111111111111111111111111111111111111feeeeeef000feee
000000000000000000000000000000000000000000000000eeeeeeeeeeeef1111111111111111111111111111111111111122222211111111feeeeeef000feee
000000000000000000000000000000000000000000000000eeeeeeeeeeeef11111111111111111111111111111111111111111112222221111feeeeef000feee
000000000000000000000000000000000000000000000000eeeeeeeeeeeef11111111112222211111111111555111111111111111111111111feeeeef000feee
000000000000000000000000000000000000000000000000eeeeeeeeeeeef111112222211112222221111115551111111111111111111111111feeeef000feee
000000000000000000000000000000000000000000000000eeeeeeeeeeeef111111111111111111122111115551111111111111111111111111feeeef000feee
000000000000000000000000000000000000000000000000eeeeeeeeeeef1111111111111111111111111115551111111111111111111111111feeeef000feee
000000000000000000000000000000000000000000000000eeeeeeeeeeef11111111111111111111111111155511111111111111111111111111feeef000f5ee
000000000000000000000011110000000000000000000000eeeeeeeeeeef11111111111111111111111111155511111111111111111111111111feeef000feee
000000000000000011110011010011110000000000000000eeeeeeeeeeeff111111111111111111111111115551111111111111111111111111ffeeef000f55e
000000000000000011011011100011010000000000000000eeeeeeeeeeeeff1111111111111111111111111555111111111111111111111111ffeeeef000feee
000000000000010011001011010111110110000000000000eeeeeeeeeeeeeff11111111111111111111111155511111111111111111111111ffeeeeef000f5ee
0000000000001110011010d6660110100110000000000000eeeeeeeeeeeeeeff111111111111111111111111111111111111111111111111ffeeeeeef000feee
0000000000100111010005d7776000101100000000000000eeeeeeeeeeeeeff11111111111111111111111111111111111111111111111111ffeeeeef000f55e
000000000111001100015566777610001100011000000000222222222eeeff1111111111111111111111111111111111111111111111111111ffeeeef000feee
00000000110100000111ddd666761110011011100000000022222222222ef111111111111111111111111111111111111111111111111111111feeeef000f5ee
0000000011100001111166ddd66d11111001110000000000272722222222f111111111111111111111111111111111111111111111111111111feeeef000feee
00000000011100111111776ddddd11111100100000000000272722222442f111111111111111111111111111111111111111111111111111111feeeef000f55e
000000007010011111111766d55111111110110700000000277727272442f111111111111111111111111111111111111111111111111111111feeeef000feee
00000000000011111177116d551177111111000000000000222722722222f111111111111111111111111111111111111111111111111111111feeeef000f5ee
0000007000011111777771aaaa1777771111100007000000222727272222f111e1111111111111111111111111111111111111111111111e111feeeef000feee
000000000011111777e7771aa177e7777111110000000000222222222222f111ee11111111111111111111111111111111111111111111ee111feeeef000f55e
0000770001111177ee77e71a717e7e7ee711111000770000277722222222f111ee11111111111111111111111111111111111111111111ee111feeeef000feee
00007700011117eeeeeeee1771eeeeeeee71111000770000222722222442f111ee11111111111111111111111111111111111111111111ee111feeeef000f5ee
0000000011117eeee2e2e21aa12e2e2eeee7111100000000227727272442f111ee11111111111111111111111111111111111111111111ee111feeeef000feee
00077000111eeeee2e2e2e1a7712e2e2eeeee11100077000222722722222f111ee11111111111111111111111111111111111111111111ee111feeeef000f55e
00077000111ee2e2e222221aaa12222e2e2ee11100077000277727272222f111ee11111111111111111111111111111111111111111111ee111feeeef000feee
0000000111ee21111111111a7a1111111112ee1110000000222222222222f111ee11111111111111111111111111111111111111111111ee111feeeef000f5ee
0070700111eee199919911aa7a199919991eee1110070700277722222222f111ee11111111111111111111111111111111111111111111ee111feeeef000feee
0007000111ee2119119191777a1919191912ee1110007000222722222442f111ee11111111111111111111111111111111111111111111ee111feeeef000feee
007070011ee21219119191aa7719991991112ee110070700277727272442f111ee11111111111111111111111111111111111111111111ee111feeeef000feee
000000011e2121191191911aaa191119191212e110000000272222722222f111ee11111111111111111111111111111111111111111111ee111feeeefffffeee
0070700112e211191191911aaa19111919112e2110070700277727272222f111ee11111111111111111111111111111111111111111111ee111feeeeeeeeeeee
000700011e2111191191911a7a191119991112e110007000222222222222f111ee11111111111111111111111111111111111111111111ee111feeeeeeeeeeee
0070700112111111111111aa7a1111111111112110070700277222222222f1111ee111111111111111111111111111111111111111111ee1111feeeeeeeeeeee
0000000011111111111111aa7a1111111111111100000000227222222442f11111ee1111111111111111111111111111111111111111ee11111feeeeeeeeeeee
0007070012111111111111a777a111111111112100707000227227272442f111111eee111111111111111111111111111111111111eee111111feeeeeeeeeeee
0000700011111111111111a777aa11111111111100070000227222722222f1111111eee1111111111111111111111111111111111eee1111111feeeeeeeeeeee
0007070001111111aa111aa77a88a11111111aaaa0707000277727272222f11111111eee11111111111111111111111111111111eee11111111feeeeeeeeeeee
0000000001111111a8811a877aaa891111111a88a000000022222222222ef1111111111ee111111111111111111111111111111ee1111111111feeeeeeeeeeee
00000707aaa111111811aa877a8889111111aa888a070000222222222eeef11111111111ee1111111111111111111111111111ee11111111111feeeeeeeeeeee
0000007098aa1111111a88a77aaaa911111aaaaaaaa00000eeeeeeeeeeeef111111111111ee11111111111111111111111111ee111111111111feeeeeeeeeeee
000007079888a11111aaaa8877a88aaa11aa999999990000eeeeeeeeeeeef111f111111111ee111111111111111111111111ee111111111f111feeeeeeeeeeee
000000009988a11119888aa777a88a8aaa99988888990000eeeeeeeeeeeef111ff111111111ee1111111111111111111111ee111111111ff111feeeeeeeeeeee
0000000709988aaa19888a8aaaa8888aa998888888990000eeeeeeeeeeeef111fff111111111111111111111111111111111111111111fff111feeeeeeeeeeee
000000099888a99a1199888888a899998888988888900000eeeeeeeeeeeef111feff1111111111111111111111111111111111111111ffef111feeeeeeeeeeee
0000000988888a99aaaa8889988888888888998889900000eeeeeeeeeeeef111feeff11111111111111111111111111111111111111ffeef111feeeeeeeeeeee
000000098888a999999aaa88888888888888898899000000eeeeeeeeeeeef111feeeff111111111111111111111111111111111111ffeeef111feeeeeeeeeeee
000000099988aa9aaaa99988888899988988899990000000eeeeeeeeeeeef111feeeeff1111111111111111111111111111111111ffeeeef111feeeeeeeeeeee
00000000999899aaa9988888898888989988899900000000eeeeeeeeeeeefffffeeeeeff11111111111111111111111111111111ffeeeeefffffeeeeeeeeeeee
000000000098889999888899998888889888990000000000eeeeeeeeeeeeeeeeeeeeeeeff111111111111111111111111111111ffeeeeeeeeeeeeeeeeeeeeeee
000000000009888888888888888888899999900000000000eeeeeeeeeeeeeeeeeeeeeeeeff1111111111111111111111111111ffeeeeeeeeeeeeeeeeeeeeeeee
000000000000099988889888898889999990000000000000eeeeeeeeeeeeeeeeeeeeeeeeeff11111111111111111111111111ffeeeeeeeeeeeeeeeeeeeeeeeee
000000000000000999999889999999999000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeff111111111111111111111111ffeeeeeeeeeeeeeeeeeeeeeeeeee
000000000000000000099999999990000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeff1111111111111111111111ffeeeeeeeeeeeeeeeeeeeeeeeeeee
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
__sfx__
010300000366006650086500b6500e6501165015650186501c6401f6402263025630286302a6202d6202f6203162233622356223a51235512335122e51227512225121d51218522135020c502075020350238502
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000001b73022720225101f7302472024510297302772029700277002e7002b700297002e700000002b7001b70022700225001f70024700245002970027700297002e700000002b7002b700000000000000000
491000200c0330050000625006231862500000006250000000133000000052300003186250000000513000000c033005130000000000186250000000513000000013300000005230000318625000000051300000
611000000210002000001300012500110001300012500110001300012500110031300312003110001350011003100031000013000125001100313003120031100313003120031100513005125051100313503110
491000000210002000051300512505110031300312503110051300512505110031300312503110051350511003100031000513005125051100313003120031100013000125001100313003120031100013500110
__music__
00 10111244
01 41111244
02 41111344

