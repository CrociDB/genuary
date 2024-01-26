let time = 0;
let lx = -1, ly = -1;
let vx = .05 + Math.random() * .1;
let vy = .05 + Math.random() * .1;

function setup() 
{
  createCanvas(900, 600);
  colorMode(RGB, 255, 255, 255, 1.0);
  background(color(200,200,200,1.0));
}

function draw()
{
  time += deltaTime*.004;
  background(color(10,10,10,.007));
  
  if (time >= 250.0)
  {
    background(color(200,200,200,1.0));
    vx = .05 + Math.random() * .1;
    vy = .05 + Math.random() * .1;
    time = 0;
    lx = -1;
    ly = -1;
  }
  else if (time >= 1.5)
  {
    let mx = 1.0 + Math.cos(time*vx) * .1;
    let my = 1.0 + Math.sin(time*vy) * .1;

    strokeWeight(2.0);
    stroke(color(150+Math.cos(time*.8)*50,150+Math.sin(time*.5)*50,180+Math.cos(time*1.5)*30));

    let x = (Math.sin(time * mx)*.5+.5)*(width-20)+10; 
    let y = (Math.cos(time * my)*.5+.5)*(height-20)+10;

    if (lx != -1 && ly != -1)
      line(lx, ly, x, y);

    lx = x;
    ly = y;
  }
  else
  {
    background(color(10,10,10,.07));
  }
}
