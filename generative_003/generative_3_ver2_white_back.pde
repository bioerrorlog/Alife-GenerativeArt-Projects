float _xStart;
float _xNoise, _yNoise;
float _radius;
float _ang;
float _centX, _centY;

void setup(){
  size(1920,1080);
  background(255);
  smooth();
  
  _xStart = random(10);
  _xNoise = _xStart;
  _yNoise = random(10);
  _radius = random(1);
  _ang = random(10);
  _centX = width /2;
  _centY = height /2;

}

void drawPoint(float x, float y, float noiseFactor){
  pushMatrix();
  translate(x, y);
  rotate(noiseFactor * radians(360*4));
  float edgeSize = noiseFactor * 500;
  float grey = 50 + (noiseFactor * 120);
  float alpha = 100 + (noiseFactor * 120);
  noStroke();
  fill(grey, alpha);
  ellipse(0,0, edgeSize, edgeSize);
  popMatrix();
}

void draw(){
  _yNoise += 0.01;
  _xNoise += 0.01;
  _ang += 0.01;
  _radius += 1;
  float rad = radians(noise(_ang));
  drawPoint(_centX/2 + cos(rad)*_radius, _centY, noise(_xNoise,_yNoise));

    saveFrame("frames/generative_3_#####.png"); // 各フレームで画像を保存
}
