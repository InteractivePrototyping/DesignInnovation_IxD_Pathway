Table rawData;
// rawData is an arbitrary name - could be anything you like 

float gCircleScalar = 7;


// Do all your data parsing in setup()
void setup() {
  size(1500, 1000);
  rawData = loadTable("data.csv", "header");
  //iterate through the whole CSV document row by row in order to print to console. 
  for (int i = 0; i < rawData.getRowCount (); i++) {
    TableRow dataRow    = rawData.getRow(i);
    String food     = dataRow.getString("Food purchased"); // assign whatever is in the 'Food' column to the variable food
    int cals        = dataRow.getInt("Kcal/100g Energy Value*");  // assign whatever is in the 'Calories' column to the variable cals

    println(food + " has " + cals +" calories"); // print it to the console
  }
  noLoop();
}


void draw() {
  background(0);

  int i = 0; // initialise our row counter
  // as our data set has 45 entries, our grid will be 9 x 5
  for (int y = 0; y < 5; y++) { // for each row...
    for (int x = 0; x < 9; x++) { // run across a column
      TableRow dataRow; // local variable row is a table row
      dataRow = rawData.getRow(i); // which row? initially first row, 0

      int cals = dataRow.getInt("Kcal/100g Energy Value*"); //get calories integer
      String food = dataRow.getString("Food purchased"); //get food names string

      int tX = 120 + (x * 150); // This is the x location of the circle; 120 is the inset from the left edge; circles are 150 pixels apart
      int tY = 90 + (y * 200); // This is the y location of the circle; 90 is the inset from the top; circles are 200 pixels apart

      //lets use the calories values to plot circles on the canvas.
      float r = sqrt(cals)*gCircleScalar;  // calculate the radius of the circle we will plot
      fill(255);
      ellipse(tX, tY, r, r); // using tx and ty we calculated above alongside our calculated radius. 
      fill(0);
      textSize(24);
      textAlign(CENTER, CENTER);
      text(i, tX, tY);
      i++; // increment our data row counter
    }
  }
}