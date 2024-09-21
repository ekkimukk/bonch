const canvas = document.getElementById("game");
const context = canvas.getContext("2d");

canvas.width = window.innerWidth;
canvas.height = window.innerHeight;

class Player {
  constructor() {
    this.position = {
      x: 200,
      y: 200,
    }

    this.velocity = {
      x: 0,
      y: 0,
    }

    const image = new Image();
    image.src = "./images/fly.png";
    this.image = image;

    this.width = 103;
    this.height = 94;
  }

  draw() {
    // context.fillStyle = "red";
    // context.clearRect(
    //   this.position.x,
    //   this.position.y,
    //   this.width,
    //   this.height
    // );
    context.drawImage(
      this.image,
      this.position.x,
      this.position.y,
      this.width,
      this.height,
    );
  }
}

const player = new Player();

function animate() {
  requestAnimationFrame(animate);
  player.draw();
}

animate();




// Mouse listener
function startGame() {
  mouse = {
    x: innerWidth / 2,
    y: innerHeight - 33,
  };

  touch = {
    x: innerWidth / 2,
    y: innerHeight - 33,
  };

  canvas.addEventListener("mousemove", function (event) {
    mouse.x = enent.clientX;
  });

  canvas.addEventListener("touchmove", function (event) {
    rect = canvas.getBoundingClientRect();
    root = document.documentElement;
    touch = event.changeTouches[0];
    touchX = parseInt(touch.clientX);
    touchY = parseInt(touch.clientY) - rect.top - root.scrollTop;
});
}
