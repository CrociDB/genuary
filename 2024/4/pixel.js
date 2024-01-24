const spritedata = [0x4,0x0,0xf7461c,0x9f8316,0xffc07b,16,0,0,0,0,0,0,0,0,0,0,0,0,3,3,3,0,0,0,0,0,0,1,1,1,1,1,0,0,3,3,3,0,0,0,0,0,1,1,1,1,1,1,1,1,1,3,3,0,0,0,0,0,2,2,2,3,3,2,3,0,2,2,2,0,0,0,0,2,3,2,3,3,3,2,3,3,2,2,2,0,0,0,0,2,3,2,2,3,3,3,2,3,3,3,2,0,0,0,0,2,2,3,3,3,3,2,2,2,2,2,0,0,0,0,0,0,0,3,3,3,3,3,3,3,2,0,0,0,0,2,2,2,2,2,1,2,2,2,1,2,0,0,0,0,2,2,2,2,2,2,2,1,2,2,2,1,0,0,2,3,3,2,2,2,2,2,2,1,1,1,1,1,0,0,2,3,3,3,0,1,1,2,1,1,3,1,1,3,1,2,2,0,3,0,2,1,1,1,1,1,1,1,1,1,1,2,2,0,0,2,2,2,1,1,1,1,1,1,1,1,1,2,2,0,2,2,2,1,1,1,1,1,1,1,0,0,0,0,0,0,2,0,0,1,1,1,1,0,0,0,0,0,0,0,0,0]

const size = 30;
let time = 0;

function setup() 
{
  createCanvas(1000, 600, WEBGL);
  colorMode(RGB, 255, 255, 255, 1);
}

function draw() 
{ 
  background(color(20,20,23));
  
  const palette = spritedata.slice(1, spritedata[0]+1);
  const w = spritedata[spritedata[0]+1];
  const tiles = spritedata.slice(spritedata[0]+2);

  const imgs = size * w;
  
  const s = Math.pow((Math.sin(time * .005) + 1.0), 6.0) * .1 + 0.3;
  scale(s);
  translate(-imgs/2, -imgs/2);
  
  for(let i = 0; i < tiles.length; i++) drawPixel(palette[tiles[i]], i%w, Math.floor(i/w), i);
}

function drawPixel(col, x, y, i)
{
  if (col == 0) return;
  time += deltaTime / 1000;
  let c = colr(col);

  noStroke();
  
  const sp = x*10;
  const s = .01;
  let xx = x*size + size/2 + Math.sin((time+sp) * s) * size*.25;
  let yy = y*size + size/2 + Math.cos((time+sp) * s) * size*.25;
  
  fill(color(red(c), 0, 0, alpha(c)));
  circle(xx, yy, size*.5);
  
  xx = x*size + size/2 + Math.sin((time + 200 + sp) * s) * size*.25;
  yy = y*size + size/2 + Math.cos((time + 200 + sp) * s) * size*.25;
  
  fill(color(0, green(c), 0, alpha(c)));
  circle(xx, yy, size*.5);
  
  xx = x*size + size/2 + Math.sin((time + 400 + sp) * s) * size*.25;
  yy = y*size + size/2 + Math.cos((time + 400 + sp) * s) * size*.25;
  
  fill(color(0, 0, blue(c), alpha(c)));
  circle(xx, yy, size*.5);
  
  let a = (Math.sin((time + 50 + i * 1.2) * .01) + 1.0) * .5;
  c.setAlpha(Math.pow(a, 6.0));
  fill(c);
  rect(x*size, y*size, size, size);
}

const colr = (v) => color(v>>16,(v>>8)&0xff,v&0xff);

