#include <Servo.h> //include the servo library

Servo myservo;  // create servo object to control a servo
// twelve servo objects can be created on most boards



void setup() {
  // put your setup code here, to run once:
  myservo.attach(9);  // attaches the servo on pin 9 to the servo object
}

void loop() {
  // put your main code here, to run repeatedly:
  myservo.write(0); //move to different positions
  delay(1000); //every 1 second 
  myservo.write(45);
  delay(1000);
  myservo.write(90);
  delay(1000);
  myservo.write(180);
  delay(1000);
}
