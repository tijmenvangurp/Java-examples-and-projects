int togglefaces =0;

void getMappingFaces(OscMessage theOscMessage) {

  for (int i = 0; i < namesCornersFaces.size(); i++) {

    if (theOscMessage.checkAddrPattern((String)namesCornersFaces.get(i))==true) {
      valuesCornersFaces.remove(i);
      valuesCornersFaces.add(i, (Integer) round (theOscMessage.get(0).floatValue()));
      println("window leftface nr "+i+" = "+(Integer)valuesCornersFaces.get(i));
      mappingCornerSelected = i;
      sendMappingValues();
      unToggleMappingCorners(i);
      getSliderDataMappingCornes(i);
    }
  }

  if (theOscMessage.checkAddrPattern("/mappingfaces/x")==true) {
    //println("xslider = "+windowSelectedLeftSide);
    xSliderMappingFaces.remove(mappingCornerSelected);
    xSliderMappingFaces.add(mappingCornerSelected, theOscMessage.get(0).floatValue());
    // send mapping values "Naam mapping", corner to be mapped, X, Y
    sendMappingValues();
  }
  if (theOscMessage.checkAddrPattern("/mappingfaces/y")==true) {
    ySliderMappingFaces.remove(mappingCornerSelected);
    ySliderMappingFaces.add(mappingCornerSelected, theOscMessage.get(0).floatValue());
    // send mapping values "Naam mapping", corner to be mapped, X, Y
    sendMappingValues();
  }

  if (theOscMessage.checkAddrPattern("/mappingfaces/save")==true) {


    if (saveFaces.isFinished()) {
      saveAllSliderDataMapping();
      // timer to prevent that document is saved 10 times
      println("Saved mapping!");
    }
    saveFaces.start();
  }
   if (theOscMessage.checkAddrPattern("/faces/cornertoggle")==true) {
     togglefaces = (Integer) round(theOscMessage.get(0).floatValue());
     sendToggles();
   }
  
}

void unToggleMappingCorners(int indexToIgnore) {
  for (int i = 0; i < namesCornersFaces.size();i++) {
    if (i != indexToIgnore) {
      // println((String)namesWindowsLeftFace.get(i));
      myMessage.setAddrPattern((String)namesCornersFaces.get(i));
      myMessage.add(0);
      oscP5.send(myMessage, remoteLocation_Ipad_1);
      myMessage.clear();
    }
  }
}

void getSliderDataMappingCornes(int index) {

  float xSlider = (Float)xSliderMappingFaces.get(index);
  float ySlider = (Float)ySliderMappingFaces.get((index));

  myMessage.setAddrPattern("/mappingfaces/x");
  myMessage.add(xSlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
  myMessage.setAddrPattern("/mappingfaces/y");
  myMessage.add(ySlider);
  oscP5.send(myMessage, remoteLocation_Ipad_1);
  myMessage.clear();
}

void loadAllSliderDataMapping() {

  mappingFaces_data.load(sketchPath("save/mapping/mapping.txt"));
  xSliderMappingFaces.clear(); 
  ySliderMappingFaces.clear(); 

  for (int i = 0; i <(namesCornersFaces.size()); i++) {
    xSliderMappingFaces.add(i, mappingFaces_data.readFloatIndex(i*2));
    ySliderMappingFaces.add(i, mappingFaces_data.readFloatIndex((i*2)+1));
  }
}

void saveAllSliderDataMapping() {
  mappingFaces_data.beginSave();
  for (int i = 0; i < namesCornersFaces.size(); i++) {
    mappingFaces_data.add ((Float)xSliderMappingFaces.get(i));
    mappingFaces_data.add ((Float)ySliderMappingFaces.get((i)));
  }
  mappingFaces_data.endSave(sketchPath("save/mapping/mapping.txt"));
}

