class Game {
  int gameOver = 0;
  float gameOverTimer = 0;
  boolean playing = true;
  float timer;

  Game() {
    reset();
  }

  void reset() {
    gameOver = 0;
    p = new Player(playArea.w/2, playArea.h/2);
    for (int i = 0; i < enemies.length; i++) {
      enemies[i] = new Enemy(random(-playArea.w, playArea.w*2), random(-playArea.h*0.1));
    }
    b = new Bomb(p.pos, false);
    path = new Path();
    for (int i = 0; i < walls.length; i++) {
      //walls[i] = new Wall(playArea.w/2 - em/2 + round(random(-25, 25))*em, playArea.h/2 - em/2 + round(random(0, 100))*em, em, em, 0);
      walls[i] = new Wall(round(random(-20, 40)), round(random(20, 60)), 0);
      if (random(1) < percentOfRigidWalls) {
        walls[i].type = 1;
      }
    }

    //borderWallLeft = new Wall(-playArea.w - width, -playArea.h, width, playArea.h*100, 1);
    //borderWallRight = new Wall(playArea.w*2, -playArea.h, width, playArea.h*100, 1);

    deathWallY = 3*em; 
    deathWallVelY = 0.04*em;
  }

  void update() {
    if (playing) {
      timer += time.delta;
    }

    //Player move
    p.update();

    //Update enemies
    for (int i = 0; i < enemies.length; i++) {
      enemies[i].update();
      //if(enemies[i].pos.y < deathWallY - playArea.h*0.5) {
      //  enemies[i].reset();
      //}
      if (game.gameOver==0 && enemies[i].area.intersects(p.area)) {
        gameOver = 2;
        gameOverTimer = 60*2;
      }
    }

    //Wall collision
    for (int i = 0; i < walls.length; i++) {
      walls[i].intersect(p.pos, p.prevPos, p.area);
      for (int j = 0; j < enemies.length; j++) {
        walls[i].intersect(enemies[j].pos, enemies[j].prevPos, enemies[j].area);
      }
    }
    //borderWallLeft.intersect(p);
    //for (int i = 0; i < enemies.length; i++) {
    //  borderWallLeft.intersect(enemies[i]);
    //}
    //borderWallRight.intersect(p);
    //for (int i = 0; i < enemies.length; i++) {
    //  borderWallRight.intersect(enemies[i]);
    //}
    //Update path
    if (mousePressed) {
      path.addVertex(p.pos.x + p.w/2 - em, p.pos.y + p.h);
    }
    //Update death wall
    if (gameOver==0 && p.pos.y < deathWallY) {
      gameOver = 2;
      gameOverTimer = 60*2;
    }
    deathWallY = deathWallY + deathWallVelY;
    //Update bomb
    b.update();
    if (b.exploded) {
      path.reset();
      for (int i = 0; i < walls.length; i++) {
        if (b.explosionArea.intersects(walls[i].area)) {
          if (walls[i].type == 0) {
            walls[i].active = false;
          }
        }
      }
      for (int i = 0; i < enemies.length; i++) {
        if (b.explosionArea.intersects(enemies[i].area) && b.explosionActive) {
          //enemies[i].active = false;
          enemies[i].reset();
        }
      }
      if (gameOver==0 && b.explosionArea.intersects(p.area) && b.explosionActive) {
        gameOver = 1;
        gameOverTimer = 60*2;
      }
      //b.exploded = false;
      b.explosionActive = false;
    }

    if (mousePressed && !b.exploded) {
      explosionAnimationTimer = 1*60;
    }
    explosionAnimationTimer = explosionAnimationTimer - time.delta;


    if (mouseReleased) {
      if (!b.exploded) {
        b.explode();
      }

      if (game.gameOver>0 && game.gameOverTimer < 0) {
        game.reset();
      }
    }
  }

  void display() {
    background(200);

    canvas.debug();
    canvas.begin();
    {
      //playArea.debug();
      playArea.begin();
      {
        camera.update();
        camera.begin();

        //canvas.grid();

        {

          for (int i = 0; i < walls.length; i++) {
            walls[i].display();
          }
          path.display();

          for (int i = 0; i < enemies.length; i++) {
            enemies[i].display();
            //enemies[i].debug();
          }

          b.display();
          p.display();

          //Death wall
          //fill(0, 255, 0);
          //noStroke();
          noFill();
          stroke(0, 255, 0);
          strokeWeight(3);
          //rect(-playArea.w*1, deathWallY - playArea.h*2, playArea.w*3, playArea.h*2);
          beginShape();
          {
            vertex(-playArea.w*1, deathWallY - playArea.h*2); //point top left
            vertex(-playArea.w*1 + playArea.w*3, deathWallY - playArea.h*2); //point top right 
            vertex(-playArea.w*1 + playArea.w*3, deathWallY - playArea.h*2 + playArea.h*2); //point bottom right
            for (int i = 0; i < 20; i++) {
              float _x = map(i, 0, 20, -playArea.w*1 + playArea.w*3, -playArea.w*1);
              float _y = map(i, 0, 20, deathWallY - playArea.h*2 + playArea.h*2, deathWallY - playArea.h*2 + playArea.h*2);
              float offsetY = noise(i*(time.realFrameCount*0.01))*em;
              vertex(_x, _y + offsetY);
            }
            vertex(-playArea.w*1, deathWallY - playArea.h*2 + playArea.h*2); // point bottom left
          }
          endShape(CLOSE);


          //borderWallLeft.display();
          //borderWallRight.display();

          //p.debug();
        }
        camera.end();
      }
      playArea.end();
    }
    canvas.end();

    if (gameOver > 0) {
      fill(0, 200);
      noStroke();
      rect(0, 0, width, height);

      fill(255);
      textAlign(CENTER, CENTER);
      textFont(font);
      if (gameOverTimer > 0) {
        if (gameOver == 1) {
          text("You exploded yourself", width/2, height/2);
        } else if (gameOver == 2) {
          text("You got infected", width/2, height/2);
        }
      } else {
        text("Try again", width/2, height/2);
      }

      gameOverTimer = gameOverTimer - time.delta;
    }

    if (gameOver>0) {
      fill(0);
      noStroke();
      float gameOverTimerPercent = map(gameOverTimer, 2*60, 0, 0, 1);
      rect(0, 0, gameOverTimerPercent*width, 2*em);
    }
  }
}
