const LAYERS = 10;
const WIDTH = 600;
const HEIGHT = 300;

function setup() 
{
  createCanvas(WIDTH,HEIGHT);
}

function draw() 
{
  for (let i=0;i<WIDTH;i++)
  {
    for (let layer=0;layer<LAYERS;layer++)
    {
      let d = Math.sin(frameCount*.003)*.04;
      let h = noise(frameCount*.002,.005*i+(layer*.06*Math.sin((frameCount+i)*.02)+frameCount*.001))*HEIGHT*1.1;
      let diff = (HEIGHT/LAYERS)*Math.pow(layer,1);
      
      let col = new p5.Vector(
        h*2.0-300/3, 
        60+Math.pow(Math.abs(Math.sin((-frameCount+(i*.02)+(layer*Math.cos(frameCount*.01)*3))*.1)),6)*30, 
        240);
      col.mult((2/(layer+1))*1.1);
      
      if (i%2==0) col.mult(2);
      
      line(i,0,i,h-diff);
      stroke(color(col.x,col.y,col.z));
      line(i,h+diff,i,480);
      stroke(color(col.x,col.y,col.z));
    }
  }
}
