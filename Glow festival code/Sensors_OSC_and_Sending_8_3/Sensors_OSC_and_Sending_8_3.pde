/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
import oscP5.*;
import netP5.*;

OscP5 oscP5;


OscBundle myBundle;
OscMessage myMessage;

/**
 portToListenTo, port we are listening on, this should be the same as
 the outgoing port of TouchOsc on your iphone
 */
int portToListenTo = 7000; 
/**
 portToSendTo, port we are sending to, this should be the same as
 the incomning port of the program as you are sending t0.
 **/
int portToSendTo = 60000;
/**
 The Ip adress to send to and remote location
 **/
NetAddress remoteLocation_macMiniOne;
NetAddress remoteLocation_macMiniTwo;
NetAddress remoteLocation_macMiniThree;
NetAddress remoteLocation_thom;
NetAddress remoteLocation_Ipad_1;

String macMiniOne = "192.168.0.107";
String macMiniTwo = "192.168.0.102";
String macMiniThree = "192.168.0.101";
String thom = "192.168.0.100";
String Ipad_1 = "192.168.0.109";





NetAddress remoteLocation_soundPC;
String soundPC = "192.168.0.106";


/**
 Initiate smoothing class for the values to be smoothed.
 **/
Smoothing xSmoothing;
Smoothing ySmoothing;
Smoothing xSmoothingSound;
Smoothing ySmoothingSound;
Smoothing xAccelerationSmoothing;
Smoothing yAccelerationSmoothing;
/**
 Initiate Timer to check if the USB accelerometer is offline for longer than 5 seconds
 */
Timer switchToIphoneTimer;
Timer saveFaces;

/**
 Initiate XY COMPARE
 */
XYacceleration xyAcceleration;
/**
 Initiate Data class
 */
Data frequency_data;
Data leftFaceSliderData;
Data midleLeftFaceSliderData;
Data midleRightFaceSliderData;
Data rightFaceSliderData;
Data mappingFaces_data;
Data dashboard_data;

//variable names of test that I did for the slider data not needed anymore but don't want it to crash so that is why it is still here
ArrayList variableNames;

/**
 Initiate arraylist for names of windows
 */
// left face 
ArrayList namesWindowsLeftFace;
ArrayList valuesWindowsLeftFace;
ArrayList xSlidersLeftFace;
ArrayList ySlidersLeftFace;
ArrayList widthSlidersLeftFace;
ArrayList heightSlidersLeftFace;

// midleLeft face 
ArrayList namesWindowsMidleLeftFace;
ArrayList valuesWindowsMidleLeftFace;
ArrayList xSlidersMidleLeftFace;
ArrayList ySlidersMidleLeftFace;
ArrayList widthSlidersMidleLeftFace;
ArrayList heightSlidersMidleLeftFace;

// midleRight face 
ArrayList namesWindowsMidleRightFace;
ArrayList valuesWindowsMidleRightFace;
ArrayList xSlidersMidleRightFace;
ArrayList ySlidersMidleRightFace;
ArrayList widthSlidersMidleRightFace;
ArrayList heightSlidersMidleRightFace;

// Right face 
ArrayList namesWindowsRightFace;
ArrayList valuesWindowsRightFace;
ArrayList xSlidersRightFace;
ArrayList ySlidersRightFace;
ArrayList widthSlidersRightFace;
ArrayList heightSlidersRightFace;

// Dashboard
ArrayList dashboard_function_names;
ArrayList dashboard_function_values;
ArrayList standardoffset;
ArrayList offsetmultiplier;
ArrayList standartamplitude;
ArrayList amplitudeacceleration;
ArrayList maximumamplitude;
ArrayList minmaxoffset;


/**
 Initiate arraylist for mapping of the faces
 */
ArrayList namesCornersFaces;
ArrayList valuesCornersFaces;
ArrayList xSliderMappingFaces;
ArrayList ySliderMappingFaces;

