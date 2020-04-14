class Cell {
  int row,col;
  boolean topWall=true;
  boolean rightWall=true;
  boolean bottomWall=true;
  boolean leftWall=true;
  boolean visited = false;
  
  Cell(int i,int j){
    row=i;
    col=j;
  }


Cell checkNeighbors(){
  ArrayList<Cell> neighbors = new ArrayList<Cell>();
  Cell top = grid.get(index(row,col-1));
  Cell right  = grid.get(index(row+1, col));
  Cell bottom = grid.get(index(row, col+1));
  Cell left   = grid.get(index(row-1, col));
  if (top != null && !top.visited) {
      neighbors.add(top);
    }
    if (right != null && !right.visited) {
      neighbors.add(right);
    }
    if (bottom != null && !bottom.visited) {
      neighbors.add(bottom);
    }
    if (left != null && !left.visited) {
      neighbors.add(left);
    }
 if (neighbors.size() > 0) {
      int r = floor(random(0, neighbors.size()));
      return neighbors.get(r);
    } else {
      return null;
    }
  }
  void highlight() {
    int x = this.row*w;
    int y = this.col*w;
    noStroke();
    fill(0, 0, 255, 100);
    rect(x, y, w, w);

  }
  void show() { 
    int x = this.row*w;
    int y = this.col*w;
    stroke(255);
    if (this.topWall) {
      line(x,y,x+w,y);
    }
    if (this.rightWall) {
      line(x + w,y,x+w,y+w);
    }
    if (this.bottomWall) {
      line(x+w,y+w,x,y+w);
    }
    if (this.leftWall) {
      line(x,y+w,x,y);
    }

    if (this.visited) {
      noStroke();
      fill(255, 0, 255, 100);
      rect(x, y, w, w);
    }
  }
}
