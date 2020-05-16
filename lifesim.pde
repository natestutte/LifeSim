//lifesim (MAIN PROGRAM)

//Variable Declaration
int scrolldir;
int[] neworigincoords    = new int[2];
int[] coordsdisplacement = new int[2];
int[] windowsize         = new int[2];
ArrayList<Creature> livecreatures = new ArrayList<Creature>();

PFont font_trebuchetms;

//Variable Initialization
boolean dragmode         = false;
float friction           = 0.3;
float camerazoom         = 1.0;
int[] origincoords       = {0, 0};

void setup() {
  //Set size of window to 2/3 relative to display size
  //windowsize is the size of the window (duh)
  size(displayWidth, displayHeight);
  windowsize[0] = 2*displayWidth/3;
  windowsize[1] = 2*displayHeight/3;
  surface.setSize(windowsize[0], windowsize[1]);
  
  //Font setup
  font_trebuchetms = createFont("Trebuchet MS", 30, true);
  
  for (int a = 0;a < 50;a++) {
    livecreatures.add(new Creature(windowsize[0]/2, windowsize[1]/2));
  }
}

void draw() {
  //Draw loop
  background(200);
  
  //Check for dragmode
  if (dragmode) {
    coordsdisplacement = dragscreen(mouseX, mouseY, neworigincoords);
  }
  else {
    for (int i = 0 ; i < 2 ; i++) {
      origincoords[i] += coordsdisplacement[i];
      coordsdisplacement[i] = 0;
    }
  }
  
  //Update livecreatures
  for (Creature c : livecreatures) {
    c.update();
  }
  
  //Draw livecreatures
  push();
  translate(windowsize[0] / 2, windowsize[1] / 2);
  scale(camerazoom);
  translate(-windowsize[0] / 2, -windowsize[1] / 2);
  translate(origincoords[0] + coordsdisplacement[0], origincoords[1] + coordsdisplacement[1]);
  //Dev rect pls ignore
  rect((windowsize[0] / 2) - 25, (windowsize[1] / 2) - 25, 50, 50);
  for (Creature c : livecreatures) {
    c.drawCreature();
  }
  pop();
}

void mousePressed() {
  //Checks what mouse button is pressed and reacts accordingly
  if (mouseButton == RIGHT) {
    neworigincoords[0] = mouseX;
    neworigincoords[1] = mouseY;
    dragmode = true;
  }
  else if (mouseButton == LEFT) {
    return ;
  }
}

void mouseReleased() {
  //Checks what mouse button is released and acts accordingly
  if (mouseButton == RIGHT) {
    dragmode = false;
  }
  else if (mouseButton == LEFT) {
    return ;
  }
}

void mouseWheel(MouseEvent event) {
  //Checks what direction mousewheel is scrolled and zooms accordingly
  //Positive when scroll down, negative when scroll up
  scrolldir = event.getCount();
  
  if (scrolldir > 0) {
    if (camerazoom > 0.4) {
      camerazoom -= 0.2;
    }
  }
  else {
    if (camerazoom < 1.6) {
      camerazoom += 0.2;
    }
  }
}

int[] dragscreen(int mousex, int mousey, int[] coords) {
  //Takes in set of coordinates and returns the difference in coordinates divided by the camera zoom
  //(camerazoom is used to scale the drag speed depending on how zoomed in the camera is)
  int[] returncoords = new int[2];
  
  returncoords[0] = int((coords[0] - mousex) / camerazoom);
  returncoords[1] = int((coords[1] - mousey) / camerazoom);
  
  return returncoords;
}
