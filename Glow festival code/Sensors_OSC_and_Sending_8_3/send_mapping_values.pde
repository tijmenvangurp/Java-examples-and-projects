void sendMappingValues() {


  String name = "/mappingValuesFaces"; 
  int index =  mappingCornerSelected; 
  float x = (Float)xSliderMappingFaces.get(mappingCornerSelected); 
  float y = (Float)ySliderMappingFaces.get(mappingCornerSelected); 

  myMessage.setAddrPattern(name);

  myMessage.add(new Object[] { 
    new Float(index+1), new Float(x), new Float(y)
  }
  );
  sendToMacMinis(myMessage);
  myMessage.clear();
}

void sendLeftFaceWindowMapping() {
  String name = "/mappingWindowLeftFace"; 
  int index =  windowSelectedLeftSide; 
  float x = (Float)xSlidersLeftFace.get(windowSelectedLeftSide); 
  float y = (Float)ySlidersLeftFace.get(windowSelectedLeftSide); 
  float widthWindow = (Float)widthSlidersLeftFace.get(windowSelectedLeftSide); 
  float heightWindow = (Float)heightSlidersLeftFace.get(windowSelectedLeftSide);

  myMessage.setAddrPattern(name);

  myMessage.add(new Object[] { 
    new Float(index+1), new Float(x), new Float(y), new Float(widthWindow), new Float (heightWindow)
  }
  );
  sendToMacMinis(myMessage);
  myMessage.clear();
}


void sendMidleLeftFaceWindowMapping() {
  String name = "/mappingWindowLeftMidleFace"; 
  int index =  windowSelectedMidleLeftSide; 
  float x = (Float)xSlidersMidleLeftFace.get(windowSelectedMidleLeftSide); 
  float y = (Float)ySlidersMidleLeftFace.get(windowSelectedMidleLeftSide); 
  float widthWindow = (Float)widthSlidersMidleLeftFace.get(windowSelectedMidleLeftSide); 
  float heightWindow = (Float)heightSlidersMidleLeftFace.get(windowSelectedMidleLeftSide);

  myMessage.setAddrPattern(name);

  myMessage.add(new Object[] { 
    new Float(index+1), new Float(x), new Float(y), new Float(widthWindow), new Float (heightWindow)
  }
  );
  sendToMacMinis(myMessage);
  myMessage.clear();
}

void  sendMidleRightFaceWindowMapping() {
  String name = "/mappingWindowRightMidleFace"; 
  int index =  windowSelectedMidleRightSide; 
  float x = (Float)xSlidersMidleRightFace.get(windowSelectedMidleRightSide); 
  float y = (Float)ySlidersMidleRightFace.get(windowSelectedMidleRightSide); 
  float widthWindow = (Float)widthSlidersMidleRightFace.get(windowSelectedMidleRightSide); 
  float heightWindow = (Float)heightSlidersMidleRightFace.get(windowSelectedMidleRightSide);

  myMessage.setAddrPattern(name);

  myMessage.add(new Object[] { 
    new Float(index+1), new Float(x), new Float(y), new Float(widthWindow), new Float (heightWindow)
  }
  );
  sendToMacMinis(myMessage);
  myMessage.clear();
}

void sendRightFaceWindowMapping() {
  String name = "/mappingWindowRightFace"; 
  int index =  windowSelectedRightSide; 
  float x = (Float)xSlidersRightFace.get(windowSelectedRightSide); 
  float y = (Float)ySlidersRightFace.get(windowSelectedRightSide); 
  float widthWindow = (Float)widthSlidersRightFace.get(windowSelectedRightSide); 
  float heightWindow = (Float)heightSlidersRightFace.get(windowSelectedRightSide);

  myMessage.setAddrPattern(name);

  myMessage.add(new Object[] { 
    new Float(index+1), new Float(x), new Float(y), new Float(widthWindow), new Float (heightWindow)
  }
  );
  sendToMacMinis(myMessage);
  myMessage.clear();
}



