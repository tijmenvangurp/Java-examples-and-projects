float theta = 0.0;  // Start angle at 0
float period = 1000.0;  // How many pixels before the wave repeats
float dx;  // Value for incrementing X, a function of period and xspacing

float yvalue;
float xvalue;  

float amplitudeX = 100.0;  // Height of wave
float offsetX = 100;

float amplitudeY = 100.0;  // Height of wave
float offsetY = 100;

float frequency = 0.05;
boolean initiate = false;

float amplitudeWave = 0;
float offsetWave =0;
int indexWave = 0;

void updateWave() {
  calcWave();
}
void calcWave() {

  if (!initiate) {
    dx = (TWO_PI / period);
    initiate = true;
  }
  // Increment theta (try different values for 'angular velocity' here
  theta += frequency;

  // For every x value, calculate a y value with sine function
  float x = theta;


  //scaleGrid------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  indexWave = 0;

  amplitudeWave = ((xAcceleration *(Float) amplitudeacceleration.get(indexWave))+(Float) standartamplitude.get(indexWave));
  if (amplitudeWave > (Float)maximumamplitude.get(indexWave)) {
    amplitudeWave = (Float)maximumamplitude.get(indexWave);
  } 

  offsetWave = ((Float)standardoffset.get(indexWave)+(xRotationSmooth*(Float)offsetmultiplier.get(indexWave)));
  if (offsetWave > ((Float)standardoffset.get(indexWave)+(Float) minmaxoffset.get(indexWave))) {
    offsetWave = ((Float)standardoffset.get(indexWave)+(Float) minmaxoffset.get(indexWave));
  }
  if (offsetWave < ((Float)standardoffset.get(indexWave) - (Float) minmaxoffset.get(indexWave))) {
    offsetWave = ((Float)standardoffset.get(indexWave)-(Float) minmaxoffset.get(indexWave));
  }
  float scaleGrideX = sin(x)*amplitudeWave + offsetWave;
  sendWaveToQC("/wave/scalegrid/x", scaleGrideX); 
  //scaleGrid------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  indexWave = 1;

  amplitudeWave = ((xAcceleration *(Float) amplitudeacceleration.get(indexWave))+(Float) standartamplitude.get(indexWave));
  if (amplitudeWave > (Float)maximumamplitude.get(indexWave)) {
    amplitudeWave = (Float)maximumamplitude.get(indexWave);
  } 

  offsetWave = ((Float)standardoffset.get(indexWave)+(xRotationSmooth*(Float)offsetmultiplier.get(indexWave)));
  if (offsetWave > ((Float)standardoffset.get(indexWave)+(Float) minmaxoffset.get(indexWave))) {
    offsetWave = ((Float)standardoffset.get(indexWave)+(Float) minmaxoffset.get(indexWave));
  }
  if (offsetWave < ((Float)standardoffset.get(indexWave) - (Float) minmaxoffset.get(indexWave))) {
    offsetWave = ((Float)standardoffset.get(indexWave)-(Float) minmaxoffset.get(indexWave));
  }
  float bricks = sin(x)*amplitudeWave + offsetWave;

  sendWaveToQC("/wave/bricks/x", bricks); 

  //Light------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  indexWave = 2;

  amplitudeWave = ((xAcceleration *(Float) amplitudeacceleration.get(indexWave))+(Float) standartamplitude.get(indexWave));
  if (amplitudeWave > (Float)maximumamplitude.get(indexWave)) {
    amplitudeWave = (Float)maximumamplitude.get(indexWave);
  } 

  offsetWave = ((Float)standardoffset.get(indexWave)+(xRotationSmooth*(Float)offsetmultiplier.get(indexWave)));
  if (offsetWave > ((Float)standardoffset.get(indexWave)+(Float) minmaxoffset.get(indexWave))) {
    offsetWave = ((Float)standardoffset.get(indexWave)+(Float) minmaxoffset.get(indexWave));
  }
  if (offsetWave < ((Float)standardoffset.get(indexWave) - (Float) minmaxoffset.get(indexWave))) {
    offsetWave = ((Float)standardoffset.get(indexWave)-(Float) minmaxoffset.get(indexWave));
  }
  float lightX = sin(x)*amplitudeWave + offsetWave;
  sendWaveToQC("/wave/light/x", lightX);


  //Sound------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  indexWave = 3;

  amplitudeWave = ((xAcceleration *(Float) amplitudeacceleration.get(indexWave))+(Float) standartamplitude.get(indexWave));
  if (amplitudeWave > (Float)maximumamplitude.get(indexWave)) {
    amplitudeWave = (Float)maximumamplitude.get(indexWave);
  } 

  offsetWave = ((Float)standardoffset.get(indexWave)+(xRotationSmooth*(Float)offsetmultiplier.get(indexWave)));
  if (offsetWave > ((Float)standardoffset.get(indexWave)+(Float) minmaxoffset.get(indexWave))) {
    offsetWave = ((Float)standardoffset.get(indexWave)+(Float) minmaxoffset.get(indexWave));
  }
  if (offsetWave < ((Float)standardoffset.get(indexWave) - (Float) minmaxoffset.get(indexWave))) {
    offsetWave = ((Float)standardoffset.get(indexWave)-(Float) minmaxoffset.get(indexWave));
  }
  float soundX = sin(x)*amplitudeWave + offsetWave;
  sendWaveToSound("/wave/sound/x", soundX);  

  //Wave Feedback------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  if (dachboardSelected) {
    indexWave = dachboardFunctionSelected;

    amplitudeWave = ((xAcceleration *(Float) amplitudeacceleration.get(indexWave))+(Float) standartamplitude.get(indexWave));
    if (amplitudeWave > (Float)maximumamplitude.get(indexWave)) {
      amplitudeWave = (Float)maximumamplitude.get(indexWave);
    } 

    offsetWave = ((Float)standardoffset.get(indexWave)+(xRotationSmooth*(Float)offsetmultiplier.get(indexWave)));
    if (offsetWave > ((Float)standardoffset.get(indexWave)+(Float) minmaxoffset.get(indexWave))) {
      offsetWave = ((Float)standardoffset.get(indexWave)+(Float) minmaxoffset.get(indexWave));
    }
    if (offsetWave < ((Float)standardoffset.get(indexWave) - (Float) minmaxoffset.get(indexWave))) {
      offsetWave = ((Float)standardoffset.get(indexWave)-(Float) minmaxoffset.get(indexWave));
    }
    float waveFeedbackIpad = sin(x)*amplitudeWave + offsetWave; 
    sendWaveFeedbackIpad(waveFeedbackIpad, 0);
    //renderWave(waveFeedbackIpad);
  }

  amplitudeWave = ((XaccelerationSlowedDown *20000)+ 20);

  offsetWave = ((0)+(xRotationSmooth*(100)));

  float waveVoorbeeld = sin(x)*amplitudeWave + offsetWave; 
  
  amplitudeWave = ((YaccelerationSlowedDown *20000)+ 5);

  offsetWave = ((0)+(yRotationSmooth*(100)));

  float waveVoorbeeldY = sin(x)*amplitudeWave + offsetWave; 
  //renderWave(waveVoorbeeld,waveVoorbeeldY);
  
 // println(sin(x));
  
  soundXYsmooth("/SoundXY",sin(x));

  x+=dx;
  //sendWave("/ownFrequencyXY", xvalue, yvalue);
}

void renderWave(float wave, float waveY) {
  // println("yvalues"+yvalue);
fill(255,0,0);
  ellipse((wave)+width/2,(waveY)+ height/2, 60, 60);
}

