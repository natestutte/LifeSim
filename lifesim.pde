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
boolean linetoggle       = true;
float friction           = 0.3;
float camerazoom         = 1.0;
int[] origincoords       = {0, 0};

void setup() {
  frameRate(60);

  //Set size of window to 2/3 relative to display size
  //windowsize is the size of the window (duh)
  size(displayWidth, displayHeight);
  windowsize[0] = 2*displayWidth/3;
  windowsize[1] = 2*displayHeight/3;
  surface.setSize(windowsize[0], windowsize[1]);
  
  //Font setup
  font_trebuchetms = createFont("Trebuchet MS", 30, true);
  
  //Spawn initial creatures
  spawncreatures(200);
}

void draw() {
  //Draw loop
  background(200);
  
  //Check for dragmode
  if (dragmode) {
    coordsdisplacement = dragdifference(mouseX, mouseY, neworigincoords);
  }
  else {
    for (int i = 0 ; i < 2 ; i++) {
      origincoords[i] += coordsdisplacement[i];
      coordsdisplacement[i] = 0;
    }
  }
  
  //Update livecreatures
  ArrayList<Creature> tempcreatures = (ArrayList)livecreatures.clone();
  for (Creature c : tempcreatures) {
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
  
  textSize(16);
  text(frameRate, 10, 20);
  text(livecreatures.size(), 10, 40);
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

void keyPressed() {
  //actions when keys are pressed down
  
  //ctrl+r
  if (key == '') {
    for (int i = 0 ; i < 2 ; i++) {
      origincoords[i] = 0;
      coordsdisplacement[i] = 0;
    }
    snapallcreatures();
    spawncreatures(200);
  }
  //r
  if (key == 'r') {
    for (int i = 0 ; i < 2 ; i++) {
      origincoords[i] = 0;
      coordsdisplacement[i] = 0;
    }
  }
  //l
  if (key == 'l') {
    linetoggle = !linetoggle;
  }
}
