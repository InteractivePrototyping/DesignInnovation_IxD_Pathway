/*
  AnalogReadSerial
  Reads an analog input on pin 0, prints the result to the serial monitor.
  Graphical representation is available using serial plotter (Tools > Serial Plotter menu)
  Attach the center pin of a potentiometer to pin A0, and the outside pins to +5V and ground.

  This example code is in the public domain.
*/

// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);

  pinMode(9,OUTPUT);//this is our output pin
}

// the loop routine runs over and over again forever:
void loop() {
  // read the input on analog pin 0:
  int sensorValue = analogRead(A0);
  // print out the value you read:
  Serial.println(sensorValue);
  delay(1);        // delay in between reads for stability

//take the input from the sensor and use it to control the output
analogWrite(9,sensorValue);

//if the above line gives a glitchy output then use the mapping function to put the sensorValue numbers in an appropriate range 
//delete the /* */ to make it active 
/*
float newSensorValue= map(sensorValue,0,1023,0,200);
//comment out the analogWrite 3 lines up and use this instead.
analogWrite(9,newSensorValue);
*/
}
