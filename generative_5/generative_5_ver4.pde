int _num = 50; // １クリックで生成するCircleの数
Circle[] _circleArr = {};


void setup(){
    size(1920,1080);
    background(255);
    smooth();
    strokeWeight(1);

    addCircles();
}


void draw(){
    for (int i=0; i<_circleArr.length; i++){
        Circle thisCircle = _circleArr[i];
        thisCircle.updateMe();
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
    // マウスクリックで円を追加する
    addCircles();
}


void addCircles() {
    for (int i=0; i< _num; i++){
        Circle thisCircle = new Circle();
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

        colorNoise = random(1);
    }


    void updateMe(){
        x += xMove;
        y += yMove;

        // 画面外に出たときは反対側に移動
        if (x > (width + radius)){x = 0 - radius;}
        if (x < (0 - radius)){x = width + radius;}
        if (y > (height + radius)){y = 0 - radius;}
        if (y < (0 - radius)){y = height + radius;}

        // 他の円と接触しているとき、その接触範囲に円を描画する
        for (int i=0; i<_circleArr.length; i++){
            Circle otherCircle = _circleArr[i];

            if (otherCircle != this){
                float distance = dist(x, y, otherCircle.x, otherCircle.y);
                float overLap = distance - radius - otherCircle.radius;

                if ((overLap < 0)){ // 他の円と接触している場合
                    float midX, midY;
                    midX = (x + otherCircle.x) / 2;
                    midY = (y + otherCircle.y) / 2;

                    stroke(0, 1);
                    noFill();
                    overLap *= -1; // overLapを正の値に
                    ellipse(midX, midY, overLap, overLap); // 重複分の幅を持った円を描画
                }
            }
        }
    }
}