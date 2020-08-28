// Food Class

float xoff = 0.0;
float yoff = 0.0;

class Food {

    //Variables

    private PVector pos;
    int size;

    //Class constructor
    //Subject to change

    public Food(int posx, int posy, int size) {
        pos = new PVector(posx, posy);
        this.size = size;
    }

    //Getters/Setters

    public float getposx() {
        return pos.x;
    }

    public float getposy() {
        return pos.y;
    }

    public PVector getpos() {
        return pos;
    }

    public int getsize() {
        return size;
    }

    public void setposx(int posx) {
        pos.x = posx;
    }

    public void setposy(int posy) {
        pos.y = posy;
    }

    public void setpos(PVector pos) {
        this.pos = pos;
    }

    public void setsize(int size) {
        this.size = size;
    }

    //Draw function
    public void drawFood() {
        fill(255, 255, 190);
        circle(pos.x, pos.y, size);
    }

    //Removes food from worldfood
    public void removefood() {
        worldfood.remove(this);
    }

}

//Spawns given num of food
void spawnfood(int numofspawns) {
    for(int a = 0;a < numofspawns;a++)
        worldfood.add(new Food(int(random((windowsize[0] / 2) - ((borderlengthfood - 25) / 2), (windowsize[0] / 2) + ((borderlengthfood + 25) / 2))), 
            int(random((windowsize[1] / 2) - ((borderlengthfood - 25) / 2), (windowsize[1] / 2) + ((borderlengthfood + 25) / 2))), 
            int(random(20, 30))));
}

//Removes all food from world
void removeallfood() {
    worldfood.clear();
}