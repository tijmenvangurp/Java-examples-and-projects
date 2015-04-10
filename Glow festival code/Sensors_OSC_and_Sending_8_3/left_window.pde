void getWindowsLeftFace(OscMessage theOscMessage) {

  for (int i = 0; i < namesWindowsLeftFace.size(); i++) {

    if (theOscMessage.checkAddrPattern((String)namesWindowsLeftFace.get(i))==true) {
      valuesWindowsLeftFace.remove(i);
      valuesWindowsLeftFace.add(i, (Integer) round (theOscMessage.get(0).floatValue()));
      println("window leftface nr "+i+" = "+(Integer)valuesWindowsLeftFace.get(i));
      windowSelectedLeftSide = i;
      unToggleLeftFace(i);
      getSliderDataLeftFace(i);
    }
  }
  if (theOscMessage.checkAddrPattern("/leftface/x")==true) {
    //println("xslider = "+windowSelectedLeftSide);
    xSlidersLeftFace.remove(windowSelectedLeftSide);
    xSlidersLeftFace.add(windowSelectedLeftSide, theOscMessage.get(0).floatValue());
    sendLeftFaceWindowMapping();
  }
  if (theOscMessage.checkAddrPattern("/leftface/y")==true) {
    ySlidersLeftFace.remove(windowSelectedLeftSide);
    ySlidersLeftFace.add(windowSelectedLeftSide, theOscMessage.get(0).floatValue());
    sendLeftFaceWindowMapping();
  }
  if (theOscMessage.checkAddrPattern("/leftface/width")==true) {
    widthSlidersLeftFace.remove(windowSelectedLeftSide);
    widthSlidersLeftFace.add(windowSelectedLeftSide, theOscMessage.get(0).floatValue());
    sendLeftFaceWindowMapping();
  }
  if (theOscMessage.checkAddrPattern("/leftface/height")==true) {
    heightSlidersLeftFace.remove(windowSelectedLeftSide);
    heightSlidersLeftFace.add(windowSelectedLeftSide, theOscMessage.get(0).floatValue());
    sendLeftFaceWindowMapping();
  }
  if (theOscMessage.checkAddrPattern("/leftface/save")==true) {


    if (saveFaces.isFinished()) {
      saveAll_LeftFaceSliders();
      // timer to prevent that document is saved 10 times
      println("Saved Leved faces!");
    }
    saveFaces.start();
  }
}

void unToggleLeftFace(int indexToIgnore) {

  for (int i = 0; i < namesWindowsLeftFace.size();i++) {
    if (i != indexToIgnore) {
      // println((String)namesWindowsLeftFace.get(i));
      myMessage.setAddrPattern((String)namesWindowsLeftFace.get(i));
      myMessage.add(0);
      oscP5.send(myMessage, remoteLocation_Ipad_1);
      myMessage.clear();
    }
  }
  // myMessage.setAddrPattern((String)namesWindowsLeftFace.get(indexToIgnore));
  //  println("window to toggle = "+(String)namesWindowsLeftFace.get(indexToIgnore));
  // myMessage.add(1);
  //  oscP5.send(myMessage, remoteLocation_Ipad_1);
  // myMessage.clear();
}

void getSliderDataLeftFace(int index) {

  float xSlider = (Float)xSlidersLeftFace.get(index);
  float ySlider = (Float)ySlidersLeftFace.get((index));
  float widthSlider = (Float)widthSlidersLeftFace.get((index));
  float heightSlider = (Float)heightSlidersLeftFace.get((index));

  myMessage.setAddrPattern("/leftface/x");
  myMessage.add(xSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
  myMessage.setAddrPattern("/leftface/y");
  myMessage.add(ySlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
  myMessage.setAddrPattern("/leftface/width");
  myMessage.add(widthSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
  myMessage.setAddrPattern("/leftface/height");
  myMessage.add(heightSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
}

void loadAll_LeftFaceSliders() {

  leftFaceSliderData.load(sketchPath("save/windows/leftface.txt"));

  xSlidersLeftFace.clear(); 
  ySlidersLeftFace.clear(); 
  widthSlidersLeftFace.clear(); 
  heightSlidersLeftFace.clear(); 

  for (int i = 0; i <(namesWindowsLeftFace.size()); i++) {
    xSlidersLeftFace.add(i, leftFaceSliderData.readFloatIndex(i*4));
    ySlidersLeftFace.add(i, leftFaceSliderData.readFloatIndex((i*4)+1));
    widthSlidersLeftFace.add(i, leftFaceSliderData.readFloatIndex((i*4)+2));
    heightSlidersLeftFace.add(i, leftFaceSliderData.readFloatIndex((i*4)+3));
  }
}

void saveAll_LeftFaceSliders() {
  leftFaceSliderData.beginSave();
  for (int i = 0; i < namesWindowsLeftFace.size(); i++) {
    leftFaceSliderData.add ((Float)xSlidersLeftFace.get(i));
    leftFaceSliderData.add ((Float)ySlidersLeftFace.get((i)));
    leftFaceSliderData.add ((Float)widthSlidersLeftFace.get(i));
    leftFaceSliderData.add ((Float)heightSlidersLeftFace.get(i));
  }
  leftFaceSliderData.endSave(sketchPath("save/windows/leftface.txt"));
}

