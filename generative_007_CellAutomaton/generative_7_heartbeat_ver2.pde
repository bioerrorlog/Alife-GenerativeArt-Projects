Cell[][] _cellArray;
int _cellSize = 2; // Cellの大きさ(pixel)
int _numX, _numY; // ディスプレイのCell格子


void setup() { 
  size(1920, 1080);
  _numX = floor(width/_cellSize);
  _numY = floor(height/_cellSize);
  restart();
} 


void restart() {
  // _cellArrayに画面分のCellを入れる
  _cellArray = new Cell[_numX][_numY];	
  for (int x = 0; x<_numX; x++) {
    for (int y = 0; y<_numY; y++) {	
      Cell newCell = new Cell(x, y);	
      _cellArray[x][y] = newCell;	   
    }				
  }					

  
  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y < _numY; y++) {	
      
      int above = y-1;		
      int below = y+1;		
      int left = x-1;			
      int right = x+1;			
      
      // 画面端の処理
      if (above < 0) { above = _numY-1; }	
      if (below == _numY) { below = 0; }	
      if (left < 0) { left = _numX-1; }	
      if (right == _numX) { right = 0; }	

     _cellArray[x][y].addNeighbour(_cellArray[left][above]);	
     _cellArray[x][y].addNeighbour(_cellArray[left][y]);		
     _cellArray[x][y].addNeighbour(_cellArray[left][below]);	
     _cellArray[x][y].addNeighbour(_cellArray[x][below]);	
     _cellArray[x][y].addNeighbour(_cellArray[right][below]);	
     _cellArray[x][y].addNeighbour(_cellArray[right][y]);	
     _cellArray[x][y].addNeighbour(_cellArray[right][above]);	
     _cellArray[x][y].addNeighbour(_cellArray[x][above]);		
    }
  }
}


void draw() {
  background(200);
  					
  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y < _numY; y++) {
     _cellArray[x][y].calcNextState();
    }
  }
  						
  translate(_cellSize/2, _cellSize/2);  	
						
  for (int x = 0; x < _numX; x++) {
    for (int y = 0; y < _numY; y++) {
     _cellArray[x][y].drawMe();
    }
  }

  saveFrame("frames/generative_7_#####.png");
}


class Cell {
  float x, y;
  float state;  		
  float nextState;  
  float lastState = 0; 
  Cell[] neighbours;
  
  Cell(float ex, float why) {
    x = ex * _cellSize;
    y = why * _cellSize;
    
    // Cellの初期状態を定義
    // 確率で50、それ以外0
    if(random(100) < 1){
      nextState = 50; 
    }else{
      nextState = 0;
    }

    state = nextState;
    neighbours = new Cell[0];
  }
  
  void addNeighbour(Cell cell) {
    neighbours = (Cell[])append(neighbours, cell); 
  }
  
  void calcNextState() {
    /*
    1. もし隣接するセルの状態の平均が0であるなら状態は30に
    2. そうでなければ、新しい状態＝現在の状態＋隣接セルの状態の平均ー前の状態の値
    3. もし新しい状態が255を超えたら255にし、
    4. もし新しい状態が0以下ならそれを0にする
    */
    			
    float total = 0;				
    for (int i=0; i < neighbours.length; i++) {	
       total += neighbours[i].state;		
    }					
    float average = int(total/8);
    			
    if (average == 0) {
      nextState = 30; // 1.
    } else {
      nextState = state + average;
      if (lastState > 0) { nextState -= lastState; } // 2.
      if (nextState > 255) { nextState = 255; } // 3.
      else if (nextState < 0) { nextState = 0; } // 4.
    }
 
    lastState = state;	
  }
  
  void drawMe() {
    state = nextState;
    noStroke();
    fill(255 - state);    
    rect(x, y, _cellSize, _cellSize);
  }
}