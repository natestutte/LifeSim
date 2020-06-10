//Creature class

class Creature {
  
  //Genetic Variables - maxspd, internalclockrate, radius, 
  
  private PVector pos;
  private int radius;
  private int hunger, maxhunger;
  private float dir, spd, maxspd;
  private float internalclock, internalclockrate;

  //Class Constructor(s)
  //May delete overloading constructors if they are unused
  
  public Creature(int posx, int posy, float dir, float spd, int radius) {
    this.pos = new PVector(posx, posy);
    this.radius       = radius;
    this.dir          = dir;
    this.spd          = spd;

    internalclock     = 0.0;
    internalclockrate = random(5)+1;
    maxspd            = random(12)+4;

    maxhunger         = 50;
    hunger            = maxhunger;
  }
  
  public Creature(int posx, int posy, int radius) {
    this.pos = new PVector(posx, posy);
    this.radius       = radius;
    dir = spd         = 0.0;

    internalclock     = 0.0;
    internalclockrate = random(5)+1;
    maxspd            = random(12)+4;
    
    maxhunger         = 50;
    hunger            = maxhunger;
  }
  
  public Creature() {
    this.pos = new PVector(0, 0);
    radius            = 50;
    dir = spd         = 0.0;

    internalclock     = 0.0;
    internalclockrate = random(5)+1;
    maxspd            = random(12)+4;

    maxhunger         = 50;
    hunger            = maxhunger;
  }
  
  //Getters and Setters
  
  public float getposx() {
    return pos.x;
  }
  
  public float getposy() {
    return pos.y;
  }
  
  public PVector getpos() {
    return pos;
  }
  
  public int getradius() {
    return radius;
  }
  
  public float getdir() {
    return dir;
  }
  
  public float getspd() {
    return spd;
  }
  
  public void setposx(int posx) {
    pos.x = posx;
  }
  
  public void setposy(int posy) {
    pos.y = posy;
  }
  
  public void setpos(PVector newpos) {
    pos = newpos;
  }
  
  public void setradius(int radius) {
    this.radius = radius;
  }
  
  public void setdir(float dir) {
    this.dir = dir;
  }
  
  public void setspd(float spd) {
    this.spd = spd;
  }
  
  //Class methods
  
  public void drawCreature() {
    //Draws creatures as circles
    int rate = 200 / maxhunger;
    fill((hunger * rate) + 55);
    circle(pos.x, pos.y, radius);
    if (linetoggle) {
      strokeWeight((log(spd + exp(1)))*.75);
      stroke(255 - ((hunger * rate) + 55));
      line(pos.x, pos.y, pos.x + (cos(dir) * 8 * spd), pos.y + (sin(dir) * 8 * spd));
      strokeWeight(1);
    }
  }
  
  public void update() {
    //Check hunger, if below 0 kill creature
    if (hunger < 0) {
      this.deathcall();
    }

    //Updates internalclock and adds speed if over a certain threshold
    internalclock += internalclockrate;
    if (internalclock > 100 && spd == 0) {
      internalclock = 0;
      hunger--;
      //Find closest creature
      PVector closestcreaturepos = new PVector();
      float closestcreaturedist = -1.0;
      for (Creature c : livecreatures) {
        if (!this.isequalto(c)) {
          if (closestcreaturedist == -1.0 || closestcreaturedist > PVector.dist(c.getpos(), pos)) {
            closestcreaturepos = c.getpos();
            closestcreaturedist = PVector.dist(c.getpos(), pos);
          }
        }
      }
      
      dir = -atan2(pos.y - closestcreaturepos.y, closestcreaturepos.x - pos.x);
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
      pos.x += int(cos(dir) * spd);
      pos.y += int(sin(dir) * spd);
    }
  }
  
  public boolean isequalto(Creature c) {
    if (this == c) {
      return true;
    }
    return false;
  }

  public void deathcall() {
    livecreatures.remove(this);
  }
}

//Common creature methods

void spawncreatures(int numofspawns) {
  //Spawns creatures in area given by windowsize
  for (int a = 0;a < numofspawns;a++) {
    livecreatures.add(new Creature(int(random(windowsize[0])), int(random(windowsize[1])), 50));
  }
}

void snapallcreatures() {
  //Clears all creatures from population
  livecreatures.clear();
}

void createchild(Creature c1, Creature c2) {
  //Creates child creature with random genes from given creatures (IN PROGRESS)
  return ;
}
