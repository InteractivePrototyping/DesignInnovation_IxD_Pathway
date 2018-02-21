void setup() {
  // put your setup code here, to run once:
pinMode(9,OUTPUT);//use pins with ~ to send analog messages out. 
}

void loop() {
  // put your main code here, to run repeatedly:

analogWrite(9,0);//with analog messages we can be more specific about the intensity of 'ON'/'OFF' 0=OFF
delay(1000);//wait 1 second (1000 milliseconds)
analogWrite(9,50);//increment the intensity every 1 second
delay(1000);
analogWrite(9,100);//increment the intensity every 1 second
delay(1000);
analogWrite(9,255);//255 =ON if this was an LED it would be the brightest it could go. If this was  motor it may be as fast as it could go
delay(1000);
}
