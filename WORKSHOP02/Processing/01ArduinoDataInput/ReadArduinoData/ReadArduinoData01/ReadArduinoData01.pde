//Requires Standard Firmata to be loaded onto the Arduino board

//we require these libraries
import processing.serial.*;

import cc.arduino.*;

Arduino arduino;

void setup() {
  size(470, 280);

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
  background(4, 79, 111);
  stroke(84, 145, 158);
  

  // Draw a circle whose size corresponds to the value of an analog input.
  noFill();
  for (int i = 0; i <= 5; i++) {
    ellipse(280 + i * 30, 240, arduino.analogRead(i) / 16, arduino.analogRead(i) / 16);
  }
}