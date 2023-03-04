
#include <Servo.h>. 

//  pwm
const int servoPin=8;
const int trigPin = 9;
const int echoPin = 10;


Servo myServo; // obiect servo
int angle=0;

int distance;
long duration;
unsigned long timeout=9000;

void setup() {
  //senzor ultrasonic
  pinMode(trigPin, OUTPUT); 
  pinMode(echoPin, INPUT); 
  
  //servo
  myServo.attach(servoPin);

  //port serial 
  Serial.begin(9600);
}

void loop() {
  
  for(angle=0;angle<=180;angle++){  
  myServo.write(angle);
  delay(30);

  distance=distanceCm();
       
  //transmitere port serial
  Serial.print(angle); 
  Serial.print(",");
  Serial.print(distance); 
  Serial.print("|"); 
  }
  

  for(angle=180;angle>0;angle--){  
  myServo.write(angle);
  delay(30);

  distance=distanceCm();

  //transmitere port serial
  Serial.print(angle);
  Serial.print(",");
  Serial.print(distance);
  Serial.print("|");
  }

}



int distanceCm(){   
  
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  //calcul distanta
  duration = pulseIn(echoPin, HIGH,timeout); 
  int  distance= duration*0.034/2;
   
  return distance;
}