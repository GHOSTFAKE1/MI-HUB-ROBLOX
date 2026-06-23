<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<title>GHOST HUB V2</title>

<style>
body{
    margin:0;
    background:#070b14;
    font-family:Consolas;
    color:white;
    overflow:hidden;
}

/* OPEN BUTTON */
#openBtn{
    position:fixed;
    top:20px;
    left:20px;
    padding:10px 20px;
    background:#00aaff;
    border:none;
    border-radius:10px;
    color:white;
    cursor:pointer;
}

/* PANEL */
#panel{
    position:fixed;
    top:50%;
    left:50%;
    transform:translate(-50%,-50%);
    width:800px;
    height:500px;
    background:rgba(10,15,30,0.9);
    border:1px solid #00aaff55;
    box-shadow:0 0 25px #00aaff55;
    border-radius:20px;
    padding:20px;
    display:none;
}

/* CLOSE */
button{
    padding:10px;
    margin:5px;
    border:none;
    border-radius:10px;
    background:#00aaff22;
    color:white;
    cursor:pointer;
}
button:hover{background:#00aaff55}

/* PLAYER */
#player{
    width:60px;
    height:60px;
    background:white;
    position:absolute;
    bottom:50px;
    left:50px;
    border-radius:10px;
}

/* GROUND */
#ground{
    position:absolute;
    bottom:0;
    width:100%;
    height:50px;
    background:#111;
}
</style>
</head>

<body>

<button id="openBtn">OPEN HUB</button>

<div id="panel">

    <button id="closeBtn">CLOSE</button>

    <h2>GHOST HUB V2</h2>

    <button onclick="setSpeed()">Speed</button>
    <button onclick="jump()">Jump</button>
    <button onclick="toggleGravity()">Gravity</button>
    <button onclick="toggleRainbow()">Rainbow</button>
    <button onclick="toggleNoclip()">Noclip</button>
    <button onclick="toggleInfinity()">Infinity Jump</button>

    <br><br>

    Speed:
    <input type="range" min="1" max="20" value="5" id="speed">

    Jump Power:
    <input type="range" min="5" max="30" value="12" id="jump">

    Gravity:
    <input type="range" min="1" max="20" value="5" id="gravity">

</div>

<div id="player"></div>
<div id="ground"></div>

<script>

let panel = document.getElementById("panel");
let player = document.getElementById("player");

/* OPEN / CLOSE */
document.getElementById("openBtn").onclick = ()=>{
    panel.style.display="block";
}

document.getElementById("closeBtn").onclick = ()=>{
    panel.style.display="none";
}

/* VALUES */
let speed = 5;
let jumpPower = 12;
let gravity = 5;

/* SPEED MOVEMENT */
setInterval(()=>{
    player.style.left = (player.offsetLeft + speed) + "px";
    if(player.offsetLeft > window.innerWidth) player.style.left = "0px";
},50);

/* JUMP */
function jump(){
    let y = 0;
    let up = setInterval(()=>{
        if(y >= jumpPower) clearInterval(up);
        y++;
        player.style.bottom = (50 + y*10) + "px";
    },20);

    setTimeout(()=>{
        let down = setInterval(()=>{
            if(y <= 0) clearInterval(down);
            y--;
            player.style.bottom = (50 + y*10) + "px";
        },20);
    },300);
}

/* SPEED SLIDER */
document.getElementById("speed").oninput = (e)=>{
    speed = parseInt(e.target.value);
}

/* JUMP SLIDER */
document.getElementById("jump").oninput = (e)=>{
    jumpPower = parseInt(e.target.value);
}

/* GRAVITY */
let gravityOn = false;

function toggleGravity(){
    gravityOn = !gravityOn;

    if(gravityOn){
        setInterval(()=>{
            if(player.offsetTop < window.innerHeight - 100){
                player.style.top = (player.offsetTop + gravity) + "px";
            }
        },50);
    }
}

/* RAINBOW */
let rainbow = false;

function toggleRainbow(){
    rainbow = !rainbow;
    let h = 0;

    if(rainbow){
        setInterval(()=>{
            h += 5;
            player.style.background = "hsl("+h+",100%,50%)";
        },100);
    }
}

/* NOCLIP (visual) */
let noclip = false;

function toggleNoclip(){
    noclip = !noclip;
    player.style.opacity = noclip ? "0.3" : "1";
}

/* INFINITY JUMP */
let inf = false;

function toggleInfinity(){
    inf = !inf;

    if(inf){
        setInterval(()=>{
            jump();
        },600);
    }
}

</script>

</body>
</html>
