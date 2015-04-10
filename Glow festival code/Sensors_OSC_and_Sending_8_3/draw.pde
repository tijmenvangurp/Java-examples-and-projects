boolean printOnce = true;
float storeXaccelerationMax = 0;
float storeXaccelerationMin = 0;

float storeYaccelerationMax = 0;
float storeYaccelerationMin = 0;
float XaccelerationSlowedDown =0;
float YaccelerationSlowedDown =0;

void draw() {
  storeSmoothXYGlobal();
  background(0);
  float xAccelerationDisplay = xAcceleration;
  float yAccelerationDisplay = yAcceleration;

//oude accelleratie
  ellipse(((xAccelerationDisplay*100)*100)+width/2, ((yAccelerationDisplay*100)*100)+height/2, 30, 30);
  // ellipse(((xAccelerationWithoutSmoothing*100)*100)+width/4, ((yAccelerationWithoutSmoothing*100)*100)+height/4, 30, 30);

  int accelerationFrictionFactor = 200;
  // change X Acceleration ----------------------------------------------------------------------------------------------
  if (xAcceleration > storeXaccelerationMax ) {
    storeXaccelerationMax = xAcceleration;
  } 
  else {
    // println("acceleration x "+(xAcceleration - storeXaccelerationMax));
    if (storeXaccelerationMax > 0 ) {    
      storeXaccelerationMax = storeXaccelerationMax - (storeXaccelerationMax/accelerationFrictionFactor);
    }
  }
  if (xAcceleration < storeXaccelerationMin ) {
    storeXaccelerationMin = xAcceleration;
  }
  else {
    if (storeXaccelerationMin < 0) {
      storeXaccelerationMin = storeXaccelerationMin + ((abs(storeXaccelerationMin/accelerationFrictionFactor)));
    }
  }
  // change Y Acceleration ----------------------------------------------------------------------------------------------
  if (yAcceleration > storeYaccelerationMax ) {
    storeYaccelerationMax = yAcceleration;
  } 
  else {
    // println("acceleration x "+(xAcceleration - storeXaccelerationMax));
    if (storeYaccelerationMax > 0 ) {    
      storeYaccelerationMax = storeYaccelerationMax - (storeYaccelerationMax/accelerationFrictionFactor);
    }
  }
  if (yAcceleration < storeYaccelerationMin ) {
    storeYaccelerationMin = yAcceleration;
  }
  else {
    if (storeYaccelerationMin < 0) {
      storeYaccelerationMin = storeYaccelerationMin + ((abs(storeYaccelerationMin/accelerationFrictionFactor)));
    }
  }

  XaccelerationSlowedDown = (storeXaccelerationMin + storeXaccelerationMax);
  YaccelerationSlowedDown = (storeYaccelerationMin + storeYaccelerationMax);



  //ellipse(((storeXaccelerationMax*100)*100)+width/4, ((yAccelerationWithoutSmoothing*100)*100)+height/4, 30, 30);
  fill(0, 0, 255);


  // ellipse(((storeXaccelerationMin*100)*100)+width/4, ((yAccelerationWithoutSmoothing*100)*100)+height/4, 30, 30);
  
  // Alleen de acceleratie 
  //ellipse((((XaccelerationSlowedDown)*100)*100)+width/2, ((YaccelerationSlowedDown*100)*100)+height/2, 30, 30);

  fill(0, 255, 255);
  
  // uiteindelijke acceleratie PLus rotatie
  
  ellipse((((XaccelerationSlowedDown)*20000)+ xRotationSmooth*10)+width/2, (((YaccelerationSlowedDown)*20000)+yRotationSmooth*10)+height/2, 30, 30);

  //println("storeXaccelerationMin x "+storeXaccelerationMin);
  //println("storeXaccelerationMAX x "+storeXaccelerationMax);

  //ellipse(400, 400, storeXaccelerationMin*100000, storeXaccelerationMin*100000);
  //storeXacceleration = storeXacceleration - frictionOnAcceleration;
  // xyCompare.xAcceleration();

  stroke(255);
  fill(255);
  //  println ("XAcceleration = "+xAcceleration);
  // println ("YAcceleration = "+yAcceleration*100000);


  if (printOnce) {
    if (round((yAcceleration*100000)) == 0) {
      //println("Timestamp: hour ="+hour()+" Minuts: "+minute()+" Seconds:"+second());
      printOnce = false;
    }
  }
  else if ((yAcceleration*100000) >100) {
    printOnce = true;
  }
  // ellipse(width/2, height/2, 40+xAcceleration*10, 40+yAcceleration*10);



  

  // Show framerate if needed
  //println(frameRate);

  // show sensor values
  drawlines();
  updateWave();

  stroke(255);
  strokeWeight(1);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);
  //println("wigle ="+(xyWigle.xpos(xRotation)));
  sendToMacminis();
}

void sendToMacminis() {

  // Sends Raw X-Y values of Iphone
  sendSmoothXY("/smoothXY");
  //sendSmoothXYtoIpad();
}

void drawlines() {

  //background(0);
  stroke(255);
  strokeWeight(5);
  // line(0, (xRotation*60)+200, width, (xRotation*60)+200);
  stroke(255, 0, 255);
  line(0, ( xRotationSmooth*100)+200, width, ( xRotationSmooth*100)+200);
  stroke(255);
  // line(( (yRotation)*60)+200, 0, ( (yRotation)*60)+200, height);
  stroke(0, 0, 255);
  line(( yRotationSmooth*100)+200, 0, ( yRotationSmooth*100)+200, height);

  noStroke();
  //println((xyWigle.xpos(xRotation)));
  //
}

