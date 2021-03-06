import java.util.*;
import java.io.File;
import java.util.concurrent.TimeUnit;


//all the collidable sprites on the spritesheet
int[] collidableSprites = new int[]{189,190,191,192,193,194,195,196,216,217,218,219,220,221,222,223,232,237,238,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,270,271,272,273,274,275,276,278,279,280,286,287,288,289,290,291,292,297,298,299,300,301,302,303,304,305,306,307,327,328,329,330,331,332,333,334,335,336,337,338,340,341,342,344,345,346,354,355,356,357,358,359,360,361,362,363,364,365,367,368,369,370,371,372,373,381,382,383,384,385,386,387,388,389,390,391,392,395,414,415,416,417,418,419,420,421,422,423,424,425,426,427,443,444,445,446,453,454,470,471,472,473,474,475,476,477,478,479,480,481};
int[] portalSprites = new int[]{281,282,283,284,285,339,412,413};
int[] grassSprites = new int[]{0,1,2,3,4,5,6,7,27,28,29,30,31,32,33,34,54,55,56,57,58,59,60,61};

HashMap<String,PImage> spritesHm = new HashMap<String,PImage>(); // sprites hashmap
PImage[] tiles;



SpriteSheet TPlayerStand;

SpriteSheet SSAirA;
SpriteSheet SSBeardA;


//Timer animationTimer;
Timer restartTimer;

OverlayMap overlay = new OverlayMap();
Map map = new Map(overlay);

Player testPlayer;

//boolean lock = false;

enum GameStates{
  WALKING,
  COMBAT,
  MENU
}
GameStates currentState = GameStates.WALKING;



void setup(){
  
  
  //Ethan's code
  //acquire the folder location of where the monster images are
  String spritePath = sketchPath().substring(0, sketchPath().length()-4) + "images";
  File sprites = new File(spritePath);
  //opens up the folder that contains the monster images
  //creates a list of file names from the folder of monster images
  String[] spriteList = sprites.list();
  //temporary variable that holds the image that is loaded from the monster file
  PImage spritesPM; //sprites PImage
  
  for(int i = 0; i < spriteList.length; i++){
    //after loading each image from the monster folder place it into a hashmap containing name of monster and image
    spritesPM = loadImage(spritePath + "/" + spriteList[i]);
    spritesHm.put(spriteList[i].substring(0, spriteList[i].length()-4), spritesPM);
    //System.out.println(spriteList[i].substring(0, spriteList[i].length()-4));
  }
  
  String tilesPath = spritePath.substring(0, spritePath.length()-6) + "Tiles";
  File tilesFile = new File(tilesPath);
  
  String[] tilesList = tilesFile.list();
  tiles = new PImage[tilesList.length]; //tiles PImage
  
  for(int i = 0; i < tilesList.length; i++){
    tiles[i] = loadImage(tilesPath + "/" + tilesList[i]);
  }
  
  testPlayer = new Player(createCharacterSprites(0));

  //map trash
  int[][] tileArr = {
    {89,  90,  90,  90,  90,  90,  90,  90,  90,  90,  91,  461,  441,  463,  89,  90,  90,  90,  90,  90,  90,  90,  90,  90,  91},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {143,  144,  144,  144,  144,  144,  144,  144,  144,  144,  145,  461,  441,  463,  143,  144,  144,  144,  144,  144,  144,  144,  144,  144,  145},
    {406,  406,  406,  406,  406,  406,  406,  406,  406,  406,  406,  467,  441,  466,  406,  406,  406,  406,  406,  406,  406,  406,  406,  406,  406},
    {441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441,  441},
    {460,  460,  460,  460,  460,  460,  460,  460,  460,  460,  460,  440,  441,  439,  460,  460,  460,  460,  460,  460,  460,  460,  460,  460,  460},
    {89,  90,  90,  90,  90,  90,  90,  90,  90,  90,  91,  461,  441,  463,  89,  90,  90,  90,  90,  90,  90,  90,  90,  90,  91},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118,  461,  441,  463,  116,  117,  117,  117,  117,  117,  117,  117,  117,  117,  118},
    {143,  144,  144,  144,  144,  144,  144,  144,  144,  144,  145,  461,  441,  463,  143,  144,  144,  144,  144,  144,  144,  144,  144,  144,  145}
  };
  
  map.generateBaseMap(tileArr);
  
  int[][] secondLayer = {
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  0,  1,  1,  1,  1,  1,  1,  1,  1,  1,  2},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  28,  28,  28,  170,  171,  172,  29},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  28,  28,  28,  197,  198,  199,  29},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  28,  28,  28,  224,  225,  226,  29},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  232,  28,  28,  28,  28,  28,  29},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  395,  27,  28,  28,  28,  259,  28,  28,  28,  28,  28,  29},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  422,  27,  28,  28,  28,  28,  28,  28,  28,  28,  28,  29},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  27,  28,  28,  28,  28,  28,  28,  28,  28,  28,  29},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  54,  55,  55,  55,  55,  55,  55,  55,  55,  55,  56},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486},
    {486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486,  486}
  };
  
  overlay.generateBaseMap(secondLayer);
  
  TPlayerStand = new SpriteSheet(Arrays.copyOfRange(tiles, 23, 27), 500);

  
  //animationTimer = new Timer(500);
  restartTimer = new Timer(5000);
  
  SSAirA = new SpriteSheet(spritesHm.get("AirA"), 500);
  SSBeardA = new SpriteSheet(spritesHm.get("BeardA"), 500);
  
    size(1100,800);
    
  
}

void draw(){
  background(0);
  
  
  
  if (currentState == GameStates.WALKING) {
    map.update();
    overlay.update();
    testPlayer.display();


  } else if (currentState == GameStates.COMBAT) {
    
    
  } else if (currentState == GameStates.MENU) {
    //map.draw();
    testPlayer.display();
  }
  


  ///* -- test display code -- remove in the future 
  if(SSAirA.animationTimer.countDownUntil(SSAirA.stoploop)){
      SSAirA.changeDisplay(true, -1, 9);   
      //SSAirA.changeDisplay();
  }
  
  //SSAirA.display(80,80);
  
  if(SSAirA.stoploop){
    SSAirA.restart();
    System.out.println("restarted");
  }
  
  testPlayer.display();
  
  
  
  
  //*/
  
  
  
}

public void changeGameState(GameStates state){
  currentState = state;
}

public void generateTileMapGuide(){
  int i = 0;
  for(int row = 0; row < 18; row++){
    for(int col=0;col<27; col++){
      image(tiles[i], col * 32 + col + 100, row * 32 + row+100, 32,32);
      
      textSize(16);
      text(i,col * 32+col+100, row * 32 + 20+row+100);
      i++;
    }
  }
}
