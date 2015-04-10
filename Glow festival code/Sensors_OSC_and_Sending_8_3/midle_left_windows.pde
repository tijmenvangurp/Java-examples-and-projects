void getWindowsMidleLeftFace(OscMessage theOscMessage) {

  for (int i = 0; i < namesWindowsMidleLeftFace.size(); i++) {

    if (theOscMessage.checkAddrPattern((String)namesWindowsMidleLeftFace.get(i))==true) {
      valuesWindowsMidleLeftFace.remove(i);
      valuesWindowsMidleLeftFace.add(i, (Integer) round (theOscMessage.get(0).floatValue()));
      println("window Midle leftface nr "+i+" = "+(Integer)valuesWindowsMidleLeftFace.get(i));
      windowSelectedMidleLeftSide = i;
      unToggleMidleLeftFace(i);
      getSliderDataMidleLeftFace(i);
    }
  }

  //------------------------------------------------------------------------------------------

  if (theOscMessage.checkAddrPattern("/middleface/left/x")==true) {
    //println("xslider = "+windowSelectedMidleLeftSide);
    xSlidersMidleLeftFace.remove(windowSelectedMidleLeftSide);
    xSlidersMidleLeftFace.add(windowSelectedMidleLeftSide, theOscMessage.get(0).floatValue());
    sendMidleLeftFaceWindowMapping();
  }
  if (theOscMessage.checkAddrPattern("/middleface/left/y")==true) {
    ySlidersMidleLeftFace.remove(windowSelectedMidleLeftSide);
    ySlidersMidleLeftFace.add(windowSelectedMidleLeftSide, theOscMessage.get(0).floatValue());
    sendMidleLeftFaceWindowMapping();
  }
  if (theOscMessage.checkAddrPattern("/middleface/left/width")==true) {
    widthSlidersMidleLeftFace.remove(windowSelectedMidleLeftSide);
    widthSlidersMidleLeftFace.add(windowSelectedMidleLeftSide, theOscMessage.get(0).floatValue());
    sendMidleLeftFaceWindowMapping();
  }
  if (theOscMessage.checkAddrPattern("/middleface/left/height")==true) {
    heightSlidersMidleLeftFace.remove(windowSelectedMidleLeftSide);
    heightSlidersMidleLeftFace.add(windowSelectedMidleLeftSide, theOscMessage.get(0).floatValue());
    sendMidleLeftFaceWindowMapping();
  }

  //------------------------------------------------------------------------------------------
  if (theOscMessage.checkAddrPattern("/middleface/left/save")==true) {
    if (saveFaces.isFinished()) {
      saveAll_MidleLeftFaceSliders();
      // timer to prevent that document is saved 10 times
      println("Saved Midlle Left faces!");
    }
    saveFaces.start();
  }
}

void unToggleMidleLeftFace(int indexToIgnore) {

  for (int i = 0; i < namesWindowsMidleLeftFace.size();i++) {
    if (i != indexToIgnore) {
      // println((String)namesWindowsMidleLeftFace.get(i));
      myMessage.setAddrPattern((String)namesWindowsMidleLeftFace.get(i));
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

void getSliderDataMidleLeftFace(int index) {

  float xSlider = (Float)xSlidersMidleLeftFace.get(index);
  float ySlider = (Float)ySlidersMidleLeftFace.get((index));
  float widthSlider = (Float)widthSlidersMidleLeftFace.get((index));
  float heightSlider = (Float) heightSlidersMidleLeftFace.get((index));

  myMessage.setAddrPattern("/middleface/left/x");
  myMessage.add(xSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
  myMessage.setAddrPattern("/middleface/left/y");
  myMessage.add(ySlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
  myMessage.setAddrPattern("/middleface/left/width");
  myMessage.add(widthSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
  myMessage.setAddrPattern("/middleface/left/height");
  myMessage.add(heightSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
}

void loadAll_MidleLeftFaceSliders() {
  midleLeftFaceSliderData.load(sketchPath("save/windows/midleLeftFace.txt"));

  xSlidersMidleLeftFace.clear(); 
  ySlidersMidleLeftFace.clear(); 
  widthSlidersMidleLeftFace.clear(); 
  heightSlidersMidleLeftFace.clear(); 

  for (int i = 0; i <(namesWindowsMidleLeftFace.size()); i++) {
    xSlidersMidleLeftFace.add(i, midleLeftFaceSliderData.readFloatIndex(i*4));
    ySlidersMidleLeftFace.add(i, midleLeftFaceSliderData.readFloatIndex((i*4)+1));
    widthSlidersMidleLeftFace.add(i, midleLeftFaceSliderData.readFloatIndex((i*4)+2));
    heightSlidersMidleLeftFace.add(i, midleLeftFaceSliderData.readFloatIndex((i*4)+3));
  }
}
void saveAll_MidleLeftFaceSliders() {
  midleLeftFaceSliderData.beginSave();
  for (int i = 0; i < namesWindowsMidleLeftFace.size(); i++) {
    midleLeftFaceSliderData.add ((Float)xSlidersMidleLeftFace.get(i));
    midleLeftFaceSliderData.add ((Float)ySlidersMidleLeftFace.get((i)));
    midleLeftFaceSliderData.add ((Float)widthSlidersMidleLeftFace.get(i));
    midleLeftFaceSliderData.add ((Float) heightSlidersMidleLeftFace.get(i));
  }
  midleLeftFaceSliderData.endSave(sketchPath("save/windows/midleLeftFace.txt"));
}

