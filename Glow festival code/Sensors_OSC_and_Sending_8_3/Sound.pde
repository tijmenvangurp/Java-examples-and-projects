void soundXYsmooth(String name, float wave) {

  myMessage.setAddrPattern(name);
 

  myMessage.add( new Object[] { 
    new Float(xRotationSmooth), new Float(yRotationSmooth) , new Float (abs(accelerationSound())), new Float (wave)
  }
  );

  // println("Xsound = "+xSound);
  //println("Ysound = "+ySound);
  sendSound(myMessage);

  myMessage.clear();
}

void sendWaveToSound(String name, float wave) {
  myMessage.setAddrPattern(name);
  myMessage.add(wave);
  //sendSound(myMessage);
  myMessage.clear();
}


float accelerationSound(){
float storeXaccelerationMaxSound = 0;
float storeXaccelerationMinSound = 0;

float storeYaccelerationMaxSound = 0;
float storeYaccelerationMinSound = 0;

float XaccelerationSlowedDownSound =0;
float YaccelerationSlowedDownSound =0;

int accelerationFrictionFactor = 30;

 // change X Acceleration ----------------------------------------------------------------------------------------------
  if (xAcceleration > storeXaccelerationMaxSound ) {
    storeXaccelerationMaxSound = xAcceleration;
  } 
  else {
    // println("acceleration x "+(xAcceleration - storeXaccelerationMaxSound));
    if (storeXaccelerationMaxSound > 0 ) {    
      storeXaccelerationMaxSound = storeXaccelerationMaxSound - (storeXaccelerationMaxSound/accelerationFrictionFactor);
    }
  }
  if (xAcceleration < storeXaccelerationMinSound ) {
    storeXaccelerationMinSound = xAcceleration;
  }
  else {
    if (storeXaccelerationMinSound < 0) {
      storeXaccelerationMinSound = storeXaccelerationMinSound + ((abs(storeXaccelerationMinSound/accelerationFrictionFactor)));
    }
  }
  // change Y Acceleration ----------------------------------------------------------------------------------------------
  if (yAcceleration > storeYaccelerationMaxSound ) {
    storeYaccelerationMaxSound = yAcceleration;
  } 
  else {
    // println("acceleration x "+(xAcceleration - storeXaccelerationMaxSound));
    if (storeYaccelerationMaxSound > 0 ) {    
      storeYaccelerationMaxSound = storeYaccelerationMaxSound - (storeYaccelerationMaxSound/accelerationFrictionFactor);
    }
  }
  if (yAcceleration < storeYaccelerationMinSound ) {
    storeYaccelerationMinSound = yAcceleration;
  }
  else {
    if (storeYaccelerationMinSound < 0) {
      storeYaccelerationMinSound = storeYaccelerationMinSound + ((abs(storeYaccelerationMinSound/accelerationFrictionFactor)));
    }
  }

  XaccelerationSlowedDownSound = (storeXaccelerationMinSound + storeXaccelerationMaxSound);
  YaccelerationSlowedDownSound = (storeYaccelerationMinSound + storeYaccelerationMaxSound);
  
  float accelerationCombined = (XaccelerationSlowedDownSound+YaccelerationSlowedDownSound);
return accelerationCombined;

}
