Table table;
TableRow row;
float fData;
int index = 0;
int i = 0;
int mapMin = 0;
int mapMax = 7000;
int timer = 0;
int timerDelay = 1000; // update every second (number is in milliseconds)

void setup() {
  //fullScreen();
  size(500, 500); //testing screen
  background(0);
  noCursor();

//initialise the CSV file. 
  table = loadTable("data.csv", "header");
  row = table.getRow(0);
  frameRate(60); // this is set to default of 60 for smooth lerp animation
}

void draw () {
  background(0);
  
  // delay update of new data and reset timer
  //if millis counter is greater than our timer...
  if (millis() >= timer) {
    //timer = current millis counter + our timerDelay
    timer = millis() + timerDelay;
    
    row = table.getRow(i); // get a new row of data
    fData = map(row.getInt("lux"), mapMin, mapMax, 0, 255); // get specific "lux" data from row and put it in a usable range
    
    // increment row counter
    i++;
    
    //  check to see if at end of data
    if (i == table.getRowCount()) {
      i = 0;//if so, loop back to first row
    }
  }


  fill(255,fData);

  noStroke();
  rect(5, 5, width - 10, height - 130);


}