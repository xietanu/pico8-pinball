function init_transition(_next_state)
 next_state = _next_state
 transitioning=true
 t=-1

 col_grads={
  {0,0,5,13,6,7},
  {0,0,5,3,11,11},
  {0,0,2,8,14,15},
  {0,0,4,9,10,10},
  {0,0,1,13,12,12}
 }

 update_transition()
end

function update_transition()
 t+=1
 if t==30 then
  mode = next_state
  mode.init()
 elseif t>=60 then
  transitioning=false
  return
 end

 if t<30 then
  max_col=limit(flr((30-t)/4)+1,0,6)
 else
  max_col=limit(flr((t-30)/4)+1,0,6)
 end
end

function draw_transition()
 for grad in all(col_grads) do
  for i=1,6 do
   pal(grad[i],grad[min(i,max_col)])
  end
 end
end
