//Creature class

class Creature {
  
  //Genetic Variables - maxspd, internalclockrate
  
  private int xpos, ypos;
  private float dir, spd, maxspd;
  private float internalclock, internalclockrate;
  
  //Class Constructor(s)
  //May delete overloading constructors if they are unused
  
  public Creature(int xpos, int ypos, float dir, float spd) {
    this.xpos         = xpos;
    this.ypos         = ypos;
    this.dir          = dir;
    this.spd          = spd;
    internalclock     = 0.0;
    
    internalclockrate = random(5)+1;
    maxspd            = random(6)+6;
  }
  
  public Creature(int xpos, int ypos) {
    this.xpos         = xpos;
    this.ypos         = ypos;
    dir = spd         = 0.0;
    internalclock     = 0.0;
    
    internalclockrate = random(5)+1;
    maxspd            = random(6)+6;
  }
  
  public Creature() {
    xpos = ypos       = 0;
    dir = spd         = 0.0;
    internalclock     = 0.0;
    
    internalclockrate = random(5)+1;
    maxspd            = random(6)+6;
  }
  
  //Getters and Setters
  
  public int getxpos() {
    return xpos;
  }
  
  public int getypos() {
    return ypos;
  }
  
  public int[] getpos() {
    final int[] pos = {xpos, ypos};
    return pos;
  }
  
  public float getdir() {
    return dir;
  }
  
  public float getspd() {
    return spd;
  }
  
  public void setxpos(int xpos) {
    this.xpos = xpos;
  }
  
  public void setypos(int ypos) {
    this.ypos = ypos;
  }
  
  public void setpos(int[] pos) {
    this.xpos = pos[0];
    this.ypos = pos[1];
  }
  
  public void setdir(float dir) {
    this.dir = dir;
  }
  
  public void setspd(float spd) {
    this.spd = spd;
  }
  
  //Class methods
  
  public void drawCreature() {
    //Draws creatures as circles (temp)
    
    circle(xpos, ypos, 50);
  }
  
  public void update() {
    //Updates internalclock and adds speed if over a certain threshold
    internalclock += internalclockrate;
    if (internalclock > 100 && spd == 0) {
      internalclock = 0.0;
      dir = radians(random(360));
      spd += maxspd;
    }
    
    //Applies friction to speed and disallows speed from being below 0.0
    if (spd >= friction) {
      spd -= friction;
    }
    else {
      spd = 0.0;
    }
    
    //Movement function
    this.move();
  }
  
  public void move() {
    //Moves creature depending on direction and speed
    if (spd != 0) {
      xpos += int(cos(dir) * spd);
      ypos += int(sin(dir) * spd);
    }
  }
}
