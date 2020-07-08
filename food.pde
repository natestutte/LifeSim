// Food Class

class Food {

    private PVector pos;
    int size;

    public Food(int posx, int posy, int size) {
        pos = new PVector(posx, posy);
        this.size = size;
    }

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

    public void drawFood() {
        fill(255, 255, 190);
        circle(pos.x, pos.y, size);
    }

}

void spawnfood(int numofspawns) {
    for(int a = 0;a < numofspawns;a++)
        worldfood.add(new Food(int(random(windowsize[0])), int(random(windowsize[1])), int(random(10, 20))));
}