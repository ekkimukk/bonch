// let flag = true;
// let currentColor = document.getElementById("background-layer").style.backgroundColor;

const colorChanger = document.getElementById('color-changer');

colorChanger.addEventListener('change', (event) => {
  document.body.style.backgroundColor = event.target.value;
});

function valid(params) {
   const email = document.getElementById("email").value;
  const message = document.getElementById("message");
  const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  if (re.test(email)) {
    message.innerHTML = '<p style="color:green;">Correct)))</p>';
  } else {
    message.innerHTML = '<p class="error">Incorrect(((</p>';
  } 
}

