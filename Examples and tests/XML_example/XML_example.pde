//http://www.texone.org/proxml/
import proxml.*;


void setup(){
// create the root element be specific where the class is
proxml.XMLElement file = new proxml.XMLElement("hallo");

// create the color element
proxml.XMLElement col = new proxml.XMLElement("color");

proxml.XMLElement test = new proxml.XMLElement("test");

proxml.XMLElement retrievingdata;

// add some attributes to it.
col.addAttribute("r", random(255));
col.addAttribute("g", random(255));
col.addAttribute("b", random(255));


test.addAttribute("r", random(255));
test.addAttribute("g", random(255));
test.addAttribute("b", random(255));


// make the color element a child of the root element
file.addChild(col);

col.addChild(test);

// create an XMLInOut object to format the elements
XMLInOut xmlInOut =  new XMLInOut(this);

// and call saveElement.
xmlInOut.saveElement(file, "saving_color.xml");



 try{
    xmlInOut.loadElement("ellipse.xml"); 
  }catch(Exception e){
    //if the xml file could not be loaded it has to be created
    xmlEvent(new proxml.XMLElement("hallo"));
  }

}
void xmlEvent(proxml.XMLElement element){
  retrievingdata = element;
  println(element);
 // file = element;
 // initEllipses();
    //initialise PImage for background
//  back = new PImage(width,height);
//  loadPixels();
//  back.pixels = pixels;
}


void draw(){}



