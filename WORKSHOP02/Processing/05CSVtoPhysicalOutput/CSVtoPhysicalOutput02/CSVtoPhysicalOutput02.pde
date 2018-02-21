/*
we will build on the same sketch for continous data stream but also 
 send this over to a physical output alongside visualising it on the screen
 */

//we need these libaries to communicate with Arduino
import processing.serial.*;

import cc.arduino.*;

Arduino arduino;


Table table;
TableRow row;
float fData;
int index = 0;
int i = 0;
int mapMin = 0;
int mapMax = 7000;
float lerpFdata;
int timer = 0;
int timerDelay = 5000; // update every second (number is in milliseconds)
float lerpEase = 0.035; // lerp easing factor; 

void setup() {
  //fullScreen();
  size(500, 500); //testing screen
  background(0);
  noCursor();

  //initialise the CSV file. 
  table = loadTable("data.csv", "header");
  row = table.getRow(0);
  frameRate(60); // this is set to default of 60 for smooth lerp animation

  // Prints out the available serial ports.
  printArray(Arduino.list());

  // Modify this line, by changing the "0" to the index of the serial
  // port corresponding to your Arduino board (as it appears in the list
  // printed by the line above).
  arduino = new Arduino(this, Arduino.list()[2], 57600);

  // Configure digital pin 4 to control servo motors.
  arduino.pinMode(4, Arduino.SERVO);
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
  //lerping is also useful when sending to physical outputs to slow data down and allow the physical movement to catch up.
  lerpFdata = lerp(lerpFdata, fData, lerpEase);
  fill(255, lerpFdata);
  noStroke();
  rect(5, 5, width - 10, height - 130);

  //lets print to console to see what values we are about to send
  println(lerpFdata);

  //we can put these values in a new range on the Processing side or the ARduino side.
  //lets do it on the Processing side...
  float newData= map(lerpFdata, 0, 255, 0, 180);
  //println(newData);
  
  //if this is too fast for the servo.
  //either slow down timerDelay
  //or only send every x frames
  
  //send to a servo (this relies on Firmata been loaded onto the Arduino board). 
  //we must constrain the values sent to the servo so it does not exceed these values 
  arduino.servoWrite(4, constrain(int(newData), 0, 180));
}