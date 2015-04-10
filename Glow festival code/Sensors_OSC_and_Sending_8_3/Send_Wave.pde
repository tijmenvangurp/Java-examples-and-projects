void sendWaveFeedbackIpad(float waveX, float waveY ) {
  //println("wave to ipade = "+waveY+" , "+waveX);
  String name = "/Dashboard/xy1"; 
  myMessage.setAddrPattern(name);
  myMessage.add(new Object[] { 
    new Float(waveY), new Float(waveX)
  }
  );
  
  myBundle.add(myMessage);
  myMessage.clear();
  name = "/dashboard/platformxy"; 
  myMessage.setAddrPattern(name);
 // println("xRotationSmooth = "+xRotationSmooth);
  myMessage.add(new Object[] { 
        new Float(xRotationSmooth), new Float(yRotationSmooth)
  }
  );
  
  myBundle.add(myMessage);
  myMessage.clear();
  name = "/dashboard/platformx/label"; 
  myMessage.setAddrPattern(name);
  myMessage.add(xRotationSmooth);
  myBundle.add(myMessage);
   myMessage.clear();
  name = "/dashboard/platformy/label"; 
  myMessage.setAddrPattern(name);
  myMessage.add(yRotationSmooth);
  myBundle.add(myMessage);
  oscP5.send(myBundle, remoteLocation_Ipad_1);
  myMessage.clear();
  myBundle.clear();
}

void sendWaveToQC(String name, float wave ){
  
  myMessage.setAddrPattern(name);
  myMessage.add(wave);
 // println("wave name = "+ name+" value = "+ wave+" message = "+ myMessage);
  sendToMacMinis(myMessage);
  myMessage.clear();
}
