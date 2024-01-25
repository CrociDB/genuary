-- title:   screensaver
-- author:  crocidb
-- desc:    a screensaver, duh
-- site:    https://crocidb.com/
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

function lerp(a,b,t) return a * (1-t) + b * t end
function rot(x,y,a)
	return x*math.cos(a)-y*math.sin(a),x*math.sin(a)+y*math.cos(a)
end

star_points={
	{x=0,y=-1.3},
	{x=1,y=2},
	{x=-1.7,y=0},
	{x=1.7,y=0},
	{x=-1,y=2}}
star_size=10
star={x=50,y=50,sx=1,sy=-.5,a=0,as=math.random()*.2}
p=math.random()*7
shake=0
d=4

for i=1,5,1 do
	star_points[i]['tx']=star_points[i]['x']*star_size
	star_points[i]['ttx']=star_points[i]['x']*star_size
	star_points[i]['ty']=star_points[i]['y']*star_size
	star_points[i]['tty']=star_points[i]['y']*star_size
end

function pos(x,y)
	return star['x']+x,star['y']+y
end

function TIC()
	cls(p)

	if shake>0 then
		poke(0x3FF9,math.random(-d,d))
		poke(0x3FF9+1,math.random(-d,d))
		shake=shake-1
		if shake==0 then memset(0x3FF9,0,2) end
	end
	
	star['x']=star['x']+star['sx']
	star['y']=star['y']+star['sy']
	
	if star['sx']>.5 then 
		star['sx']=star['sx']*.82
	end
	if star['sy']>.5 then 
		star['sy']=star['sy']*.82
	end

	if math.abs(star['as'])>.01 then 
		star['as']=star['as']*0.9
	end
	
	star['a']=star['a']+star['as']

	vx,vy=pos(star_points[5]['x'],star_points[5]['y'])
	for i=1,5,1 do
		star_points[i]['tx'],star_points[i]['ty']=rot(
			star_points[i]['ttx'],
			star_points[i]['tty'],
			star['a'])
		
		star_points[i]['x']=star_points[i]['x']+(star_points[i]['tx']-star_points[i]['x'])*(0.01+math.random()*.5-.1)+math.random()*.2
		star_points[i]['y']=star_points[i]['y']+(star_points[i]['ty']-star_points[i]['y'])*(0.01+math.random()*.5-.1)+math.random()*.2

		xx,yy=pos(
			star_points[i]['x'],
			star_points[i]['y'])
		
		line(xx,yy,vx,vy,p+3)
	 	circ(xx,yy,2,p+1)
		
		if yy<=0 then
			star_points[i]['y']=star_points[i]['y']+star['sy']*1.2
			star['sy']=star['sy']+(math.random()*2.1+1)
			star['as']=star['as']+(math.random()*.2-.1)
			p=p+1
			shake=5
		elseif yy>=136 then
			star_points[i]['y']=star_points[i]['y']-star['sy']*1.2
			star['sy']=star['sy']-(math.random()*2.1+1)
			star['as']=star['as']+(math.random()*.2-.1)
			p=p+1
			shake=5
		end
		if xx<=0 then
			star_points[i]['x']=star_points[i]['x']+star['sx']*1.2
			star['sx']=star['sx']+(math.random()*2.1+1)
			star['as']=star['as']+(math.random()*.2-.1)
			p=p+1
			shake=5
		elseif xx>=240 then
			star_points[i]['x']=star_points[i]['x']-star['sx']*1.2
			star['sx']=star['sx']-(math.random()*2.1+1)
			star['as']=star['as']+(math.random()*.2-.1)
			p=p+1
			shake=5
		end
		
		vx=xx
		vy=yy
	end
end

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>


