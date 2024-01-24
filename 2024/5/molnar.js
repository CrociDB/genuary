const mw = 7, mh = 4, layers = 5, b = 5;
let w, h, time = 0;
let sq = [];
let t = 1.3;

function setup() 
{
  createCanvas(800, 500, WEBGL);
  
  w = (width-b) / mw;
  h = (height-b) / mh;
  
  for (let i = 0; i < layers; i++)
  {
    let sql = [];
    for (let y = 0; y < mh; y++) for (let x = 0; x < mw; x++) 
      sql.push(
        { x: x, y: y, 
         i: Math.random(), 
         col: Math.pow(Math.random(), 2), target_col: Math.pow(Math.random(), .7), 
         t: Math.random() * 5, target_t: Math.random() * 5});
    sq.push(sql);
  }
  
}

function draw() 
{
  time += deltaTime / 1000;
  let bright = color(218,217,207);
  let dark = color(38,32,23);
  background(bright);
  
  scale(.95);
  translate(-width/2, -height/2);
  
  let rst = time >= t;
  if (rst) time = 0;
  
  for (let i in sq)
  {
    for (let j in sq[i])
    {
      let s = sq[i][j];
      if (rst)
      {
        s.target_col = Math.pow(Math.random(), 2);
        s.target_t =  Math.random() * 5;
      }
    
      s.t = lerp(s.t, s.target_t, 0.1);
      s.col = lerp(s.col, s.target_col, 0.001 + s.i / 10);
      
      noFill();
      strokeWeight(2 + s.t);
      stroke(lerpColor(dark, bright, s.col));
      
      let border = b + 1 * (i + 1);
      
      rect(s.x * w + border, s.y * h + border, w - border * 2, h - border * 2);
    }
  }
}