void setup() {
  //frameRate(30);

  size(screenWidth/2, screenHeight/2);
  background(0);
  //  OSC -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  /**
   oscP5sendreceive by andreas schlegel
   **/

  oscP5 = new OscP5(this, portToListenTo);

  /** myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   **/
  remoteLocation_macMiniOne = new NetAddress(macMiniOne, portToSendTo);  
  remoteLocation_macMiniTwo = new NetAddress(macMiniTwo, portToSendTo);  
  remoteLocation_macMiniThree = new NetAddress(macMiniThree, portToSendTo); 
  remoteLocation_soundPC = new NetAddress(soundPC, portToSendTo);
  remoteLocation_thom  = new NetAddress(thom, portToSendTo);
  remoteLocation_Ipad_1 = new NetAddress(Ipad_1, portToSendTo);

  myBundle = new OscBundle();
  myMessage = new OscMessage("/");
  // SMOOTHING ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  /**
   Initiate smoothing class for the values to be smoothed. The number that we pass with is the amount of values we want to use in the moving arraylist. The higher the number the more smooth it will be, but the slower it will be
   Smoothing(running average of number of readings)
   **/
  //larger number is more smoothing
  xSmoothing = new Smoothing();
  ySmoothing = new Smoothing();
  xSmoothingSound =  new Smoothing();
  ySmoothingSound =  new Smoothing();
  xAccelerationSmoothing = new Smoothing();
  yAccelerationSmoothing = new Smoothing();

  //TIMERS ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  /**
   Initiate Timer to check if the USB accelerometer is offline for longer than 5 seconds
   */
  switchToIphoneTimer = new Timer(5000);
  // wait for 5 seconds before we are going to listen to the iphone
  saveFaces = new Timer(200);
  //we dont want to save too many txt after eachother
  //ACCELERATION > movement Detection -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  /**
   Initiate XY COMPARE
   */
  xyAcceleration = new XYacceleration();
  // DATA TXT Files --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  /**
   Initiate Data class
   */
  frequency_data = new  Data();
  mappingFaces_data = new Data();
  leftFaceSliderData = new Data();
  midleLeftFaceSliderData = new Data();
  midleRightFaceSliderData = new Data();
  rightFaceSliderData = new Data();
  dashboard_data = new Data();

  variableNames = new ArrayList();
  // Windows LEFT FACE -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  /**
   Initiate arraylist for names of left face windows
   */
  namesWindowsLeftFace = new ArrayList();
  valuesWindowsLeftFace = new ArrayList();
  xSlidersLeftFace =  new ArrayList();
  ySlidersLeftFace = new ArrayList();
  widthSlidersLeftFace = new ArrayList();
  heightSlidersLeftFace = new ArrayList();

  /**
   Fill left face with its names to listen to
   */
  namesWindowsLeftFace.add("/leftface/window/0");
  namesWindowsLeftFace.add("/leftface/window/1");
  namesWindowsLeftFace.add("/leftface/window/2");
  namesWindowsLeftFace.add("/leftface/window/3");
  namesWindowsLeftFace.add("/leftface/window/4");
  namesWindowsLeftFace.add("/leftface/window/5");
  namesWindowsLeftFace.add("/leftface/window/6");
  namesWindowsLeftFace.add("/leftface/window/7");
  namesWindowsLeftFace.add("/leftface/window/8");
  namesWindowsLeftFace.add("/leftface/window/9");
  namesWindowsLeftFace.add("/leftface/window/10");
  namesWindowsLeftFace.add("/leftface/window/11");
  namesWindowsLeftFace.add("/leftface/window/12");
  // make valuesWindowsLeftFace array aan
  for (int i = 0 ; i < namesWindowsLeftFace.size();i++) {
    valuesWindowsLeftFace.add(0);
  }
  // println("ammount of windows on left side = "+valuesWindowsLeftFace.size());
  loadAll_LeftFaceSliders();
  // hier moet functie komen die even alle waardes stuurt achter elkaar ( misschien met een delay? ) nog testen
  saveAll_LeftFaceSliders();

  // Windows MiddleLeft FACE -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  /**
   Initiate arraylist for names of left face windows
   */
  namesWindowsMidleLeftFace = new ArrayList();
  valuesWindowsMidleLeftFace = new ArrayList();
  xSlidersMidleLeftFace =  new ArrayList();
  ySlidersMidleLeftFace = new ArrayList();
  widthSlidersMidleLeftFace = new ArrayList();
  heightSlidersMidleLeftFace = new ArrayList();

  /**
   Fill left face with its names to listen to
   */
  namesWindowsMidleLeftFace.add("/middleface/left/0");
  namesWindowsMidleLeftFace.add("/middleface/left/1");
  namesWindowsMidleLeftFace.add("/middleface/left/2");
  namesWindowsMidleLeftFace.add("/middleface/left/3");
  namesWindowsMidleLeftFace.add("/middleface/left/4");
  namesWindowsMidleLeftFace.add("/middleface/left/5");
  namesWindowsMidleLeftFace.add("/middleface/left/6");

  // make valuesWindowsLeftFace array aan
  for (int i = 0 ; i < namesWindowsMidleLeftFace.size();i++) {
    valuesWindowsMidleLeftFace.add(0);
  }
  // println("ammount of windows on left side = "+valuesWindowsLeftFace.size());
  loadAll_MidleLeftFaceSliders();
  // hier moet functie komen die even alle waardes stuurt achter elkaar ( misschien met een delay? ) nog testen
  saveAll_MidleLeftFaceSliders();

  // Windows MiddleRIGHT FACE -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  /**
   Initiate arraylist for names of left face windows
   */
  namesWindowsMidleRightFace = new ArrayList();
  valuesWindowsMidleRightFace = new ArrayList();
  xSlidersMidleRightFace =  new ArrayList();
  ySlidersMidleRightFace = new ArrayList();
  widthSlidersMidleRightFace = new ArrayList();
  heightSlidersMidleRightFace = new ArrayList();

  /**
   Fill Right face with its names to listen to
   */
  namesWindowsMidleRightFace.add("/middleface/right/0");
  namesWindowsMidleRightFace.add("/middleface/right/1");
  namesWindowsMidleRightFace.add("/middleface/right/2");
  namesWindowsMidleRightFace.add("/middleface/right/3");
  namesWindowsMidleRightFace.add("/middleface/right/4");
  namesWindowsMidleRightFace.add("/middleface/right/5");

  // make valuesWindowsRightFace array aan
  for (int i = 0 ; i < namesWindowsMidleRightFace.size();i++) {
    valuesWindowsMidleRightFace.add(0);
  }
  // println("ammount of windows on Right side = "+valuesWindowsRightFace.size());
  loadAll_MidleRightFaceSliders();
  // hier moet functie komen die even alle waardes stuurt achter elkaar ( misschien met een delay? ) nog testen
  saveAll_MidleRightFaceSliders();

  // Windows RIGHT FACE -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  /**
   Initiate arraylist for names of left face windows
   */
  namesWindowsRightFace = new ArrayList();
  valuesWindowsRightFace = new ArrayList();
  xSlidersRightFace =  new ArrayList();
  ySlidersRightFace = new ArrayList();
  widthSlidersRightFace = new ArrayList();
  heightSlidersRightFace = new ArrayList();

  /**
   Fill Right face with its names to listen to
   */
  namesWindowsRightFace.add("/rightface/0");
  namesWindowsRightFace.add("/rightface/1");
  namesWindowsRightFace.add("/rightface/2");
  namesWindowsRightFace.add("/rightface/3");
  namesWindowsRightFace.add("/rightface/4");
  namesWindowsRightFace.add("/rightface/5");
  namesWindowsRightFace.add("/rightface/6");
  namesWindowsRightFace.add("/rightface/7");
  namesWindowsRightFace.add("/rightface/8");
  namesWindowsRightFace.add("/rightface/9");
  namesWindowsRightFace.add("/rightface/10");
  namesWindowsRightFace.add("/rightface/11");
  namesWindowsRightFace.add("/rightface/12");
  namesWindowsRightFace.add("/rightface/13");


  // make valuesWindowsRightFace array aan
  for (int i = 0 ; i < namesWindowsRightFace.size();i++) {
    valuesWindowsRightFace.add(0);
  }
  // println("ammount of windows on Right side = "+valuesWindowsRightFace.size());
  loadAll_RightFaceSliders();
  // hier moet functie komen die even alle waardes stuurt achter elkaar ( misschien met een delay? ) nog testen
  saveAll_RightFaceSliders();

  // MAPPING GRID -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  /**
   Initiate arraylist for mapping of the faces
   */

  namesCornersFaces = new ArrayList();
  valuesCornersFaces = new ArrayList();
  xSliderMappingFaces =  new ArrayList();
  ySliderMappingFaces = new ArrayList();

  namesCornersFaces.add("/faces/1/0");
  namesCornersFaces.add("/faces/1/1");
  namesCornersFaces.add("/faces/1/2");
  namesCornersFaces.add("/faces/1/3");
  namesCornersFaces.add("/faces/2/0");
  namesCornersFaces.add("/faces/2/1");
  namesCornersFaces.add("/faces/2/2");
  namesCornersFaces.add("/faces/2/3");
  namesCornersFaces.add("/faces/3/0");
  namesCornersFaces.add("/faces/3/1");
  namesCornersFaces.add("/faces/3/2");
  namesCornersFaces.add("/faces/3/3");
  namesCornersFaces.add("/faces/4/0");
  namesCornersFaces.add("/faces/4/1");
  namesCornersFaces.add("/faces/4/2");
  namesCornersFaces.add("/faces/4/3");
  
  namesCornersFaces.add("/faces/masking/0");
  namesCornersFaces.add("/faces/masking/1");
  
  for (int i = 0 ; i < namesCornersFaces.size();i++) {
    valuesCornersFaces.add(0);
  }
  loadAllSliderDataMapping();
  saveAllSliderDataMapping();

  // DashBoard -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  dashboard_function_values = new ArrayList();
  dashboard_function_names = new ArrayList();
  standardoffset = new ArrayList();
  offsetmultiplier = new ArrayList();
  minmaxoffset = new ArrayList();
  
  standartamplitude =  new ArrayList();
  amplitudeacceleration = new ArrayList();
  maximumamplitude =  new ArrayList();
  

  dashboard_function_names.add("/dashboard/scalegrid");
  dashboard_function_names.add("/dashboard/bricks");
  dashboard_function_names.add("/dashboard/light");
  dashboard_function_names.add("/dashboard/sound");
  
  for (int i = 0 ; i < dashboard_function_names.size();i++) {
    dashboard_function_values.add(0);
  }
  loadAllSlidersDashboard();
  //font = loadFont("Arial-Black-24.vlw"); 
  //textFont(font, 24);
  //delay(500);
}

