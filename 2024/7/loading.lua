-- title:   loading
-- author:  crocidb
-- desc:    loading, inspired by sotn
-- site:    https://crocidb.com
-- license: MIT License (change this to your license of choice)
-- version: 0.1
-- script:  lua

text="Now Loading"

function TIC()t=time()
	cls(15)
	for i=0,#text do
		for c=8,12,1 do
			tt=t+(c-8)*20
			m=(math.pow(math.sin(tt*.005)*.5+.5,2))*17+3
			h=math.sin((tt+i*50)*.01)*m
			print(string.sub(text,i,i),65+i*8,62+h,c);
		end
	end
end

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

