void setup() {
  // put your setup code here, to run once:
  pinMode(9, OUTPUT); //use pins with ~ to send analog messages out.
}

void loop() {
  // put your main code here, to run repeatedly:


  //we can gradually control intensity by counting up or down (using a for loop)
  //this counts UP
  for (int i = 0; i <= 255; i++) {

    analogWrite(9, i); //the intensity is whatever 'i' is.
    delay(30);//wait a 30 milliseconds every time we go through the for loop.
  }

//this counts DOWN
//we can also change 'i' to a name that makes sense to us. In thi case intensity
  for (int intensity = 255; intensity >= 0; intensity--) {

    analogWrite(9, intensity); //the intensity is whatever 'i' is.
    delay(30);//wait a 30 milliseconds every time we go through the for loop.
  }
  
}
