//Requires Standard Firmata to be loaded onto the Arduino board

//we require these libraries
import processing.serial.*;

import cc.arduino.*;

Arduino arduino;
PFont f;


void setup() {
  size(470, 280);
  f = createFont("Arial", 14, true);
  // Prints out the available serial ports.
  printArray(Arduino.list());

  // Modify this line, by changing the "0" to the index of the serial
  // port corresponding to your Arduino board (as it appears in the list
  // printed by the line above).
  arduino = new Arduino(this, Arduino.list()[2], 57600);


  // Initialise the Arduino digital pins as inputs.
  for (int i = 0; i <= 13; i++)
    arduino.pinMode(i, Arduino.INPUT);
}

void draw() {

  //arbitary colours for the background and circle stroke
  background(0);
  noStroke();


  // Draw a circle whose size corresponds to the value of an analog input.
  //lets control the colour fill with our sensor value
  int sensor=arduino.analogRead(0);
  float newSensor=map(sensor, 0, 1023, 0, 255);
  fill(newSensor);

  //lets draw the values from one sensor in the middle of the screen
  //ellipse(width/2, height/2, arduino.analogRead(0) / 16, arduino.analogRead(0) / 16);



  //here we scale the original sensor value to a range that is useful to us.
  float w = map(sensor, 2, 1023, 2, width);
  fill(255, 0, 0);
  rect(0, 0, w, height);
  
  //position the text
  pushMatrix();
  textFont(f);
  textSize(72);  
  textAlign(CENTER, BOTTOM);
  translate(0, height/2);
  rotate(HALF_PI);


  //colour settings
  fill(255, 255, 255);
  noStroke();
  //this is your sensor data being applied to the graphic.
  //'sensor' is the value. This can be used for many things. For example to trigger events
  text(nfs(int(sensor), 3), 0, 0);
  popMatrix();
  
  //print to console (black box at bottom of processing sketch)
  println(sensor);
}