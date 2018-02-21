Table rawData;
// rawData is an arbitrary name - could be anything you like 

float gCircleScalar = 7;
int gMinVal = 100;
int gMaxVal = 100;
int cals;
int tX, tY;

// Do all your data parsing in setup()
void setup() {
  size(1500, 1000);
  rawData = loadTable("data.csv", "header");
  //iterate through the whole CSV document row by row in order to print to console. 
  for (int i = 0; i < rawData.getRowCount (); i++) {
    TableRow dataRow = rawData.getRow(i);
    String food     = dataRow.getString("Food purchased"); // assign whatever is in the 'Food' column to the variable food
    int cals        = dataRow.getInt("Kcal/100g Energy Value*");  // assign whatever is in the 'Calories' column to the variable cals

    println(food + " has " + cals +" calories"); // print it to the console


    // Also, gets the min and max values in the entire data set
    // This is to drive the lerpColor() function further down
    // to control the colour spread in the dataColour() handler
    //ask a question:
    if (cals < gMinVal) { // is this value of cals less than existing min?
      gMinVal = cals; // if so, save it
    }
    if (cals > gMaxVal) { // is this value of cals more than the existing max?
      gMaxVal = cals; // if so save it
    }
  }
}


void draw() {
  background(0);

  int i = 0; // initialise our row counter
  // as our data set has 45 entries, our grid will be 9 x 5
  for (int y = 0; y < 5; y++) { // for each row...
    for (int x = 0; x < 9; x++) { // run across a column
      TableRow dataRow; // local variable dataRow is a table row
      dataRow = rawData.getRow(i); // which row? initially first row, 0

      cals = dataRow.getInt("Kcal/100g Energy Value*"); //get calories integer
      String food = dataRow.getString("Food purchased"); //get food names string

      tX = 120 + (x * 150); // This is the x location of the circle; 120 is the inset from the left edge; circles are 150 pixels apart
      tY = 90 + (y * 200); // This is the y location of the circle; 90 is the inset from the top; circles are 200 pixels apart

      //lets use the food lables to label each circle
      fill(255);
      textAlign(CENTER, TOP);
      textSize(14);
      textLeading(14);
      rectMode(CENTER);
      text(food, tX, tY + 120, 100, 100); // offset slightly from the centre of the circle in the y axis
      //here we are calling that function we made. 
      dataColour(tX, tY, cals);
      i++; // increment our data row counter
    }
  }
}


//we can put code in our own function to make different actions clearer
//we can then 'call' this in our draw loop higher up. 
void dataColour(int tX, int tY, int cals) {
  colorMode(HSB);
  // calculate the colour we want it to be
  color fromColour = color(#000099); // lowest value
  color toColour = color(#FF3BD5); // highest value
  float tLerpColour = map(cals, gMinVal, gMaxVal, 0, 1.0); //  map cals using gMaxVal and gMinVal to get a float between 0.0 and 1.0 to drive lerpColor()
  color tColour = lerpColor(fromColour, toColour, tLerpColour);  // get the colour

  fill(tColour); // set the colour
  noStroke();

  //lets get the key code that draw our circles and move it into this function so we can use the above colour calculations
  //lets use the calories values to plot circles on the canvas.
  float r = sqrt(cals)*gCircleScalar;  // calculate the radius of the circle we will plot
  ellipseMode(CENTER);
  ellipse(tX, tY, r, r); // using tx and ty we calculated above alongside our calculated radius.

  // Draw text showing cals amount
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(24);
  text(cals, tX, tY); // show it in the centre of the circle
}