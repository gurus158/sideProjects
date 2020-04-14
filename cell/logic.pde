int rows,cols;
int w=40;
ArrayList<Cell> grid = new ArrayList<Cell>();

Cell current;
ArrayList<Cell> stack = new ArrayList<Cell>();
public void settings() {
  size(360, 360);
}
void setup() {
  //size(600, 600);
  cols = floor(width/w);
  rows = floor(height/w);
  println(width,height);
  frameRate(25);

  for (int j = 0; j < rows; j++) {
    for (int i = 0; i < cols; i++) {
      Cell cell = new Cell(i, j);
      grid.add(cell);
    }
  }

  current = grid.get(0);

}

void draw() {
  background(51);
  for (int i = 0; i < grid.size(); i++) {
    grid.get(i).show();
  }

  current.visited = true;
  current.highlight();
  

  Cell next = current.checkNeighbors();
  if (next != null) {
    next.visited = true;

  
    stack.add(current);

    removeWalls(current, next);

    current = next;
  } else if (stack.size() > 0) {
    current = stack.remove(stack.size()-1);
  }
}

int index(int i, int j) {
  if (i < 0 || j < 0 || i > cols-1 || j > rows-1) {
    return 0;
  }
  return i + j * cols;
}



void removeWalls(Cell a, Cell b) {
  int x = a.row - b.row;
  if (x == 1) {
    a.leftWall = false;
    b.rightWall = false;
  } else if (x == -1) {
    a.rightWall = false;
    b.leftWall = false;
  }
  int y = a.col - b.col;
  if (y == 1) {
    a.topWall = false;
    b.bottomWall = false;
  } else if (y == -1) {
    a.bottomWall = false;
    b.topWall = false;
  }
}
