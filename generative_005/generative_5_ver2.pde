int _num = 10; // １クリックで生成するCircleの数
Circle[] _circleArr = {};


void setup(){
    size(1920,1080);
    background(255);
    smooth();
    strokeWeight(1);
    fill(150, 50);

    drawCircles();
}


void draw(){
    background(255); // 画面をリフレッシュ
    for (int i=0; i<_circleArr.length; i++){
        Circle thisCircle = _circleArr[i];
        thisCircle.updateMe();
        thisCircle.drawMe();
    }
}


void keyPressed(){
    /*
    ENTERキー押下: 画像を保存する
    BACKSPACEキー押下: setup()を呼んでモデルをリセットする
    */
    
    if (keyCode == ENTER){
        saveFrame("generative_5_####.png");
    }
    if (keyCode == BACKSPACE){
        setup();
    }
}


void mouseReleased(){
    drawCircles();
}


void drawCircles() {
    for (int i=0; i< _num; i++){
        Circle thisCircle = new Circle();
        thisCircle.drawMe();
        _circleArr = (Circle[])append(_circleArr, thisCircle);
    }
}


class Circle{
    float x, y;
    float xMove, yMove;
    float radius;
    color lineColor, fillColor;
    float alpha;
  
    Circle(){
        x = random(width);
        y = random(height);

        xMove = random(10) - 5;
        yMove = random(10) - 5;

        radius = random(500) + 50;
        lineColor = color(random(255), random(255), random(255));
        fillColor = color(random(255), random(255), random(255));
        alpha = random(255);
    }
  
    void drawMe(){
        noStroke();
        fill(fillColor, alpha);
        ellipse(x, y, radius*2, radius*2);
    }

    void updateMe(){
        x += xMove;
        y += yMove;

        // 画面外に出たときは反対側に移動
        if (x > (width + radius)){x = 0 - radius;}
        if (x < (0 - radius)){x = width + radius;}
        if (y > (height + radius)){y = 0 - radius;}
        if (y < (0 - radius)){y = height + radius;}

        // 衝突判定 
        boolean isTouching = false;
        for (int i=0; i<_circleArr.length; i++){
            Circle otherCircle = _circleArr[i];
            if (otherCircle != this){
                float distance = dist(x, y, otherCircle.x, otherCircle.y);
                if ((distance - radius - otherCircle.radius < 0)){
                    isTouching = true;
                    break;
                }
            }
        }

        // ほかの円と重なってたらalphaを下げる
        // 重なってなかったらalphaを上げる
        if (isTouching){
            if (alpha > 0){alpha -= 1;}
        } else {
            if (alpha < 255){alpha += 2;}
        }
    }
}