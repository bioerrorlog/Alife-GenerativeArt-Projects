PImage _img;
float _noiseScale;


void setup(){
    _img = loadImage("img.jpg"); // 画像はスケッチフォルダに入れておく
    _noiseScale = 0.005;

    size(1478, 1108); // 今回読み込む画像と同じサイズで
    background(255);
}


void draw(){
    /*
    画像から取得したピクセルカラー情報を用いて線を描く
    線を引く方向はxy情報に基づいた2次元noiseで流す
    */

    for (int i = 0; i < 100; i++){
        float x = random(_img.width);
        float y = random(_img.height);
        color col = _img.get(int(x), int(y)); // 画像のピクセルカラー情報を取得
        float noiseFactor = noise(x*_noiseScale, y*_noiseScale); // 2次元noise
        float lineLength = noiseFactor * 40; // ここで線の長さを調整
        
        pushMatrix();
            translate(x, y);
            rotate(noiseFactor * radians(180)); // ここで線の流れ具合を調整
            stroke(col);
            strokeWeight(8);
            line(0, 0, lineLength, lineLength);
        popMatrix();
    }
}


void keyPressed(){
    /*
    ENTERキー押下: 画像を保存する
    BACKSPACEキー押下: リセット
    */
    
    if (keyCode == ENTER){
        saveFrame("generative_8_####.png");
    }
    if (keyCode == BACKSPACE){
        setup();
    }
}