// Recieving TOUCH OSC

/*****
 Variables for TOUCHOSC recieving part
 *****/

float xRotation = 0;
float yRotation = 0;
float orientation = 0;

int mappingCornerSelected = 0;
int windowSelectedLeftSide = 0;
int windowSelectedMidleLeftSide = 0; 
int windowSelectedMidleRightSide = 0; 
int windowSelectedRightSide = 0; 
int dachboardFunctionSelected = 0;

boolean switchToIphone = false;
boolean FacesSaved = false;

boolean leftFaceSelected = true;// init op true because you start in this screen and you want to be able to hear messages comming
boolean middleLeftFaceSelected = false;
boolean middleRightFaceSelected = false;
boolean rightFaceSelected = false;
boolean mappingFacesSelected = false;
boolean dachboardSelected = false;

void oscEvent(OscMessage theOscMessage) {

  //println(theOscMessage);
  //  print(" addrpattern: "+theOscMessage.checkAddrPattern("/pythonxyz")==true);

  if (theOscMessage.checkAddrPattern("/pythonxyz")==true) {
    //    println("getting python messages  = "+theOscMessage.checkAddrPattern("/pythonxyz"));
    xRotation = (theOscMessage.get(0).floatValue());
    yRotation = (theOscMessage.get(1).floatValue());
    orientation = theOscMessage.get(2).floatValue();
    //println("xRotation = "+xRotation*90);
    //println("xRotation = "+xRotation*90);
    //println("yRotation = "+yRotation*90);
    switchToIphone = false;
    switchToIphoneTimer.start();
  }

//  if (switchToIphoneTimer.isFinished()) {
//    //println(millis());
//    switchToIphone = true; 
//    //      println("Geen messages meer van python dus overschakelen naar Iphone");
//  }
//  //  println("switch to Iphone = "+switchToIphone);
//
//  if (theOscMessage.checkAddrPattern("/accxyz")==true) {
//    if (switchToIphone) {
//      //     println("Iphone waardes worden toegekent");
//      xRotation = (theOscMessage.get(0).floatValue());
//      yRotation = (theOscMessage.get(1).floatValue());
//      orientation = theOscMessage.get(2).floatValue();
//    }
//    //println("xRotation = "+xRotation*90);
//    //println("yRotation = "+yRotation*90);
//  }
 
  if (theOscMessage.checkAddrPattern("/leftface")==true) {
    println("switch to leftface");
    leftFaceSelected = true;
    middleLeftFaceSelected = false;
    middleRightFaceSelected = false;
    rightFaceSelected = false;
    mappingFacesSelected = false;
    dachboardSelected = false;
  }

  if (theOscMessage.checkAddrPattern("/mappingfaces")==true) {
    println("switch to mappingface");
    leftFaceSelected = false;
    middleLeftFaceSelected = false;
    middleRightFaceSelected = false;
    rightFaceSelected = false;
    mappingFacesSelected = true;
    dachboardSelected = false;
  }

  if (theOscMessage.checkAddrPattern("/middlefaceleft")==true) {
    println("switch to Midlle Left Face");
    leftFaceSelected = false;
    middleLeftFaceSelected = true;
    middleRightFaceSelected = false;
    rightFaceSelected = false;
    mappingFacesSelected = false;
    dachboardSelected = false;
  }

  if (theOscMessage.checkAddrPattern("/middlefaceright")==true) {
    println("switch to Midlle Right Face");
    leftFaceSelected = false;
    middleLeftFaceSelected = false;
    middleRightFaceSelected = true;
    rightFaceSelected = false;
    mappingFacesSelected = false;
    dachboardSelected = false;
  }

  if (theOscMessage.checkAddrPattern("/rightface")==true) {
    println("switch to Right Face");
    leftFaceSelected = false;
    middleLeftFaceSelected = false;
    middleRightFaceSelected = false;
    rightFaceSelected = true;
    mappingFacesSelected = false;
    dachboardSelected = false;
  }
  
   if (theOscMessage.checkAddrPattern("/dashboard")==true) {
    println("switch to Dashboard ;)");
    leftFaceSelected = false;
    middleLeftFaceSelected = false;
    middleRightFaceSelected = false;
    rightFaceSelected = false;
    mappingFacesSelected = false;
    dachboardSelected = true;
  }
  
  

  //println(" addrpattern: "+theOscMessage.addrPattern());
  //println(" typetag: "+theOscMessage.typetag());

}

