Table table;
TableRow row;
float fData;
int index = 0;
int i = 0;
int mapMin = 0;
int mapMax = 7000;
float lerpFdata;
int timer = 0;
int timerDelay = 1000; // update every second (number is in milliseconds)
float lerpEase = 0.035; // lerp easing factor; 
PFont font;


void setup() {
  //fullScreen();
  size(500, 500); //testing screen
  background(0);
  noCursor();
  font = createFont("Arial", 14, true);
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

  //you may notice this method is rather glitchy or clumsy in its nature
  //  fill(255,fData);

  //we can use a function called lerp to smooth it out
  lerpFdata = lerp(lerpFdata, fData, lerpEase);
  fill(255, lerpFdata);


  noStroke();
  rect(5, 5, width - 10, height - 130);

  //we can also access other information in the CSV to display this in text on the canvas
  // draw text
  fill(255);
  textFont(font);
  textAlign(LEFT);
  //get the information in particular rows (remember 0 counts as a number in computing!)
  TableRow firstRow = table.getRow(0);
  TableRow lastRow = table.getRow(table.getRowCount()-1);
  
  //plot this data 
  text("Start: "+ firstRow.getString("date")+" at:"+(firstRow.getString("time")), 10, height - 90);
  text("End: "+ lastRow.getString("date")+" at:"+(lastRow.getString("time")), 10, height - 70);
  text("Location: 55º51'.26''N 4º14'.35'' W Glasgow, Scotland", 10, height -30);
}