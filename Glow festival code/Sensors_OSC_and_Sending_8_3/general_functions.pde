float range (float input, float minValue, float maxValue) {

  if (input > maxValue) {
    input = maxValue;
  }
  if (input < minValue) {
    input = minValue;
  }

  return input;
}

 
/**
Super global variables 
*/
float xRotationSmooth;
float yRotationSmooth;
float xRotationSmoothSound;
float yRotationSmoothSound;
float xAcceleration;
float xAccelerationWithoutSmoothing;
float yAccelerationWithoutSmoothing;

float yAcceleration;
float xAccelerationSound;
float yAccelerationSound;
void  storeSmoothXYGlobal() {
 // println("platformsensitivity = "+platformSensitivity);
  xRotationSmooth  = (xSmoothing.smoothedValues(xRotation, ammountOfSmoothing));
  yRotationSmooth  = (ySmoothing.smoothedValues(yRotation, ammountOfSmoothing));
  
//  xRotationSmoothSound =(xSmoothingSound.smoothedValuesSound(xRotation))*plafformSensitivitySound;
 // yRotationSmoothSound =(ySmoothingSound.smoothedValuesSound(yRotation))*plafformSensitivitySound;
  
  xRotationSmoothSound =(xSmoothingSound.smoothedValuesSound(xRotation));
  yRotationSmoothSound =(ySmoothingSound.smoothedValuesSound(yRotation));
  
  xAccelerationWithoutSmoothing = xyAcceleration.xAcceleration()*plafformSensitivityAcceleration;
  yAccelerationWithoutSmoothing = xyAcceleration.yAcceleration()*plafformSensitivityAcceleration;
  xAcceleration = xAccelerationSmoothing.smoothedValues(((xyAcceleration.xAcceleration())*plafformSensitivityAcceleration),plafformSmoothingAcceleration);
  yAcceleration = yAccelerationSmoothing.smoothedValues(((xyAcceleration.yAcceleration())*plafformSensitivityAcceleration),plafformSmoothingAcceleration);
  
  
 // println("xAcceleration ="+xAcceleration);
}


