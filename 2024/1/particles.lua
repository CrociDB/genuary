-- title:   particles
-- author:  crocidb
-- desc:    entry for Genuary 2024 #1
-- site:    https://crocidb.com/
-- license: MIT License
-- version: 0.1
-- script:  lua

max_particles=5000
ps={}
for i=0,max_particles do
	ps[i]={}
	ps[i].x=math.random()*240.0
 ps[i].y=math.random()*136.0
 ps[i].acc=math.random() * .1 + .06
	ps[i].s=0
	ps[i].a=math.random()*2.0*math.pi
end

function TIC()
	t=time()
	cls(0)
	
	for i=0,max_particles do
		ps[i].s=ps[i].s*.93
		ps[i].s=ps[i].s+ps[i].acc
		
		ps[i].acc=ps[i].acc+math.sin(t+i)*.02+0.0005
	
		ps[i].x=ps[i].x+math.sin(ps[i].a)*ps[i].s
		ps[i].y=ps[i].y+math.cos(ps[i].a)*ps[i].s
		
		if 	ps[i].x > 240 or ps[i].x < 0
			or ps[i].y > 134 or ps[i].y < 0 then
			ps[i].x=240.0/2.0
 			ps[i].y=136.0/2.0
			ps[i].s=0.0
			ps[i].acc=math.random() * .2 + .03
			ps[i].a=math.random()*2.0*math.pi
		end
		
		ps[i].a=ps[i].a+math.sin(t*i+i)*.15
		
		c=ps[i].s*2.5+12.5
		if c<1 then c=1 end
		size=-ps[i].s*2+1
		line(
			ps[i].x,
			ps[i].y,
			ps[i].x+math.sin(ps[i].a)*size,
			ps[i].y+math.cos(ps[i].a)*size,
			c)
	end
end

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>


