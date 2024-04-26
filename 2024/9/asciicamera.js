let capture;
let constraints = {
  video: {
    mandatory: {
      maxWidth: 80,
      maxHeight: 60
    },
    optional: [{ maxFrameRate: 60 }]
  },
  audio: false
};

const shades = ".'-:;=o#nm@W";
let t = 0;

function setup() 
{
  createCanvas(800, 500);
  capture = createCapture(constraints);
  capture.hide();
  textFont('Courier New', 10);
}

function draw() 
{
  t += deltaTime * 2.0;
  background(color(40,40,40));
  
  capture.loadPixels();
  let total = (capture.pixels.length/4);
  for (let i = 0; i < total; i++)
  {
    let intensity = Math.pow(1.0 - ((t+(total-i))%total) / total, 0.4);
    
    let index = i*4;
    let col = (capture.pixels[index]+capture.pixels[index+1]+capture.pixels[index+2])/3/256;
    let colindex = Math.floor(col * shades.length * intensity)
    let x = i%80;
    let y = Math.floor(i/80);
    
    stroke(color(
      capture.pixels[index]*intensity+40,
      capture.pixels[index+1]*intensity+40,
      capture.pixels[index+2]*intensity+40));
    text(shades[colindex],x*10,y*10);
  }
}
