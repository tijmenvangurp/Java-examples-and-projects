class XYacceleration {
  ArrayList xValues;
  ArrayList yValues;
  ArrayList timeStamps;

  int xyCompareSize = 10;
  boolean boolean_movementX;
  boolean boolean_movementY;
  
  // constructor
  XYacceleration() {

    xValues = new ArrayList();
    yValues = new ArrayList();
    timeStamps = new ArrayList();

    for (int i = 0; i < xyCompareSize; i++) {
      xValues.add(0.0);
      yValues.add(0.0);
      timeStamps.add(millis());
    }
    
  }
  //methods

  // function that returns if the plaform is moving or not depending on a minimum movement that is adjustable
 
  float xAcceleration() {
     xValues.remove(0);
     xValues.add(xRotationSmooth);
     timeStamps.remove(0);
     timeStamps.add(millis());
     float oldX = (Float) xValues.get(0);
     float newX = (Float) xValues.get(xValues.size()-1);
     int oldTime = (Integer) timeStamps.get(0);
     int newTime = (Integer) timeStamps.get(timeStamps.size()-1);
    int dt = newTime-oldTime;
   // println("dt = "+dt);
    float acceleration = (newX-oldX)/(newTime-oldTime);
    return acceleration;
  }
  
  float yAcceleration() {
     yValues.remove(0);
     yValues.add(yRotationSmooth);
     timeStamps.remove(0);
     timeStamps.add(millis());
     float oldY = (Float) yValues.get(0);
     float newY = (Float) yValues.get(yValues.size()-1);
     int oldTime = (Integer) timeStamps.get(0);
     int newTime = (Integer) timeStamps.get(timeStamps.size()-1);
    int dt = newTime-oldTime;
   // println("dt = "+dt);
    float acceleration = (newY-oldY)/(newTime-oldTime);
    return acceleration;
  }

}

