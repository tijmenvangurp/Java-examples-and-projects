import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
OscMessage myMessage;


void setup() {
  size(400, 400);
  frameRate(25);
  oscP5 = new OscP5(this, 7000);
  myMessage = new OscMessage("/");
  myRemoteLocation = new NetAddress("131.155.237.107", 7001);
}

void draw() {
  background(0);
  myMessage.setAddrPattern("/x");
  myMessage.add(mouseX);
  oscP5.send(myMessage, myRemoteLocation);
  myMessage.clear();
  
  myMessage.setAddrPattern("/y");
  myMessage.add(mouseY);
  oscP5.send(myMessage, myRemoteLocation);
  myMessage.clear();
  
  myMessage.setAddrPattern("/label/x");
  myMessage.add(mouseX);
  oscP5.send(myMessage, myRemoteLocation);
  myMessage.clear();
  
  myMessage.setAddrPattern("/label/y");
  myMessage.add(mouseY);
  oscP5.send(myMessage, myRemoteLocation);
  myMessage.clear();
  //println("mouseX = "+mouseX+" MouseY = "+mouseY);
}

void oscEvent(OscMessage theOscMessage) {

  println(" addrpattern: "+theOscMessage.addrPattern());

  if (theOscMessage.checkAddrPattern("/frequency")==true) {
    float frequency = theOscMessage.get(0).floatValue();
    println("frequency = "+frequency);
  }

  if (theOscMessage.checkAddrPattern("/1/multixy1/1")==true) {
    float xydingetje = theOscMessage.get(0).floatValue();
    float xydingetje2 = theOscMessage.get(1).floatValue();
    println("xydingetje = "+xydingetje+", "+xydingetje2);
  }
  if (theOscMessage.checkAddrPattern("/offsetX")==true) {
    float offset = theOscMessage.get(0).floatValue();
    println("offset = "+offset);
  }
  if (theOscMessage.checkAddrPattern("/amplitudeX")==true) {
    float amplitude = theOscMessage.get(0).floatValue();
    println("amplitude = "+amplitude);
  }
}

