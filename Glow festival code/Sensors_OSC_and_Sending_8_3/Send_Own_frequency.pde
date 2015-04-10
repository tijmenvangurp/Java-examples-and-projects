void sendWave(String name, float xWave, float yWave) {
  
  myMessage.setAddrPattern(name);
  myMessage.add(new Object[] { 
    new Float(xWave), new Float((yWave))
  }
  );
  sendToMacMinis(myMessage);
  myMessage.clear();
}

