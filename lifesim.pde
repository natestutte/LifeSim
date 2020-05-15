//lifesim (MAIN PROGRAM)

//Variable Declaration
ArrayList<Creature> livecreatures = new ArrayList<Creature>();

//Variable Initialization
float friction   = 0.3;
boolean dragmode = false;

void setup() {
  //Set size of window to 2/3 relative to display size
  //windowsize is the size of the window (duh)
  size(displayWidth, displayHeight);
  int[] windowsize = {2*displayWidth/3, 2*displayHeight/3};
  surface.setSize(windowsize[0], windowsize[1]);
  
  for (int a = 0;a < 50;a++) {
    livecreatures.add(new Creature(windowsize[0]/2, windowsize[1]/2));
  }
}

void draw() {
  //Draw loop
  background(200);
  
  //Update livecreatures
  for (Creature c : livecreatures) {
    c.update();
  }
  
  //Draw livecreatures
  push();
  for (Creature c : livecreatures) {
    c.drawCreature();
  }
  pop();
}

void mousePressed() {
  dragmode = true;
}

void mouseReleased() {
  dragmode = false;
}
