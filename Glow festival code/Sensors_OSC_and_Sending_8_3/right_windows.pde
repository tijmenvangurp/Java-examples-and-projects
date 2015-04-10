void getWindowsRightFace(OscMessage theOscMessage) {

  for (int i = 0; i < namesWindowsRightFace.size(); i++) {

    if (theOscMessage.checkAddrPattern((String)namesWindowsRightFace.get(i))==true) {
      valuesWindowsRightFace.remove(i);
      valuesWindowsRightFace.add(i, (Integer) round (theOscMessage.get(0).floatValue()));
      println("window Midle Rightface nr "+i+" = "+(Integer)valuesWindowsRightFace.get(i));
      windowSelectedRightSide = i;
      unToggleRightFace(i);
      getSliderDataRightFace(i);
    }
  }

  //------------------------------------------------------------------------------------------

  if (theOscMessage.checkAddrPattern("/rightface/x")==true) {
    //println("xslider = "+windowSelectedRightSide);
    xSlidersRightFace.remove(windowSelectedRightSide);
    xSlidersRightFace.add(windowSelectedRightSide, theOscMessage.get(0).floatValue());
    sendRightFaceWindowMapping();
  }
  if (theOscMessage.checkAddrPattern("/rightface/y")==true) {    
    ySlidersRightFace.remove(windowSelectedRightSide);
    ySlidersRightFace.add(windowSelectedRightSide, theOscMessage.get(0).floatValue());
    sendRightFaceWindowMapping();
  }
  if (theOscMessage.checkAddrPattern("/rightface/width")==true) {
    widthSlidersRightFace.remove(windowSelectedRightSide);
    widthSlidersRightFace.add(windowSelectedRightSide, theOscMessage.get(0).floatValue());
    sendRightFaceWindowMapping();
  }
  if (theOscMessage.checkAddrPattern("/rightface/height")==true) {
    heightSlidersRightFace.remove(windowSelectedRightSide);
    heightSlidersRightFace.add(windowSelectedRightSide, theOscMessage.get(0).floatValue());
    sendRightFaceWindowMapping();
  }

  //------------------------------------------------------------------------------------------
  if (theOscMessage.checkAddrPattern("/rightface/save")==true) {
    if (saveFaces.isFinished()) {
      saveAll_RightFaceSliders();
      // timer to prevent that document is saved 10 times
      println("Saved Right faces!");
    }
    saveFaces.start();
  }
}

void unToggleRightFace(int indexToIgnore) {

  for (int i = 0; i < namesWindowsRightFace.size();i++) {
    if (i != indexToIgnore) {
      // println((String)namesWindowsRightFace.get(i));
      myMessage.setAddrPattern((String)namesWindowsRightFace.get(i));
      myMessage.add(0);
      oscP5.send(myMessage, remoteLocation_Ipad_1);
      myMessage.clear();
    }
  }
  // myMessage.setAddrPattern((String)namesWindowsRightFace.get(indexToIgnore));
  //  println("window to toggle = "+(String)namesWindowsRightFace.get(indexToIgnore));
  // myMessage.add(1);
  //  oscP5.send(myMessage, remoteLocation_Ipad_1);
  // myMessage.clear();
}

void getSliderDataRightFace(int index) {

  float xSlider = (Float)xSlidersRightFace.get(index);
  float ySlider = (Float)ySlidersRightFace.get((index));
  float widthSlider = (Float)widthSlidersRightFace.get((index));
  float heightSlider = (Float) heightSlidersRightFace.get((index));

  myMessage.setAddrPattern("/rightface/x");
  myMessage.add(xSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
  myMessage.setAddrPattern("/rightface/y");
  myMessage.add(ySlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
  myMessage.setAddrPattern("/rightface/width");
  myMessage.add(widthSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
  myMessage.setAddrPattern("/rightface/height");
  myMessage.add(heightSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
}

void loadAll_RightFaceSliders() {
  rightFaceSliderData.load(sketchPath("save/windows/rightFace.txt"));

  xSlidersRightFace.clear(); 
  ySlidersRightFace.clear(); 
  widthSlidersRightFace.clear(); 
  heightSlidersRightFace.clear(); 

  for (int i = 0; i <(namesWindowsRightFace.size()); i++) {
    xSlidersRightFace.add(i, rightFaceSliderData.readFloatIndex(i*4));
    ySlidersRightFace.add(i, rightFaceSliderData.readFloatIndex((i*4)+1));
    widthSlidersRightFace.add(i, rightFaceSliderData.readFloatIndex((i*4)+2));
    heightSlidersRightFace.add(i, rightFaceSliderData.readFloatIndex((i*4)+3));
  }
}
void saveAll_RightFaceSliders() {
  rightFaceSliderData.beginSave();
  for (int i = 0; i < namesWindowsRightFace.size(); i++) {
    rightFaceSliderData.add ((Float)xSlidersRightFace.get(i));
    rightFaceSliderData.add ((Float)ySlidersRightFace.get((i)));
    rightFaceSliderData.add ((Float)widthSlidersRightFace.get(i));
    rightFaceSliderData.add ((Float) heightSlidersRightFace.get(i));
  }
  rightFaceSliderData.endSave(sketchPath("save/windows/rightFace.txt"));
}

