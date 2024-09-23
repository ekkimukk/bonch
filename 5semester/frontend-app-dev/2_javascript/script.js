const canvas = document.getElementById("game");
const context = canvas.getContext("2d");

canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

// Player
class Player {
  constructor() {
    this.velocity = {
      x: 0,
      y: 0,
    }

    const image = new Image();
    image.src = "./images/fly.png";
    image.onload = () => {
      this.image = image;
      const scale = 0.3;
      this.width = image.width * scale;
      this.height = image.height * scale;

      this.position = {
        x: canvas.width/20,
        y: canvas.height/2 - this.height/2,
      }

    }
  }

  draw() {
    context.clearRect(0, 0, canvas.width, canvas.height);
    context.drawImage(
      this.image,
      this.position.x,
      this.position.y,
      this.width,
      this.height,
    );
  }

  update() {
    if (this.image) {
      this.draw();
      this.position.y += this.velocity.y;
    }
  }
};

// Projectiles
class Projectile {
  constructor({position, velocity}) {
    this.position = position;
    this.velocity = velocity;
    this.radius = 4.5;
  }

  draw() {
    context.beginPath();
    context.arc(this.position.x, this.position.y, this.radius, 0, Math.PI * 2);
    context.fillStyle = "#361c11";
    context.fill();
    context.closePath();
  }

  update() {
    this.draw();
    this.position.x += this.velocity.x;
    this.position.y += this.velocity.y;
  }
}

// Enemies
class Enemy {
  constructor({ position }) {
    this.velocity = {
      x: 0,
      y: 0,
    }

    this.position = {
      x: position.x,
      y: position.y,
    }

    const image = new Image();
    image.src = "./images/enemy.png";
    image.onload = () => {
      const scale = 0.3;
      this.image = image;
      this.width = image.width * scale;
      this.height = image.height * scale;

      this.position = {
        x: position.x,
        y: position.y,
      }
    }
  }

  draw() {
    // context.clearRect(this.position.x, this.position.y, this.width, this.height);
    context.beginPath();
    context.drawImage(
      this.image,
      this.position.x,
      this.position.y,
      this.width,
      this.height,
    );
  }

  update({velocity}) {
    if (this.image) {
      this.draw();
      this.position.x -= velocity.x;
      this.position.y -= velocity.y;
    }
  }
};

class Grid {
  constructor() {
    this.position = {
      x: 0,
      y: 0,
    }

    this.velocity = {
      x: 1,
      y: 0,
    }

    this.enemies = [];

    const columns = Math.floor(Math.random() * 9 + 17);
    const rows = Math.floor(Math.random() * 90 + 120);
    for (let i = 0; i < columns; i++) {
      for (let u = 0; u < rows; u++) {
        if (Math.random() < 0.4) {
          this.enemies.push(
            new Enemy({
              position:  {
                x: canvas.width + u*50 - 4,
                y: canvas.height - (i * 45) + 8,
              }
            })
          );
        } else {
          continue;
        }
      }
    }
  }

  update() {
    this.position.x -= this.velocity.x;
    this.position.y -= this.velocity.y;
  }
}

const player = new Player();
const projectiles = [];
const grids = [new Grid()];
const keys = {
  j: {
    pressed: false,
  },
  k: {
    pressed: false,
  },
  f: {
    pressed: false,
  },
}

// Moving
function moving() {
  if (keys.j.pressed && player.position.y <= canvas.height - player.height - 4) { // The 4 because of border is 4px
    player.velocity.y = 9;
  } else if (keys.k.pressed && player.position.y >= 0 + 4) {
    player.velocity.y = -9;
  } else {
    player.velocity.y = 0;
  }
}

addEventListener("keydown", ({key}) => {
  switch (key) {
    case "j":
      keys.j.pressed = true;
      break;
    case "k":
      keys.k.pressed = true;
      break;
    case "f":
      // keys.f.pressed = true;
      projectiles.push(
        new Projectile({
          position: {
            x: player.position.x + player.width,
            y: player.position.y + player.height/(5/4),
          },
          velocity: {
            x: 5,
            y: 0,
          },
        })
      );
      break;
  }
});

addEventListener("keyup", ({key}) => {
  switch (key) {
    case "j":
      keys.j.pressed = false;
      break;
    case "k":
      keys.k.pressed = false;
      break;
    case "f":
      keys.f.pressed = false;
      break;
  }
});

function projectilesRendering() {
  projectiles.forEach((projectile, index) => {
    if (projectile.position.x > canvas.width) {
      setTimeout(() => {
        projectiles.splice(index, 1);
      }, 0);
    } else {
      projectile.update();
    }
  });
}

function createEnemy() {
  grids.forEach((grid)=> {
    grid.update();
    grid.enemies.forEach(enemy => {
      enemy.update({velocity: grid.velocity});

      projectiles.forEach(projectiles => {
        // if ()
      })
    });
  });
}

// Rendering
function animate() {
  requestAnimationFrame(animate);
  player.update();
  projectilesRendering();
  createEnemy();
  moving();
}
setInterval(animate(), 1000/60);

