import processing.opengl.*;

int _radius = 400;

void setup(){
  size(1920, 1080, OPENGL);
  background(255);
  stroke(0, 10);
  strokeWeight(0.1);
}

void draw(){
  translate(width/2, height/2, 0);
  rotateX(frameCount * 0.04);
  rotateY(frameCount * 0.04);
  
  float s = 0;
  float t = 0;
  float lastX = 0;
  float lastY = 0;
  float lastZ = 0;
  while ( t < 90){
    s += 18;
    t += 1;
    float radianS = radians(s);
    float radianT = radians(t);
    
    float thisX = _radius * cos(radianS) * sin(radianT);
    float thisY = _radius * sin(radianS) * sin(radianT);
    float thisZ = _radius * cos(radianT);
    
    if (lastX != 0){
      line(thisX, thisY, thisZ, lastX, lastY, lastZ);
    }
    lastX = thisX;
    lastY = thisY;
    lastZ = thisZ;  
  }

  saveFrame("frames/generative_4_#####.png"); // 各フレームで画像を保存
}