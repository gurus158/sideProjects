class Cell{
  int i,j;
  int digit;
  boolean fixed = false;
  
  Cell(int row,int col){
    i=row;
    j=col;
    digit=0;
    fixed = false;
  }
  
  void show(){
  int x=this.i*w;
  int y=this.j*w;
  stroke(255);
  line(x    , y    , x + w, y);
  line(x + w, y    , x + w, y + w);
  line(x + w, y + w, x    , y + w);
  line(x    , y + w, x    , y);
  textSize(20);
  if(this.fixed)
  fill(0, 255 , 0);
  else fill(255,255,255);
  if(this.digit==0)
  text("",x+w/2,y+w/2);
  else
  text(String.valueOf(this.digit),x+w/2,y+w/2);
  //text(String.valueOf(this.cube),x+w/2,y+w/2);
}
  void highlight() {
    int x = this.i*w;
    int y = this.j*w;
    stroke(255);
    fill(255,255,255);
    text(String.valueOf(this.digit),x+w/2,y+w/2);

  }
  
}
