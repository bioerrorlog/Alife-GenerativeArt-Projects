int _cellSize;
int _numY, _numX;

int[][] _state;
int[][] _nextState;

void setup(){
  size(1920, 1080);
  background(0);
  smooth();

  _cellSize = 5;
  _numY = floor(height/_cellSize);
  _numX = floor(width/_cellSize);

  _state = new int[_numX][_numY];
  _nextState = new int[_numX][_numY];

  // 初期状態をランダムに設定
  for(int i = 0; i < _numX; i++){
    for(int j = 0; j < _numY; j++){
      if(random(2) > 1){
		    _state[i][j] = 0;
			}else{
		    _state[i][j] = 1;
			}
    }
  }
  
  // Fill cells based on each status
  for(int i = 0; i < _numX; i++){
    for(int j = 0; j < _numY; j++){
      if(_state[i][j] == 0){
        fill(0);
      }else{
        fill(255);
      }
      rect(_cellSize*i, _cellSize*j, _cellSize, _cellSize); 
    }
  }
}


// If coordinate point is under 0, it's converted to opposite side
int convert__numY(int point){
  if(point < 0){
    return _numY + point;
  }
  return point;
}

int convert__numX(int point){
  if(point < 0){
    return _numX + point;
  }
  return point;
}


void draw(){

  for(int i = 0; i < _numX; i++){
    for(int j = 0; j < _numY; j++){
    
      // Get cell status
      // c: center (cell self)
      // nw: north west, n: north, ne: north east ...
      // If c at the edge, it's converted to opposite side
			
      
      int nw = _state[convert__numX(i-1)][convert__numY(j-1)];
      int n  = _state[convert__numX(i-1)][j];
      int ne = _state[convert__numX(i-1)][(j+1)%_numY];
      int w  = _state[i][convert__numY(j-1)];
      int c  = _state[i][j];
      int e  = _state[i][(j+1)%_numY];
      int sw = _state[(i+1)%_numX][convert__numY(j-1)];
      int s  = _state[(i+1)%_numX][j];
      int se = _state[(i+1)%_numX][(j+1)%_numY];
      int neighbor_cell_sum = nw + n + ne + w + e + sw + s + se;
      
      // Cell dead or alive
      if(c == 0 && neighbor_cell_sum == 3){
        // dead -> alive
        _nextState[i][j] = 1;
      }else if(c == 1 && (neighbor_cell_sum == 2 || neighbor_cell_sum == 3)){
        // Keep alive
        _nextState[i][j] = 1;
      }else{
        // dead
        _nextState[i][j] = 0;
      }
    }
  }
  
  
  // Update canvas and
  // Draw each cell
  for(int i = 0; i < _numX; i++){
    for(int j = 0; j < _numY; j++){
      // Update
      _state[i][j] = _nextState[i][j];
      
      // Fill cells based on their status
      if(_state[i][j] == 0){
        // Cell dead
        fill(0); // Black
      }else{
        // Cell alive
        fill(255); // While
      }
      // Draw rect
      rect(_cellSize*i, _cellSize*j, _cellSize, _cellSize); 
    }
  }
}


