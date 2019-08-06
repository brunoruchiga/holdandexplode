//Config
float percentOfRigidWalls = 0.2;
int numberOfEnemies = 2;

//////
float em; //tamanho do módulo
Canvas canvas; //área do app
PlayArea playArea; //área do jogo
Camera camera;
Time time;
int currentScreen;
PFont font, fontBig, fontSmall;
boolean mouseReleased;

Player p;
Enemy[] enemies = new Enemy[numberOfEnemies];
Bomb b;
Path path;
Wall[] walls = new Wall[100];

float deathWallY; 
float deathWallVelY;

float explosionAnimationTimer = 0;

Game game;

void setup() {
  //size(360, 640);
  fullScreen();
  orientation(PORTRAIT);
  canvas = new Canvas(9/16.0); //ratio of canvas 16:9
  em = canvas.w/20; //size of modulo
  playArea = new PlayArea(9/16.0, em/2);
  time = new Time();
  camera = new Camera(playArea.w/2, playArea.h/2);
  currentScreen = 1;

  font = createFont("Roboto-Bold.ttf", em);
  fontBig = createFont("Roboto-Bold.ttf", 5*em);
  fontSmall = createFont("Roboto-Bold.ttf", em*2/3);

  game = new Game();
}

void draw() {
  //scale(0.5); //debug resize

  if (currentScreen == 0) {
    background(0);
    fill(255);
    textAlign(CENTER, CENTER);
    textFont(fontBig);
    textLeading(5*em);
    text("HOLD AND\nEXPLODE", width/2, height/2);
    
    if(mouseReleased) {
      currentScreen = 1;
    }
  }

  if (currentScreen == 1) {
    time.update();

    game.update();
    game.display();
  }
  
  mouseReleased = false;
}
