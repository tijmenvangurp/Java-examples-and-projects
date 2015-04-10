
import processing.opengl.*;
import oscP5.*;
import ddf.minim.*;
import fullscreen.*;
Minim minim;
AudioInput in;
FullScreen fs; 
OscP5 oscP5;

boolean test =false;
int timer;
float microphone;
float r;
float g;
float b;
float xrot = 0;
float zrot = 0;
float slider;
float xrot_targ = 0;
float zrot_targ = 0;

float orientation = 0;

float dampSpeed = 5;
int numBalls = 12;
float spring = 0.05;
float gravity = 0.03;
float friction = -0.9;


boolean sliderNeedsRedraw = true;
float [] fader = new float [6];



Ball[] balls = new Ball[numBalls];

void setup() {
  size(960, 450);
  oscP5 = new OscP5(this, 8000);
  smooth();
  noStroke();
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 256);

   // fs = new FullScreen(this);
   //fs.enter();
  for (int i = 0; i < numBalls; i++) {
    balls[i] = new Ball(random(width), random(height), random(5, 100), i, balls);
  }
}


void draw() {


 for (int i=0; i<256;i++) {
   

    float microphone=abs(in.left.get(i)*1000);
    if (microphone > 600) {
       test = true;
      //println("hiep hoi");
    }
  }
 // print(test);
  if (test == true){
     r = random(30,255);
      g = random(30,255);
       b = random(30,255);
  test = false;
  }

 timer ++;
 //println(timer);
if (timer == 100){
background(0);
timer =0;
}
   
  /* camera(  0, 0, 300,
   0, 0, 0,
   0.0, 1.0, 0.0
   );*/

  background(0); 
  for (int i = 0; i < numBalls; i++) {
    balls[i].collide();
    balls[i].move();
    balls[i].display();
  }

  // Basic value smoothing
}

void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/accxyz")==true) {
    xrot_targ = (theOscMessage.get(0).floatValue());
    //println(xrot_targ);
    zrot_targ = (theOscMessage.get(1).floatValue());
    orientation = theOscMessage.get(2).floatValue();
  }
  String addr = theOscMessage.addrPattern();
    if(addr.indexOf("/1") !=-1){
    sliderNeedsRedraw = true;
   }
   
   if(addr.indexOf("/1/fader") !=-1){ // one of the faders
       String list[] = split(addr,'/');
     int  xfader = int(list[2].charAt(5) - 0x30);
    // println(xfader);
     fader[xfader]  = theOscMessage.get(0).floatValue();
     slider = theOscMessage.get(0).floatValue();
     
    //println(" x = "+fader[xfader]);  // uncomment to see x values
    sliderNeedsRedraw = true;
    slider = slider *10;
    int slider2 = round(slider);
    println(slider2);
   
    }

}
class Ball {
  float x, y;
  float diameter;
  float vx = 0;// vector x  
  float vy = 0;// vector y
  int id;
  Ball[] others;
  //balls[i] = new Ball(width, height, diameter, id uniek voor iedere bal, de aray balls);
  Ball(float xin, float yin, float din, int idin, Ball[] oin) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
  } 

  void collide() {
    for (int i = id + 1; i < numBalls; i++) {
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist) { 
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * spring;
        float ay = (targetY - others[i].y) * spring;
        vx -= ax;
        vy -= ay;
        others[i].vx += ax;
        others[i].vy += ay;
      }
    }
  }


  void move() {
    float gravityy = xrot_targ ;
    vy += gravityy;
    float gravityx = zrot_targ ;
    vx += gravityx;
    // println("vy:");
    // println(vy);
    // println("vx:");
    //  println(vx);
    y += vy;
    x += vx;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction;
    }
    else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > height) {
      y = height - diameter/2;
      vy *= friction;
    } 
    else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
    }
  }

  void display() {
    fill(r, g, b);
    //println(y);

    ellipse(x, y, diameter, diameter);
  }
}
