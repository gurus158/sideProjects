import java.util.Collections;
int row,col;
int w=40;
Cell[][] grid=new Cell[9][9];
//ArrayList<Cell> stack = new ArrayList<Cell>();

int[] puzzel={0,0,0,9,4,3,0,0,0,0,6,0,0,1,0,0,5,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,3,7,5,0,0,6,0,0,1,4,1,0,0,0,0,0,0,0,9,0,0,0,0,0,0,0,0,0,0,2,0,0,5,0,0,8,0,0,0,0,3,7,4,0,0,0};
public void settings(){
  size(360,360);
}
void setup(){
  col=floor(width/w);
  row=floor(height/w);
  //println(width,height);
  //frameRate(5);
  int counter=0;
  for (int j = 0; j < row; j++) {
    for (int i = 0; i < col; i++) {
      //println(i,j);
      Cell cell = new Cell(i, j);
      
      if(puzzel[counter++]!=0){
      cell.digit=(puzzel[counter-1 ]);
      cell.fixed=true;
      
  }
  grid[i][j]=cell;
    }
  }
  }

void draw(){
  background(51);
  for(int j =0 ; j<9;j++){
    for(int i=0;i<9;i++)
    grid[i][j].show();
  }
  solve(grid);
}

int cubevalue(int i,int j){
   if(i>=0 &&i<=2 && j>=0&&j<=2){
        return 0;
      }
      if(i>=3 &&i<=5 && j>=0&&j<=2){
        return 1;
      }
      if(i>=6 &&i<=8 && j>=0&&j<=2){
        return 2;
      }
      if(i>=0 &&i<=2 && j>=3&&j<=5){
        return 3;
      }
      if(i>=3 &&i<=5 && j>=3&&j<=5){
        return 4;
      }
      if(i>=6 &&i<=8 && j>=3&&j<=5){
        return 5;
      }
      if(i>=0 &&i<=2 && j>=6&&j<=8){
        return 6;
      }
      if(i>=3 &&i<=5 && j>=6&&j<=8){
        return 7;
      }
      if(i>=6 &&i<=8 && j>=6&&j<=8){
        return 8;
      }
      return -1;
      
}
boolean solve(Cell[][] sudoku){
  for(int row=0;row<9;row++)
    {
        for(int col=0;col<9;col++)
        {
            if(sudoku[row][col].digit==0)
            {
                for(int number=1;number<=9;number++)
                {
                    if(isAllowed(row, col, number,sudoku))
                    {
                        sudoku[row][col].digit = number;
                        if(solve(sudoku))
                        {
                            return true;
                        }
                        else
                        {
                            sudoku[row][col].digit = 0;
                        }
                        
                    }
                }
                return false;
            }
        }
    }
    return true;
  }
  boolean isAllowed(int row, int col,int number,Cell[][] sudoku)
{
    return !(containsInRow(row, number,sudoku) || containsInCol(col, number,sudoku) || containsInBox(row, col, number,sudoku));
}
boolean containsInRow(int row,int number,Cell[][] sudoku)
{
    for(int i=0;i<9;i++)
    {
        if(sudoku[row][i].digit==number)
        {
            return true;
        }
    }
    return false;
}
  boolean containsInCol(int col,int number,Cell[][] sudoku)
{
    for(int i=0;i<9;i++)
    {
        if(sudoku[i][col].digit==number)
        {
            return true;
        }
    }
    return false;
}
boolean containsInBox(int row, int col,int number,Cell[][] sudoku)
{
    int r = row - row%3;
    int c = col - col%3;
    for(int i = r ; i< r+3 ; i++)
    {
        for(int j = c; j < c+3 ; j++)
        {
            if(sudoku[i][j].digit==number)
            {
                return true;
            }
        }
          
    }
    return false;
}
