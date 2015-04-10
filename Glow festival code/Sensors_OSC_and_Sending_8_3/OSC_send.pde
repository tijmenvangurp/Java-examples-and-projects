void sendToMacMinis (OscPacket messageToSend) {
  //oscP5.send(messageToSend, remoteLocation_macMiniTwo);
  oscP5.send(messageToSend, remoteLocation_macMiniOne);
 // oscP5.send(messageToSend, remoteLocation_macMiniThree);
 // oscP5.send(messageToSend, remoteLocation_thom);
}

void sendSound (OscPacket messageToSend) {
  oscP5.send(messageToSend, remoteLocation_soundPC);
}
