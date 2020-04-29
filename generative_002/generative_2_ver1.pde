float _angleNoise, _radiusNoise;
float _xNoise, _yNoise;

float _angle, _radius;
float _strokeCol = 254;
int _strokeChange = -1;


void setup(){
  size(1920,1080);
  background(255);
  smooth();
  //frameRate(30);
  noFill();
  
  _angleNoise = random(10);
  _radiusNoise = random(10);
  _xNoise = random(10);
  _yNoise = random(10);
}


void draw(){
  _radiusNoise += 0.005;
  _radius = (noise(_radiusNoise) * 1000) + 100;
  
  _angleNoise += 0.005;
  _angle += (noise(_angleNoise) * 2) - 1;
  if (_angle > 360){_angle -= 360;}
  if (_angle < 0){_angle += 360;}
  
  _xNoise += 0.01;
  _yNoise += 0.01;
  float centerX = width / 2 + (noise(_xNoise) * 100) - 50;
  float centerY = height / 2 + (noise(_yNoise) * 100) - 50;
  
  float rad = radians(_angle);
  float x1 = centerX + (_radius * cos(rad) *2);
  float y1 = centerY + (_radius * sin(rad));
  
  float opprad = rad + PI;
  float x2 = centerX + (_radius * cos(opprad) *2);
  float y2 = centerY + (_radius * sin(opprad));  
  
  _strokeCol += _strokeChange;
  if (_strokeCol > 254){_strokeChange = -1;}
  if (_strokeCol < 1){_strokeChange = 1;}
  stroke(_strokeCol, 10);
  strokeWeight(2);
  line(x1, y1, x2, y2);
  
}

void keyPressed(){
  if (keyCode == ENTER){
    saveFrame("generative_2_3-####.png");
  }
}