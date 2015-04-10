int size = 60;
float xpos, ypos;

float t = 0;
float xspeed = 0;
float yspeed = 0;
float xacc = 0;
float yacc = 0;
float dt = 0.1;
float friction = 20;
int minspeed = 40;

float xMax = 0;


void setup()
{
  size(640, 400);
  noStroke();
  frameRate(30);
  smooth();
  xpos = width/4;
  ypos = height/2;
}

void draw() 
{
  background(102);

  // Update the position of the shape
  xpos = xpos + xspeed * dt + xacc * dt * dt;
  xspeed = xspeed + xacc * dt;
  xacc = (mouseX - xpos)/dt;

  ypos = ypos + yspeed * dt + yacc * dt * dt;
  yspeed = yspeed + yacc * dt;
  yacc = (mouseY - ypos)/dt;

  if (xspeed > xMax) {
    xMax = xspeed;
  }
  
 // println("mousseX - xpos = "+(1/abs((mouseX - xpos)))*500);
 
 println("acc= "+xacc);
  
 // friction = (1/abs((mouseX - xpos)))*500;

  if (xspeed > 0 && xspeed > minspeed ) {
    xspeed = xspeed - friction;
  }
  if (xspeed < 0 && xspeed < minspeed*-1) {
    xspeed= xspeed + friction;
  }

  if (yspeed > 0 && yspeed > minspeed ) {
    yspeed = yspeed - friction;
  }
  if (yspeed < 0 && yspeed < minspeed*-1 ) {
    yspeed = yspeed + friction;
  }
  // println(xspeed);

  if (mousePressed == true) {
    xacc = 0;
    xspeed = 0;
    yacc = 0;
    yspeed = 0;
  }
  // Draw the shape
  ellipse(xpos+size/2, ypos+size/2, size, size);
}

