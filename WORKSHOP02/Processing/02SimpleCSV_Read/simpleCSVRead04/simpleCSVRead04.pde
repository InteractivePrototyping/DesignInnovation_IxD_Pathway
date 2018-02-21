Table rawData;
int step = 5;
int maxDataValue = -MAX_INT; // makes sure that whatever data there is has to be bigger
int minDataValue = MAX_INT; /// makes sure that whatever data there is has to be smaller
color highColour = #835CFC;
color lowColour  = #9DFF17;


void setup() {
  size(1000, 800);
  // LOAD DATA (note use of "header" as data file contains headers);
  rawData = loadTable("data.csv", "header");
  println(rawData.getRowCount()+" rows of data");

  // We are going to compute the maximum and minimum data values
  // by stepping through each row of data
  // and checking to see if bigger than existing biggest value.
  // We need this for displaying our data later.
  // Let's iterate through the whole CSV document row by row  
  for (int i = 0; i < rawData.getRowCount(); i++) {
    // Get a row of data...
    TableRow row  = rawData.getRow(i);
    // Read the data from the row using the headers and put into variables...
    int val  = row.getInt("Val");  // assign whatever is in the 'Val' column to the temporary variable val
    // String name = row.getString("Name"); // assign whatever is in the 'Name' column to the temporary variable name
    // if higher, then put the higher value into global variable maxDataValue
    maxDataValue = max(maxDataValue, val); 
    minDataValue = min(minDataValue, val); 
    //print the contents of this row to the console
    //println("Name: " + name + ", Val: "+val);
  }
  println("MAX DATA VALUE: "+maxDataValue);
  println("MIN DATA VALUE: "+minDataValue);
}

void draw() {
  //colour of background canvas
  background(64);

  //position the data onto the canvas
  translate(0, height - 100);
  stroke(255, 200);
  strokeWeight(step*0.75);
  strokeCap(SQUARE);

  //iterate through the whole CSV document row by row
  for (int i = 0; i < rawData.getRowCount(); i++) {
    // Get a row of data...
    TableRow row  = rawData.getRow(i);
    // Read the data from the row using the headers and put into variables...
    int val  = row.getInt("Val");  // assign whatever is in the 'Val' column to the temporary variable val
    String name = row.getString("Name"); // assign whatever is in the 'Name' column to the temporary variable name

    // draw line using values row of data
    float mappedColour = map(val, minDataValue, maxDataValue, 0, 1); // map the data using maxDataValue variable into a range of 0 to 1 
    color lerpedColour = lerpColor(lowColour, highColour, mappedColour); // use lerpColor() to do map this to a colour from lowColour to highColour
    stroke(lerpedColour); // set the line we're about to draw to this colour!
    float mappedValue = map(val, minDataValue, maxDataValue, 0, -height + 100); // map the data into our display area range using maxDataValue variable
    line(i*step, 0, i*step, mappedValue); // draw the line

    // Let's also show the value of each val
    // We'll attach a small rotated text label to the top of each line
    pushMatrix(); // we need to push the transformation matrix before we draw this element
    translate(i*step, mappedValue - 5); // ...so that we can move stuff into position
    rotate(-HALF_PI); // ...and rotate it
    textAlign(LEFT, CENTER); // ... and set up the text alignment
    textSize(4); // ... and set up the text size
    //use the val data to display to the screen
    text(val, 0, 0); // now draw the actual text!
    popMatrix(); // ... and pop the transformation matrix back to what it was when we are done drawing this element

    // What if we want to label each line with the second column of data?
    // Let's display the text labels at the bottom of each line.
    // So again...
    pushMatrix(); // we need to push the transformation matrix before we draw this element
    translate(i*step, 5);
    rotate(-HALF_PI); 
    textAlign(RIGHT, CENTER);
    textSize(4);
    //notice how we use the name variable within the text function. 
    text(name.toUpperCase(), 0, 0); // draw the actual text setting it uppercase to make it look tidy
    popMatrix();
  }
}