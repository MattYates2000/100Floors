class BoostBar {
    float sizeX;
    float sizeY;

    BoostBar() {
        sizeX = 50;
        sizeY = 10;
    }

    void display() {
         rect(PlayerX-50,PlayerY+50,sizeX,sizeY);
    }
    


    void drainBar(){
        sizeX = 0;
    }
    void fillBar() {
        sizeX = 50;
    }

}