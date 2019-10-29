/*
  Conwey's Game of Life model
  
  References:
  https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life
  https://github.com/alifelab/alife_book_src/blob/master/chap02/game_of_life.py
*/


// ---- Parameters ----

// Starting cell status
// Low: Many alive cells  <-->  High: Less alive cells
int STARTING_STATUS = 2;

// Area length of this model
int LENGTH = 200;

// Frame rate
int FRAME_RATE = 20;

// ---- Parameters end ----


// Define size of this model
int WIDTH = LENGTH;
int HEIGHT = LENGTH;

// Define model state
int[][] state = new int[HEIGHT][WIDTH];
int[][] next_state = new int[HEIGHT][WIDTH];


// Set up canvas
void setup(){

  // Canvas size
  size(700,700);
  // Backgroud color
  background(#161616); // Black
  
  // Frame rate
  frameRate(FRAME_RATE);
  
  // Draws all geometry with smooth anti-aliased edges
  smooth();

  // Set up starting status randomly
  for(int i = 0; i < HEIGHT; i++){
    for(int j = 0; j < WIDTH; j++){
      if(random(STARTING_STATUS) > 1){
		    state[i][j] = 0;
			}else{
		    state[i][j] = 1;
			}
    }
  }
  
  // Fill cells based on each status
  for(int i = 0; i < HEIGHT; i++){
    for(int j = 0; j < WIDTH; j++){
      if(state[i][j] == 0){
        fill(#161616); // Black
      }else{
        fill(255); // While
      }
      rect(width/WIDTH*i, height/HEIGHT*j, width/WIDTH, height/HEIGHT); 
    }
  }
}


// If coordinate point is under 0, it's converted to opposite side
int convert(int point){
  if(point < 0){
    return LENGTH + point;
  }
  return point;
}


void draw(){

  for(int i = 0; i < HEIGHT; i++){
    for(int j = 0; j < WIDTH; j++){
    
      // Get cell status
      // c: center (cell self)
      // nw: north west, n: north, ne: north east ...
      // If c at the edge, it's converted to opposite side
      
      int nw = state[convert(i-1)][convert(j-1)];
      int n  = state[convert(i-1)][j];
      int ne = state[convert(i-1)][(j+1)%WIDTH];
      int w  = state[i][convert(j-1)];
      int c  = state[i][j];
      int e  = state[i][(j+1)%WIDTH];
      int sw = state[(i+1)%HEIGHT][convert(j-1)];
      int s  = state[(i+1)%HEIGHT][j];
      int se = state[(i+1)%HEIGHT][(j+1)%WIDTH];
      int neighbor_cell_sum = nw + n + ne + w + e + sw + s + se;
      
      // Cell dead or alive
      if(c == 0 && neighbor_cell_sum == 3){
        // dead -> alive
        next_state[i][j] = 1;
      }else if(c == 1 && (neighbor_cell_sum == 2 || neighbor_cell_sum == 3)){
        // Keep alive
        next_state[i][j] = 1;
      }else{
        // dead
        next_state[i][j] = 0;
      }
    }
  }
  
  
  // Update canvas and
  // Draw each cell
  for(int i = 0; i < HEIGHT; i++){
    for(int j = 0; j < WIDTH; j++){
      // Update
      state[i][j] = next_state[i][j];
      
      // Fill cells based on their status
      if(state[i][j] == 0){
        // Cell dead
        fill(#161616); // Black
      }else{
        // Cell alive
        fill(255); // While
      }
      // Draw rect
      rect(width/WIDTH*i, height/HEIGHT*j, width/WIDTH, height/HEIGHT); 
    }
  }
}
