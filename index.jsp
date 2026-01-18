<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String name = request.getParameter("name");
    if(name == null || name.trim().isEmpty()){
        name = "My Favourite Person";
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Happy Birthday <%= name %> ❤️</title>

<style>
body{
    margin:0;
    font-family:'Segoe UI',sans-serif;
    background:linear-gradient(to bottom,#ff5f6d,#ffc371);
    color:white;
    text-align:center;
    overflow:hidden;
}
h1{font-size:42px;margin-top:20px;}
h2{font-size:26px;}

.card{
    background:rgba(255,255,255,0.2);
    width:90%;
    max-width:500px;
    margin:15px auto;
    padding:20px;
    border-radius:20px;
    box-shadow:0 10px 25px rgba(0,0,0,0.3);
}

button{
    padding:12px 20px;
    font-size:16px;
    border:none;
    border-radius:25px;
    background:white;
    color:#ff4081;
    cursor:pointer;
    margin:8px;
    width:90%;
    max-width:300px;
}

.balloon{
    width:40px;height:55px;background:pink;border-radius:50%;
    position:absolute;bottom:-100px;animation:float 10s infinite;
}
@keyframes float{0%{bottom:-100px;}100%{bottom:110%;}}

canvas{position:fixed;top:0;left:0;z-index:-1;}

.popup{
    display:none;position:fixed;top:0;left:0;width:100%;height:100%;
    background:rgba(0,0,0,0.6);
    justify-content:center;
    align-items:center;
    z-index:5;
}
.popup-content{
    background:#fff;color:#ff4081;padding:20px;border-radius:15px;
    width:90%;max-width:400px;font-size:18px;
}

#cakeImg{
    width:180px;
    cursor:pointer;
}

#videoOverlay{
    display:none;
    position:fixed;
    top:0;left:0;
    width:100%;
    height:100%;
    background:rgba(0,0,0,0.8);
    justify-content:center;
    align-items:center;
    z-index:10;
}
#cakeVideo{
    width:90%;
    max-width:350px;
    border-radius:15px;
}
</style>
</head>

<body>

<canvas id="fireworks"></canvas>

<!-- Music -->
<audio id="music" loop>
    <source src="love.mp3" type="audio/mpeg">
</audio>

<!-- Balloons -->
<div class="balloon" style="left:10%"></div>
<div class="balloon" style="left:40%;animation-delay:2s"></div>
<div class="balloon" style="left:70%;animation-delay:4s"></div>

<h1>🎂 Happy Birthday 🎂</h1>

<div class="card">
    <h2>Dear <%= name %> ❤️</h2>
    <p>You are my happiness, my smile and my forever 💖</p>

    <button onclick="playMusic()">Play Music 🎵</button>
    <button onclick="openLetter()">Open Love Letter 💌</button>
</div>

<h2>🎂 Cut the Cake</h2>
<img src="cake.png" id="cakeImg" onclick="cutCake()">

<!-- Video Overlay -->
<div id="videoOverlay" onclick="closeVideo()">
    <video id="cakeVideo" controls>
        <source src="cake-cut.mp4" type="video/mp4">
    </video>
</div>

<!-- Love Letter -->
<div class="popup" id="letter">
  <div class="popup-content">
    <h2>My Love 💖</h2>
    <p>
      On your birthday, I want you to know that you mean everything to me.
      Every moment with you is magical and unforgettable.
      I promise to love you today, tomorrow and always ❤️
    </p>
    <button onclick="closeLetter()">Close</button>
  </div>
</div>

<script>
function playMusic(){
    document.getElementById('music').play();
}

function openLetter(){
    document.getElementById('letter').style.display='flex';
}
function closeLetter(){
    document.getElementById('letter').style.display='none';
}

function cutCake(){
    const overlay = document.getElementById('videoOverlay');
    const video = document.getElementById('cakeVideo');

    overlay.style.display = "flex";
    video.currentTime = 0;
    video.play();

    video.onended = () => {
        startFireworks();
        setTimeout(() => {
            alert("🎉 Cake Cut! Happy Birthday <%= name %> ❤️ 🎉");
        }, 500);
    }
}

function closeVideo(){
    const overlay = document.getElementById('videoOverlay');
    const video = document.getElementById('cakeVideo');
    video.pause();
    overlay.style.display = "none";
}

const canvas = document.getElementById('fireworks');
const ctx = canvas.getContext('2d');
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;
let particles = [];

function startFireworks(){
    setInterval(()=>{
        for(let i=0;i<40;i++){
            particles.push({
                x:Math.random()*canvas.width,
                y:Math.random()*canvas.height,
                r:Math.random()*3+1,
                dx:(Math.random()-0.5)*4,
                dy:(Math.random()-0.5)*4
            });
        }
    },700);
    animate();
}

function animate(){
    ctx.clearRect(0,0,canvas.width,canvas.height);
    particles.forEach(p=>{
        ctx.fillStyle='rgba(255,255,255,0.8)';
        ctx.beginPath();
        ctx.arc(p.x,p.y,p.r,0,Math.PI*2);
        ctx.fill();
        p.x+=p.dx;
        p.y+=p.dy;
    });
    requestAnimationFrame(animate);
}

window.onresize = () => {
    canvas.width = window.innerWidth;
    canvas.height = window.innerHeight;
}
</script>

</body>
</html>
