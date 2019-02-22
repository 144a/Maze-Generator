
// Dimension of Maze
int n = 10;

// Scale of maze
int scale = 10;

// Total stack of places left to check
// Has X pos, Y pos, and Direction
ArrayList<Integer> xstack = new ArrayList<Integer>();
ArrayList<Integer> ystack = new ArrayList<Integer>();
ArrayList<Integer> dstack = new ArrayList<Integer>();

// Board with record of where the head has already been
int[][] board = new int[n][n];

// Initial Variables
int curX;
int curY;
int curD;

// Generates Random Check for side positions
public int[] randCheck() {
  int tempNum;
  int count = 0;
  int[] temp = new int[4]; 
  int[] check = {1,1,1,1};
  while(check[0] == 1 || check[1] == 1 || check[2] == 1 || check[3] == 1) {
    tempNum = int(random(0,4));
    if(check[tempNum] != 0) {
      temp[count] = tempNum + 1;
      check[tempNum] = 0;
      count++;
    }
  }
  return temp; 
}

// Drawing Routine
public void drawPoint(int x, int y, int direction) {
  x = (x + 1) * 2;
  y = (y + 1) * 2;
  rect(x * (scale + 1), y * (scale + 1), scale, scale);
  if(direction == 1) {
    rect(x * (scale + 1), (y + 1) * (scale + 1), scale, scale);
  }
  if(direction == 2) {
    rect((x + 1) * (scale + 1), y * (scale + 1), scale, scale);
  }
  if(direction == 3) {
    rect(x * (scale + 1), (y - 1) * (scale + 1), scale, scale);
  }
  if(direction == 4) {
    rect((x - 1) * (scale + 1), y * (scale + 1), scale, scale);
  }
  if(direction == -1) {
    fill(125);
    rect(x * (scale + 1), y * (scale + 1), scale, scale);
    fill(255);
  }
}


void setup() {
  size(2000, 2000);
  background(0);
  
  // Initial stack values
  xstack.add(0,0);
  ystack.add(0,0);
  dstack.add(0,-1);
  
  // Initial Values for startup
  curX = 0;
  curY = 0;
  curD = -1;
  frameRate(9000);
}

void keyPressed() {
   exit();
}


// Main Loop
void draw() {
  if(isSolving == false) {
    drawPoint(curX, curY, -1);
    drawPoint(curX, curY, curD);
    // Grab most recent point from the Stack until we find a location we haven't visited yet
    while(xstack.size() != 0 && board[curX][curY] != 0) {
      curX = xstack.get(xstack.size() - 1);
      xstack.remove(xstack.size() - 1);
      curY = ystack.get(ystack.size() - 1);
      ystack.remove(ystack.size() - 1);
      curD = dstack.get(dstack.size() - 1);
      dstack.remove(dstack.size() - 1);
    }
    
    // Record that this point has been reached
    board[curX][curY] = 1;
    
    // Draw point to the screen
    drawPoint(curX, curY, curD);
    
    // Check all points around it in a random order
    // Assuming they are in bounds
    int[] arr = randCheck();
    for(int i = 0; i < 4; i++){
      if(arr[i] == 3 && curX > 0 && board[curX - 1][curY] != 1) {
        xstack.add(curX - 1);
        ystack.add(curY);
        dstack.add(2);
      }
      if(arr[i] == 2 && curX < n - 1 && board[curX + 1][curY] != 1) {
        xstack.add(curX + 1);
        ystack.add(curY);
        dstack.add(4);
      }
      if(arr[i] == 1 && curY > 0 && board[curX][curY - 1] != 1) {
        xstack.add(curX);
        ystack.add(curY - 1);
        dstack.add(1);
      }
      if(arr[i] == 4 && curY < n - 1 && board[curX][curY + 1] != 1) {
        xstack.add(curX);
        ystack.add(curY + 1);
        dstack.add(3);
      }
    }
    drawPoint(curX, curY, curD);
    
    if(xstack.size() == 0) {
      println("Done Generating Maze");
    }
  } 
}
