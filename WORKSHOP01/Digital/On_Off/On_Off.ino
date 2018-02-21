

void setup() {
  // put your setup code here, to run once:
  pinMode(13, OUTPUT);  //pin 13 is the where the output message is sent
}

void loop() {
  // put your main code here, to run repeatedly:

  digitalWrite(13, HIGH);  //set pin 13 to be ON
  delay(1000);//wait for 1 second (1000 milliseconds)
  digitalWrite(13, LOW); //set pin 13 to be OFF
  delay(1000); //wait for 1 second (1000 milliseconds)
}
