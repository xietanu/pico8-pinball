function mod(val,modulo)
 --Mod for 1 based numbers.
 --3%3=3. 4%3=1, 1%3=1
 return (val-1)%modulo+1
end