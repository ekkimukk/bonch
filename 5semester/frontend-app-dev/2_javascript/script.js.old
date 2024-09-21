const canvas = document.getElementById("game");
const context = canvas.getContext("2d");

canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

const playerWidth = 115;
const playerHeight = 106;
const player = {
  x: canvas.width / 40,
  y: canvas.height / 2 - playerHeight / 2,
  width: playerWidth,
  height: playerHeight,
  speed: 22,
};

const enemy = {
  width: 116,
  height: 102,
  speed: 4,
};

// Keyboard listener
document.addEventListener("keydown", (event) => {
  if (event.key === "ArrowUp" || event.key === "k") {
    movePlayer("up");
    direction = "up";
  } else if (event.key === "ArrowDown" || event.key === "j") {
    movePlayer("down");
  } else if (event.key === " " || event.key === "f") {
    shoot();
  }
});

// Move the player fly
function movePlayer(direction) {
  if (direction === "up") {
    player.y -= player.speed;
    if (player.y < 0) {
      player.y = 0;
    }
  } else if (direction === "down") {
    player.y += player.speed;
    if (player.y + player.height> canvas.height) {
      player.y = canvas.height - player.height;
    }
  }
}

playerFrame = new Image();
playerFrame.src = "./images/fly.png";
function drawPlayer() {
    context.clearRect(0, 0, canvas.width, canvas.height);
    context.drawImage(
      playerFrame,
      player.x,
      player.y,
      player.width,
      player.height
    );
}

// Bullets
const bulletImage = new Image();
bulletImage.src = "./images/rolling-stone.png";

let bullets = [];
function shoot() {
  bullets.push({
    x: player.x,
    y: player.y + 50,
    width: 10,
    height: 9,
  });
}

function moveBullet() {
  for (let i in bullets) {
    bullets[i].x += 20;
  }
}

function deleteBullet() {
  
}

function bulletCollision() {
  
}

function checkBulletCollision() {

}

// Enemies
const enemyImg = new Image();
enemyImg.src = "./images/enemy.png";

let enemies = [];
let timer = 0;

function enemyMovement(enemy) {
  enemy.rotate += 0.05;
  enemy.x += enemy.speed;
}

function renderEnemies() {
  timer++;
  if (timer % 20 == 0) {
    enemies.push({
      x: canvas.width,
      // y: Math.random() * (canvas.width - enemy.width),
      y: canvas.height + 100,
      width: 116,
      height: 102,
      speed: 4,
      rotate: 0,
    });
  }

  for (let i in enemies) {
    enemyMovement(enemies[i]);

    context.save();
    context.translate(enemies[i].x, enemies[i].y);
    context.rotate(enemies[i].rotate);
    context.drawImage(
      enemyImg,
      -enemies[i].w/2,
      -enemies[i].h/2,
      enemies[i].w,
      enemies[i].h
    );
    context.restore();
  }

  deleteEnemy();
}

function deleteEnemy() {
  
}

function update() {
  drawPlayer();
}

function render() {
  context.beginPath();
  renderEnemies();
  context.closePath();
}

// Update the game every frame
function gameLoop() {
  update();
  render();
  requestAnimationFrame(gameLoop);
}
requestAnimationFrame(gameLoop);

// Start the game
// gameLoop();
