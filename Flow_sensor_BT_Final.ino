double totalVolume = 0;
bool lidPos;
volatile double waterFlow = 0;
int interval = 1000;       //interval between each reading in milliseconds
int flowSensorPin = 3;    //flow sensor input

#include <SoftwareSerial.h>
SoftwareSerial BTSerial(10,11); // RX | TX
String choice;

void pulse()
{
  waterFlow += (1.0 / 5880.0)*1000.0; //measure water flow
}

void setup()
{

  pinMode(flowSensorPin,INPUT);
  Serial.begin(9600);
  BTSerial.begin(38400); //baud rate of HC-05
  attachInterrupt(digitalPinToInterrupt(flowSensorPin), pulse, RISING);
}



void loop()
{
  choice = String(waterFlow); // turns waterFlow from int to string
  BTSerial.print(choice); //send sensor data via BT
  BTSerial.println(" mL");
  delay(interval);
}
