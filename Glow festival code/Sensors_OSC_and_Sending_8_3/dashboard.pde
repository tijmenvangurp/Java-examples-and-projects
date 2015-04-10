float platformSensitivity = 1;
float plafformSensitivitySound = 1;
float plafformSensitivityAcceleration = 1;
int plafformSmoothingAcceleration = 1000000;
int ammountOfSmoothing = 10;
int ammountOfSmoothingSound = 10;

void getDashboardData(OscMessage theOscMessage) {

  for (int i = 0; i < dashboard_function_names.size(); i++) {

    if (theOscMessage.checkAddrPattern((String)dashboard_function_names.get(i))==true) {
      dashboard_function_values.remove(i);
      dashboard_function_values.add(i, (Integer) round (theOscMessage.get(0).floatValue()));
      println("window Midle Rightface nr "+i+" = "+(Integer)dashboard_function_values.get(i));
      dachboardFunctionSelected = i;
      unToggleDashboardFunction(i);
      getSliderDataDashboard(i);
    }
  }

  //------------------------------------------------------------------------------------------

  if (theOscMessage.checkAddrPattern("/dashboard/standardoffset")==true) {
    //println("xslider = "+windowSelectedMidleRightSide);
    standardoffset.remove(dachboardFunctionSelected);
    standardoffset.add(dachboardFunctionSelected, theOscMessage.get(0).floatValue());
    feedbackDashboardSliders("/dashboard/standartoffset/label", theOscMessage.get(0).floatValue());
  }
  if (theOscMessage.checkAddrPattern("/dashboard/offsetmultiplier")==true) {
    offsetmultiplier.remove(dachboardFunctionSelected);
    offsetmultiplier.add(dachboardFunctionSelected, theOscMessage.get(0).floatValue());
    feedbackDashboardSliders("/dashboard/offsetmultiplier/label", theOscMessage.get(0).floatValue());
  }
  if (theOscMessage.checkAddrPattern("/dashboard/minmaxoffset")==true) {
    minmaxoffset.remove(dachboardFunctionSelected);
    minmaxoffset.add(dachboardFunctionSelected, theOscMessage.get(0).floatValue());
    feedbackDashboardSliders("/dashboard/minmaxoffset/label", theOscMessage.get(0).floatValue());
  }

  if (theOscMessage.checkAddrPattern("/dashboard/standartamplitude")==true) {
    standartamplitude.remove(dachboardFunctionSelected);
    standartamplitude.add(dachboardFunctionSelected, theOscMessage.get(0).floatValue());
    feedbackDashboardSliders("/dashboard/standartamplitude/label", theOscMessage.get(0).floatValue());
  }
  if (theOscMessage.checkAddrPattern("/dashboard/amplitudeacceleration")==true) {
    amplitudeacceleration.remove(dachboardFunctionSelected);
    amplitudeacceleration.add(dachboardFunctionSelected, theOscMessage.get(0).floatValue());
    feedbackDashboardSliders("/dashboard/amplitudeacceleration/label", theOscMessage.get(0).floatValue());
  }
  if (theOscMessage.checkAddrPattern("/dashboard/maximumamplitude")==true) {
    maximumamplitude.remove(dachboardFunctionSelected);
    maximumamplitude.add(dachboardFunctionSelected, theOscMessage.get(0).floatValue());
    feedbackDashboardSliders("/dashboard/maximumamplitude/label", theOscMessage.get(0).floatValue());
  }
  if (theOscMessage.checkAddrPattern("/dashboard/frequency")==true) {
    frequency = theOscMessage.get(0).floatValue();
    feedbackDashboardSliders("/dashboard/frequency/label", theOscMessage.get(0).floatValue());
  }
  if (theOscMessage.checkAddrPattern("/dashboard/platformsensitivity")==true) {
    platformSensitivity = theOscMessage.get(0).floatValue();
     feedbackDashboardSliders("/dashboard/platformsensitivity/label", theOscMessage.get(0).floatValue());
  }
   if (theOscMessage.checkAddrPattern("/dashboard/smoothing")==true) {
    ammountOfSmoothing = (Integer)round (theOscMessage.get(0).floatValue());
    feedbackDashboardSliders("/dashboard/smoothing/label", theOscMessage.get(0).floatValue());
  }
  if (theOscMessage.checkAddrPattern("/dashboard/sensitivitysound")==true) {
    plafformSensitivitySound =(theOscMessage.get(0).floatValue());
    feedbackDashboardSliders("/dashboard/sensitivitysound/label", theOscMessage.get(0).floatValue());
  }
  
   if (theOscMessage.checkAddrPattern("/dashboard/smoothingsound")==true) {
    ammountOfSmoothingSound =(Integer)round(theOscMessage.get(0).floatValue());
    feedbackDashboardSliders("/dashboard/smoothingsound/label", theOscMessage.get(0).floatValue());
  }
   if (theOscMessage.checkAddrPattern("/dashboard/accelerationsensitivity")==true) {
    plafformSensitivityAcceleration = theOscMessage.get(0).floatValue();
    feedbackDashboardSliders("/dashboard/accelerationsensitivity/label", theOscMessage.get(0).floatValue());
  }
   if (theOscMessage.checkAddrPattern("/dashboard/accelerationsmoothing")==true) {
    plafformSmoothingAcceleration = (Integer)round(theOscMessage.get(0).floatValue());
    feedbackDashboardSliders("/dashboard/accelerationsmoothing/label", theOscMessage.get(0).floatValue());
  }
  

  //------------------------------------------------------------------------------------------
  if (theOscMessage.checkAddrPattern("/dashboard/save")==true) {
    if (saveFaces.isFinished()) {
      saveAll_dashboardSliders();
      // timer to prevent that document is saved 10 times
      println("Saved DashBoard!");
    }
    saveFaces.start();
  }
}



