void getWindowsMidleRightFace(OscMessage theOscMessage) {

  for (int i = 0; i < namesWindowsMidleRightFace.size(); i++) {

    if (theOscMessage.checkAddrPattern((String)namesWindowsMidleRightFace.get(i))==true) {
      valuesWindowsMidleRightFace.remove(i);
      valuesWindowsMidleRightFace.add(i, (Integer) round (theOscMessage.get(0).floatValue()));
      println("window Midle Rightface nr "+i+" = "+(Integer)valuesWindowsMidleRightFace.get(i));
      windowSelectedMidleRightSide = i;
      unToggleMidleRightFace(i);
      getSliderDataMidleRightFace(i);
    }
  }

  //------------------------------------------------------------------------------------------

  if (theOscMessage.checkAddrPattern("/middleface/right/x")==true) {
    //println("xslider = "+windowSelectedMidleRightSide);
    xSlidersMidleRightFace.remove(windowSelectedMidleRightSide);
    xSlidersMidleRightFace.add(windowSelectedMidleRightSide, theOscMessage.get(0).floatValue());
    sendMidleRightFaceWindowMapping();
  }
  if (theOscMessage.checkAddrPattern("/middleface/right/y")==true) {
    ySlidersMidleRightFace.remove(windowSelectedMidleRightSide);
    ySlidersMidleRightFace.add(windowSelectedMidleRightSide, theOscMessage.get(0).floatValue());
    sendMidleRightFaceWindowMapping();
  }
  if (theOscMessage.checkAddrPattern("/middleface/right/width")==true) {
    widthSlidersMidleRightFace.remove(windowSelectedMidleRightSide);
    widthSlidersMidleRightFace.add(windowSelectedMidleRightSide, theOscMessage.get(0).floatValue());
    sendMidleRightFaceWindowMapping();
  }
  if (theOscMessage.checkAddrPattern("/middleface/right/height")==true) {
    heightSlidersMidleRightFace.remove(windowSelectedMidleRightSide);
    heightSlidersMidleRightFace.add(windowSelectedMidleRightSide, theOscMessage.get(0).floatValue());
    sendMidleRightFaceWindowMapping();
  }

  //------------------------------------------------------------------------------------------
  if (theOscMessage.checkAddrPattern("/middleface/right/save")==true) {
    if (saveFaces.isFinished()) {
      saveAll_MidleRightFaceSliders();
      // timer to prevent that document is saved 10 times
      println("Saved Midlle Right faces!");
    }
    saveFaces.start();
  }
}

void unToggleMidleRightFace(int indexToIgnore) {

  for (int i = 0; i < namesWindowsMidleRightFace.size();i++) {
    if (i != indexToIgnore) {
      // println((String)namesWindowsMidleRightFace.get(i));
      myMessage.setAddrPattern((String)namesWindowsMidleRightFace.get(i));
      myMessage.add(0);
      oscP5.send(myMessage, remoteLocation_Ipad_1);
      myMessage.clear();
    }
  }
  // myMessage.setAddrPattern((String)namesWindowsMidleRightFace.get(indexToIgnore));
  //  println("window to toggle = "+(String)namesWindowsMidleRightFace.get(indexToIgnore));
  // myMessage.add(1);
  //  oscP5.send(myMessage, remoteLocation_Ipad_1);
  // myMessage.clear();
}

void getSliderDataMidleRightFace(int index) {

  float xSlider = (Float)xSlidersMidleRightFace.get(index);
  float ySlider = (Float)ySlidersMidleRightFace.get((index));
  float widthSlider = (Float)widthSlidersMidleRightFace.get((index));
  float heightSlider = (Float) heightSlidersMidleRightFace.get((index));

  myMessage.setAddrPattern("/middleface/right/x");
  myMessage.add(xSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
  myMessage.setAddrPattern("/middleface/right/y");
  myMessage.add(ySlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
  myMessage.setAddrPattern("/middleface/right/width");
  myMessage.add(widthSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
  myMessage.setAddrPattern("/middleface/right/height");
  myMessage.add(heightSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
}

void loadAll_MidleRightFaceSliders() {
  midleRightFaceSliderData.load(sketchPath("save/windows/midleRightFace.txt"));

  xSlidersMidleRightFace.clear(); 
  ySlidersMidleRightFace.clear(); 
  widthSlidersMidleRightFace.clear(); 
  heightSlidersMidleRightFace.clear(); 

  for (int i = 0; i <(namesWindowsMidleRightFace.size()); i++) {
    xSlidersMidleRightFace.add(i, midleRightFaceSliderData.readFloatIndex(i*4));
    ySlidersMidleRightFace.add(i, midleRightFaceSliderData.readFloatIndex((i*4)+1));
    widthSlidersMidleRightFace.add(i, midleRightFaceSliderData.readFloatIndex((i*4)+2));
    heightSlidersMidleRightFace.add(i, midleRightFaceSliderData.readFloatIndex((i*4)+3));
  }
}
void saveAll_MidleRightFaceSliders() {
  midleRightFaceSliderData.beginSave();
  for (int i = 0; i < namesWindowsMidleRightFace.size(); i++) {
    midleRightFaceSliderData.add ((Float)xSlidersMidleRightFace.get(i));
    midleRightFaceSliderData.add ((Float)ySlidersMidleRightFace.get((i)));
    midleRightFaceSliderData.add ((Float)widthSlidersMidleRightFace.get(i));
    midleRightFaceSliderData.add ((Float) heightSlidersMidleRightFace.get(i));
  }
  midleRightFaceSliderData.endSave(sketchPath("save/windows/midleRightFace.txt"));
}

