
import processing.serial.*; 
import java.awt.event.KeyEvent; 
import java.io.IOException;

Serial myPort; 

String angle="";
String distance="";
String data="";


float pixsDistance;
int finalAngle; 
int finalDistance;
int separator;

PImage img;


void setup() {
 size (1920, 1080); //rezolutie
 smooth();
 myPort = new Serial(this,"COM10", 9600); // legatura cu portul serial
 myPort.bufferUntil('|'); // citire pereche distanta obiect
 img = loadImage("cruiser2.jpg");
}



//main
void draw() {
  fill(0,3); 
  rect(0, 0, width, height);
  image(img, 700, 820, img.width/2, img.height/2);
  drawPoint2();
  drawLine();
}


void drawPoint2() {
  resetMatrix();
  pushMatrix();
  translate(960,800); 
 
  strokeWeight(15);
  stroke(255,10,10); // rosu
  pixsDistance = finalDistance*10; //din cm in pixeli
  

  
  if(finalDistance<90 && finalAngle %2==0 ){
    // desenare puncte
  //point(-pixsDistance*cos(radians(180-(finalAngle-2))),pixsDistance*sin(radians(180+(finalAngle-2))));//dublura pt punct  
    point(-pixsDistance*cos(radians(180-finalAngle)),pixsDistance*sin(radians(180+finalAngle)));
  //point(-pixsDistance*cos(radians(180-(finalAngle+2))),pixsDistance*sin(radians(180+(finalAngle+2))));//dublura pt punct
  }
  popMatrix();
}


void drawLine() {
  pushMatrix();
  strokeWeight(2);
  stroke(30,250,60);
  translate(960,800); 
  int pixMaxDistance = 900; 
  line(0,0,-pixMaxDistance*cos(-radians(180-finalAngle)),pixMaxDistance*sin(-radians(180-finalAngle))); 
  popMatrix();
}


//preluare date din portul serial (unghi+distanta)
void serialEvent (Serial myPort) { 
  
  
  data = myPort.readStringUntil('|');
  data = data.substring(0,data.length()-1);
  
  //separare unghi si  distanta
  separator = data.indexOf(","); 
  angle= data.substring(0, separator);   
  distance= data.substring(separator+1, data.length());
  
  //cu astea lucrez
  finalAngle = int(angle);
  finalDistance = int(distance);
}