void unToggleDashboardFunction(int indexToIgnore) {

  for (int i = 0; i < dashboard_function_names.size();i++) {
    if (i != indexToIgnore) {
      // println((String)namesWindowsMidleLeftFace.get(i));
      myMessage.setAddrPattern((String)dashboard_function_names.get(i));
      myMessage.add(0);
      oscP5.send(myMessage, remoteLocation_Ipad_1);
      myMessage.clear();
    }
  }
  // myMessage.setAddrPattern((String)namesWindowsMidleLeftFace.get(indexToIgnore));
  //  println("window to toggle = "+(String)namesWindowsMidleLeftFace.get(indexToIgnore));
  // myMessage.add(1);
  //  oscP5.send(myMessage, remoteLocation_Ipad_1);
  // myMessage.clear();
}


void getSliderDataDashboard(int index) {

  float standardoffsetSlider = (Float)standardoffset.get(index);
  float offsetmultiplierSlider = (Float)offsetmultiplier.get((index));
  float minmaxoffsetSlider = (Float)minmaxoffset.get(index);
  
  float standartAmplitudeSlider = (Float)standartamplitude.get((index));
  float amplitudeAccelerationSlider = (Float)amplitudeacceleration.get((index));
  float maximumAmplitudeSlider = (Float)maximumamplitude.get((index));
  

  myMessage.setAddrPattern("/dashboard/standardoffset");
  myMessage.add(standardoffsetSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
  myMessage.setAddrPattern("/dashboard/offsetmultiplier");
  myMessage.add(offsetmultiplierSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
  myMessage.setAddrPattern("/dashboard/minmaxoffset");
  myMessage.add(minmaxoffsetSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
  
  myMessage.setAddrPattern("/dashboard/standartamplitude");
  myMessage.add(standartAmplitudeSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
  myMessage.setAddrPattern("/dashboard/amplitudeacceleration");
  myMessage.add(amplitudeAccelerationSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
  myMessage.setAddrPattern("/dashboard/maximumamplitude");
  myMessage.add(maximumAmplitudeSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
}
void loadAllSlidersDashboard() {

  dashboard_data.load(sketchPath("save/mapping/dashboard_data.txt"));
  standardoffset.clear(); 
  offsetmultiplier.clear(); 
  minmaxoffset.clear();
  
  standartamplitude.clear(); 
  amplitudeacceleration.clear(); 
  maximumamplitude.clear(); 

  for (int i = 0; i <(dashboard_function_names.size()); i++) {
    standardoffset.add(i, dashboard_data.readFloatIndex(i*6));
    offsetmultiplier.add(i, dashboard_data.readFloatIndex((i*6)+1));
    minmaxoffset.add(i, dashboard_data.readFloatIndex((i*6)+2));
    
    standartamplitude.add(i, dashboard_data.readFloatIndex((i*6)+3));
    amplitudeacceleration.add(i, dashboard_data.readFloatIndex((i*6)+4));
    maximumamplitude.add(i, dashboard_data.readFloatIndex((i*6)+5));
  }
}
void saveAll_dashboardSliders() {

  dashboard_data.beginSave();
  for (int i = 0; i < dashboard_function_names.size(); i++) {
    dashboard_data.add ((Float)standardoffset.get(i));
    dashboard_data.add ((Float)offsetmultiplier.get(i));
    dashboard_data.add ((Float)minmaxoffset.get(i));
    
    dashboard_data.add ((Float)standartamplitude.get(i));
    dashboard_data.add ((Float)amplitudeacceleration.get(i));
    dashboard_data.add ((Float)maximumamplitude.get(i));
  }
  dashboard_data.endSave(sketchPath("save/mapping/dashboard_data.txt"));
}

void feedbackDashboardSliders(String name, float value){

myMessage.setAddrPattern(name);
  myMessage.add(value);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
}

