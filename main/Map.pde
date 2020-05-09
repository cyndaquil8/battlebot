//in the main there is a tiles variable that holds an array of all the tiles we have in the game, you will also see a tilemapguide in the battlebot folder
//generateBaseMap function should have a 2d integer array as parameter
//the corresponding integer from the parameter will access a PImage from the tiles varaiable
//assume this will be your parameter [[0,0,0],[0,1,0],[2,3,2]]
//accessing images from the tiles array to form a map
//row1 will contain: tiles[0], tiles[0], tiles[0]
//row2 will contain: tiles[0], tiles[1], tiles[0]
//row3 will contain: tiles[2], tiles[3], tiles[2]
class Map {
  //variables
  int columnsize;
  int rowsize;
  int x;
  int y;
  int speedx;
  int speedy;
  PImage [][] mapTiles;
  
  public Map() {
    speedx = 0;
    speedy = 0;
  }
  
  void generateBaseMap(int[][] tileArray) {
    int incount1 = 0;
    int incount2 = 0;
    Tile prev = new Tile();
    Tile current;
    /* Tile topleft = new Tile(8, 8, false, false, tiles[tileArray[0][0]]);
    print(tileArray[0][0]);
    prev = topleft; */
    for (int i = 0; i < 3; i++) {
      incount2 = 0;
      if (incount1 == 0) {
        Tile topleft = new Tile(8, 8, false, false, tiles[tileArray[0][0]]);
        print(tileArray[0][0]);
        prev = topleft;
      } else {
        current = new Tile(8, prev.y + 16, false, false, tiles[tileArray[incount1][incount2]]);
        print(tileArray[incount1][incount2]);
        prev = current;
      }
      for (int k = 0; k < 2; k++) {
        incount2++;
        current = new Tile(prev.x + 16, prev.y, false, false, tiles[tileArray[incount1][incount2]]);
        print(tileArray[incount1][incount2]);
        prev = current;
      }
      incount1++;
    }
    
  }
  
  //MAP CREATION v1
  /* void generateMap(int[][] tr) {
    //generate tiles, columns left to right
    int coordx = 1;
    int coordy = 1;
    Tile topleft = new Tile(8, 8, false, false, 1, 1);
    Tile prev = topleft;
    Tile current;
    //row: create new tile to the right once column is down
    for (int i = 0; i < rowsize; i++) {
      //column: new tiles below
      for (int k = 0; k < columnsize; k++) {
        coordy++;
        current = new Tile(prev.x, prev.y + 16, false, false, coordx, coordy);
        prev = current;
      }
      coordx++;
      current = new Tile(prev.x + 16, 8, false, false, coordx, 1);
      prev = current;
    }
  } */
  
  void update() {
    keyPressed();
    keyReleased();
    x += speedx;
    y += speedy;
  }
  
  void keyPressed() {
    if (key == 'w') {
      speedy = -5;
    } else if (key == 'd') {
      speedy = 5;
    } else if (key == 'a') {
      speedx = -5;
    } else if (key == 's') {
      speedx = 5;
    }
  }
  
  void keyReleased() {
    if (key == 'w' || key == 'd') {
      speedy = 0;
    } else if (key == 'a' || key == 's') {
      speedx = 0;
    }
  }
  
}
