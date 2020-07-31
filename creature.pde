//Creature class

class Creature {
  
  //Genetic Variables - maxspd, internalclockrate, radius, 
  
  private PVector pos;
  private int radius, sightrange;
  private int hunger, maxhunger;
  private float dir, spd, maxspd;
  private float internalclock, internalclockrate;

  //Class Constructor(s)
  //May delete overloading constructors if they are unused
  
  public Creature(int posx, int posy, float dir, float spd, int radius, int sightrange) {
    this.pos = new PVector(posx, posy);
    this.radius       = radius;
    this.dir          = dir;
    this.spd          = spd;
    this.sightrange   = sightrange;

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
    this.sightrange   = 500;

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
    this.sightrange   = 500;

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

  public int getsightrange() {
    return sightrange;
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

  public void setsightrange(int sr) {
    sightrange = sr;
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
    if (sighttoggle) {
      fill(0, 20);
      strokeWeight(0);
      circle (pos.x, pos.y, sightrange);
      strokeWeight(1);
    }
  }
  
  public void update() {
    //Check hunger, if below 0 kill creature
    if (hunger < 0) {
      this.deathcall();
    }

    //Consuming food
    ArrayList<Food> currentfood = (ArrayList)worldfood.clone();
    for (Food f : currentfood) {
      if (PVector.dist(f.getpos(), pos) < ((radius / 2) + (f.size / 2))) {
        hunger += f.size;
        f.removefood();
        spawnfood(1);
      }
    }

    //Updates internalclock and adds speed if over a certain threshold
    internalclock += internalclockrate;
    if (internalclock > 100 && spd == 0) {
      internalclock = 0;
      hunger--;
      //Find closest object
      PVector closestobject = new PVector();
      float closestobjectdist = -1.0;
      for (Food f : worldfood) {
        if ((closestobjectdist == -1.0 || closestobjectdist > PVector.dist(f.getpos(), pos)) && PVector.dist(f.getpos(), pos) < sightrange / 2) {
          closestobject = f.getpos();
          closestobjectdist = PVector.dist(f.getpos(), pos);
        }
      }
      if (closestobject.mag() == 0.0) {
        dir = radians(random(0, 360));
      } else {
        dir = -atan2(pos.y - closestobject.y, closestobject.x - pos.x);
      }
      spd += maxspd;
    }
    
    //Applies friction to speed and disallows speed from being below 0.0
    if (spd >= friction) {
      spd -= friction;
    }
    else {
      spd = 0.0;
    }
    
    if (hunger > maxhunger) {
      hunger = maxhunger;
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
    //Checks if creature is equal to given creature
    if (this == c) {
      return true;
    }
    return false;
  }

  public void deathcall() {
    //Removes creature from livecreature arraylist
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
