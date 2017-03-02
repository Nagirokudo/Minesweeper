import de.bezier.guido.*;
//Declare and initialize NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to declare and initialize buttons goes here
    buttons = new MSButton[NUM_COLS][NUM_ROWS];
    for (int r =0; r < NUM_ROWS; r++)
    {
        for (int c = 0; c < NUM_COLS; c++)
        {
            buttons[r][c] = new MSButton(r,c);
        }
    }
    bombs = new ArrayList<MSButton>();
    setBombs();

}
public void setBombs()
{
    //your code
    for (int r = 0; r < 30; r++)
    {
        int rBombs = (int)(Math.random()*NUM_ROWS);
        int cBombs = (int)(Math.random()*NUM_COLS);
        if (!bombs.contains(buttons[rBombs][cBombs]))
        {
            bombs.add(buttons[rBombs][cBombs]);
            //System.out.println(rBombs +", " + cBombs);       
        }
    }
}

public void draw ()
{
    background(0);
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for (int r = 0; r < NUM_ROWS; r++)
    {
        for (int c = 0; c < NUM_COLS; c++)
        {
            if(!buttons[r][c].isMarked() &&  !buttons[r][c].isClicked())
            {
                return false;
            }
        }
    }
    return true;
}
public void displayLosingMessage()
{
    //your code here
    
    buttons[10][5].setLabel("Y");
    buttons[10][6].setLabel("O");
    buttons[10][7].setLabel("U");
    buttons[10][9].setLabel("L");
    buttons[10][10].setLabel("O");
    buttons[10][11].setLabel("S");
    buttons[10][12].setLabel("E");

}
public void displayWinningMessage()
{
    //your code here
    
    buttons[10][5].setLabel("Y");
    buttons[10][6].setLabel("O");
    buttons[10][7].setLabel("U");
    buttons[10][9].setLabel("W");
    buttons[10][10].setLabel("I");
    buttons[10][11].setLabel("N");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = false;
        clicked = false;
        Interactive.add(this); // register it with the manager
    }
    public boolean isMarked()
    {
        
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        //your code here
        //if keyPressed is true, toggles marked to either either true or false. If marked is false set click to false

        if(keyPressed)
        {
            marked = !marked;  
        }
        // else if bombs contains this button display the losing message
        else if (bombs.contains(this))
        {
            displayLosingMessage();
        }
        // else if countBombs returns a number of neighboring mines greater than zero, set the label to that number
        else if (countBombs(r, c) > 0)
        {
            setLabel("" + countBombs(r,c));
        }

        // else recursively call mousePressed with the valid, unclicked, neighboring buttons in all 8 directions
        else 
        {
            clicked = true;
            //System.out.println(r + ", " + c);
            if (isValid(r-1, c-1) && !buttons[r-1][c-1].clicked)
            {
                buttons[r-1][c-1].mousePressed();
            }

            if (isValid(r-1, c) && !buttons[r-1][c].clicked)
            {
                buttons[r-1][c].mousePressed();
            }

            if (isValid(r-1, c+1) && !buttons[r-1][c+1].clicked)
            {
                buttons[r-1][c+1].mousePressed();
            }

            if (isValid(r, c-1) && !buttons[r][c-1].clicked)
            {
                buttons[r][c-1].mousePressed();
            }

            if (isValid(r, c+1) && !buttons[r][c+1].clicked)
            {
                buttons[r][c+1].mousePressed();
            }

            if (isValid(r+1, c-1) && !buttons[r+1][c-1].clicked)
            {
                buttons[r+1][c-1].mousePressed();
            }

            if (isValid(r+1, c) && !buttons[r+1][c].clicked)
            {
                buttons[r+1][c].mousePressed();
            }

            if (isValid(r+1, c+1) && !buttons[r+1][c+1].clicked)
            {
                buttons[r+1][c+1].mousePressed();
            }

        }

    }

    public void draw () 
    {    
        if (marked == true)
            fill(0, 0, 255);
        
        else if(clicked == true && bombs.contains(this) ) 
            fill(255,0,0);

        else if(clicked)
            fill(#80ffbf);
        else 
            fill(#ffb3ff);

        rect(x, y, width, height, 5);
        fill(0);
        stroke(50);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        //your code here
        if (r >= 0 && r < NUM_ROWS)
        {
            if (c >= 0 && c < NUM_COLS)
            {
                 return true;
            }
        }
           
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        //your code here
        if (isValid(row-1, col-1) && bombs.contains(buttons[row-1][col-1]))
        {
            numBombs++;
        }
        if (isValid(row-1, col) && bombs.contains(buttons[row-1][col]))
        {
            numBombs++;
        }
        if (isValid(row-1, col+1) && bombs.contains(buttons[row-1][col+1]))
        {
            numBombs++;
        }
        if (isValid(row, col-1) && bombs.contains(buttons[row][col-1]))
        {
            numBombs++;
        }
        if (isValid(row, col+1) && bombs.contains(buttons[row][col+1]))
        {
            numBombs++;
        }
        if (isValid(row+1, col-1) && bombs.contains(buttons[row+1][col-1]))
        {
            numBombs++;
        }
        if (isValid(row+1, col) && bombs.contains(buttons[row+1][col]))
        {
            numBombs++;
        }
        if (isValid(row+1, col+1) && bombs.contains(buttons[row+1][col+1]))
        {
            numBombs++;
        }

        return numBombs;
    }
}



