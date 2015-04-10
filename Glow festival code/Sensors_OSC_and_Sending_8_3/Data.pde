///////////////////////////
// DATA CLASS

class  Data {
  ArrayList  datalist;
  String  filename, data[];
  int  datalineId;

  // begin data saving
  void  beginSave() {
    datalist = new  ArrayList ();
  }

  void  add (String  s) {
    datalist.add (s);
  }

  void  add (float  val) {
    datalist.add (""+val);
  }

  void  add (int  val) {
    datalist.add (""+val);
  }

  void  add (boolean  val) {
    datalist.add (""+val);
  }

  void  endSave(String  _filename) {
    filename=_filename;

    data=new  String [datalist.size ()];
    data=(String  [])datalist.toArray(data);

    saveStrings (filename, data);
   // println ("Saved data to '"+filename+"', "+data.length +" lines.");
  }
  
  float readFloatIndex(int index){
    // als die hier stopt heb je waarschijnlijk niet genoeg regels in je textDocument of een fout waardoor die een lege regel probeert op te halen
   return  float (data[index]);
  
  }

  void  load(String  _filename) {
    filename=_filename;

    datalineId=0;
    data=loadStrings (filename);
    for (int i = 0; i < data.length; i++) {
    }
   // println ("Loaded data from '"+filename+"', "+data.length +" lines.");
  }

  float  readFloat() {
    return  float (data[datalineId++]);
  }

  int  readInt() {
    return  int (data[datalineId++]);
  }

  boolean  readBoolean() {
    return  boolean (data[datalineId++]);
  }

  String  readString() {
    return  data[datalineId++];
  }

  // Utility function to auto-increment filenames
  // based on filename templates like "name-###.txt" 
}





