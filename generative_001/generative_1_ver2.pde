void setup(){
  size(1920,1080);
  background(0);
  strokeWeight(0.2);
  smooth();
}


void draw(){
  int centx = width / 2;
  int centy = height / 2;
  float x, y;
  for (int i = 0; i < 10; i++){
    float lastx = -999;
    float lasty = -999;
    float radiusNoise = random(10);
    float radius = 10;
    stroke(255, random(10));
    int startAngle = int(random(360));
    int endAngle = int(random(1440)) + 360 * 6;
    int angleStep = int(random(3)) + 1;
    for (float ang = startAngle; ang < endAngle; ang += angleStep){
      radiusNoise += 0.05;
      radius += 0.5;
      float thisRadius = radius + (noise(radiusNoise) * 200) - 100;
      float rad = radians(ang);
      x = (centx + (thisRadius * cos(rad)));
      y = centy + (thisRadius * sin(rad));
      if (lastx > -999){
        line(x, y, lastx, lasty);
      }
      lastx = x;
      lasty = y;
    } 
  }

  saveFrame("frames/generative_1_#####.png"); // 各フレームで画像を保存 
}
