class Smoothing {

  ArrayList smoothing;
  ArrayList smoothingSound;

  // constructor
  Smoothing() {
    smoothing = new ArrayList();
    //initialize arraylist with #nr of sensor readings
    for (int i = 0; i < 10; i++ ) {
      smoothing.add(0.0);
    }

    smoothingSound = new ArrayList();
    //initialize arraylist with #nr of sensor readings
    for (int i = 0; i < 10; i++ ) {
      smoothingSound.add(0.0);
    }
  }
  //methods
  /**runing average smoothing value
   For more info: http://www.fxwords.com/images/words/simiple-moving-average-example.jpg
   */
  float smoothedValuesSound(float toBeSmoothed) {
    float smoothedValue = 0;
    // remove last value
    smoothingSound.remove(0);
   // println("ammountOfSmoothing = "+ammountOfSmoothingSound);

    // if ammount of smoothing is smaller remove as many values as needed
    if (ammountOfSmoothingSound < smoothingSound.size()) {

      int smoothingValuesToRemove = smoothingSound.size() - ammountOfSmoothingSound;
      for (int i = 0 ; i < smoothingValuesToRemove; i++) {
        if (i < smoothingSound.size()) {
          smoothingSound.remove(i);
        }
      }
      //println("decreased smoothing to "+smoothing.size());
    }

    // add the newest reading
    smoothingSound.add(toBeSmoothed);
    // if ammount of smoothing is bigger add as many values as needed
    if (ammountOfSmoothingSound > smoothingSound.size()) {
      int smoothingValuesToAdd = ammountOfSmoothingSound - smoothingSound.size();
      for (int i = 0 ; i < smoothingValuesToAdd; i++) {
        smoothingSound.add(toBeSmoothed);
      }
      //println("increased smoothing to "+smoothing.size());
    }
    // calculate the average of the new arraylist
    for (int i = 0; i < smoothingSound.size();i++) {
      smoothedValue = smoothedValue + (Float) smoothingSound.get(i);
    }
    smoothedValue = smoothedValue / smoothingSound.size();
    // Return the smoothed value
    return smoothedValue;
  }
  // OTHER SMOOTHINGS ---------------------------------------------------------------------------------------------------------------
  float smoothedValues(float toBeSmoothed, int ammountOfSmoothingFunction) {
    float smoothedValue = 0;
    // remove last value
    smoothing.remove(0);


    // if ammount of smoothing is smaller remove as many values as needed
    if (ammountOfSmoothingFunction < smoothing.size()) {
      //println("ammountOfSmoothing = "+ammountOfSmoothing);
      int smoothingValuesToRemove = smoothing.size() - ammountOfSmoothingFunction;
      for (int i = 0 ; i < smoothingValuesToRemove; i++) {
        if ( i < smoothing.size()) {
          smoothing.remove(i);
        }
      }
      //println("decreased smoothing to "+smoothing.size());
    }

    // add the newest reading
    smoothing.add(toBeSmoothed);
    // if ammount of smoothing is bigger add as many values as needed
    if (ammountOfSmoothing > smoothing.size()) {
      int smoothingValuesToAdd = ammountOfSmoothingFunction - smoothing.size();
      for (int i = 0 ; i < smoothingValuesToAdd; i++) {
        smoothing.add(toBeSmoothed);
      }
      //println("increased smoothing to "+smoothing.size());
    }

    // calculate the average of the new arraylist
    for (int i = 0; i < smoothing.size();i++) {
      smoothedValue = smoothedValue + (Float) smoothing.get(i);
    }
    smoothedValue = smoothedValue / smoothing.size();
    // Return the smoothed value
    return smoothedValue;
  }
  
 
}

