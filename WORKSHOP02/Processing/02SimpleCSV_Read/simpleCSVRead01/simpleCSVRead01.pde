Table rawData;
int step = 5;
int maxDataValue = -MAX_INT; // makes sure that whatever data there is has to be bigger
int minDataValue = MAX_INT; /// makes sure that whatever data there is has to be smaller



void setup() {
  size(1000, 800);
  // LOAD DATA (note use of "header" as data file contains headers);
  rawData = loadTable("data.csv", "header");
  //println(rawData.getRowCount());

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
    String name = row.getString("Name"); // assign whatever is in the 'Name' column to the temporary variable name
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
    float mappedValue = map(val, minDataValue, maxDataValue, 0, -height + 100); // map the data into our display area range using maxDataValue variable
    line(i*step, 0, i*step, mappedValue); // draw the line
  }
}