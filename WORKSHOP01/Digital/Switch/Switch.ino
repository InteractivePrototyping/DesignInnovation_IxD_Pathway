// constants won't change. They're used here to
// set pin numbers:
const int buttonPin = 2;     // the number of the pushbutton pin
const int ledPin =  13;      // the number of the LED pin

// variables will change:
int buttonState = 0;         // variable for reading the pushbutton status



void setup() {
  // put your setup code here, to run once:
  pinMode(ledPin, OUTPUT);  //LED pin is the where the output message is sent
  pinMode(buttonPin, INPUT_PULLUP); // initialize the pushbutton pin as an input: (INPUT_PULLUP means button thinks it is ON unless pressed so logic is inverted but physical circuit is simpler)
}

void loop() {
  // put your main code here, to run repeatedly:

  // read the state of the pushbutton value:
  buttonState = digitalRead(buttonPin);

  // check if the pushbutton is pressed.
  // if it is, the buttonState is HIGH:
  if (buttonState == LOW) {
    digitalWrite(ledPin, HIGH);  //set pin 13 to be ON
  }
  else {

    digitalWrite(ledPin, LOW); //set pin 13 to be OFF

  }
}
