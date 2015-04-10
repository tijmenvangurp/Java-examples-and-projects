
float scaleX = 1;
float scaleY = 1;



void sendSmoothXY(String name) {
  myMessage.setAddrPattern(name);

  myMessage.add( new Object[] { 
    new Float(xRotationSmooth), new Float(yRotationSmooth) , new Float(range(abs(xyAcceleration.xAcceleration()),0,1)) , new Float(range(abs(xyAcceleration.yAcceleration()),0,1))
  }
  );
  sendToMacMinis(myMessage);

  myMessage.clear();
  //println(xRotation);
}

void sendToggles() {

  myMessage.setAddrPattern("/toggles");

  myMessage.add( new Object[] { 
    new Float(togglefaces)
  }
  );

  sendToMacMinis(myMessage);
  myMessage.clear();
}
void sendSmoothXYtoIpad() {

  myMessage.setAddrPattern("/6/xy1");

  myMessage.add( new Object[] { 
    new Float( xRotationSmooth), new Float(yRotationSmooth)
  }
  );
  //  myMessage.add(xRotationSmooth);
  myBundle.add(myMessage);
  myMessage.clear();
  myMessage.setAddrPattern("/6/label163");
  myMessage.add(round(yRotationSmooth*90));
  myBundle.add(myMessage);
  myMessage.clear();
  oscP5.send(myBundle, remoteLocation_Ipad_1);
  //println("ipad message = "+myMessage);
  myMessage.clear();
  myBundle.clear();
}

