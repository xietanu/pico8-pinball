function init_transition(_next_state)
 next_state = _next_state
 transitioning=true
 t=-1

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

 max_col=limit(flr(abs(30-t)/4),0,6)
end

function draw_transition()
 for grad in all(col_grads) do
  for i=1,6 do
   pal(grad[i],grad[min(i,max_col)])
  end
 end
end
