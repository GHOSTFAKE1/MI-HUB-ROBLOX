<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GHOST HUB V2</title>

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Consolas, monospace;
}

body{
    background:#070b14;
    overflow:hidden;
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    color:white;
}

/* FONDO */
.bg{
    position:absolute;
    width:100%;
    height:100%;
    background:radial-gradient(circle at top,#00aaff22,#000814 60%);
    filter:blur(10px);
}

/* PANEL */
.panel{
    width:920px;
    height:560px;
    backdrop-filter:blur(16px);
    background:rgba(10,15,30,0.75);
    border:1px solid rgba(255,255,255,0.08);
    border-radius:22px;
    overflow:hidden;
    display:flex;
    position:relative;
    box-shadow:0 0 25px #00aaff55;
    animation:open .4s ease;
}

@keyframes open{
    from{
        transform:scale(.8);
        opacity:0;
    }
    to{
        transform:scale(1);
        opacity:1;
    }
}

/* SIDEBAR */
.sidebar{
    width:210px;
    background:rgba(0,0,0,.35);
    padding:20px;
    border-right:1px solid rgba(255,255,255,.05);
}

.logo{
    font-size:24px;
    font-weight:bold;
    margin-bottom:5px;
}

.small{
    font-size:12px;
    opacity:.6;
    margin-bottom:30px;
}

.item{
    padding:14px;
    margin-bottom:10px;
    border-radius:12px;
    cursor:pointer;
    transition:.25s;
    opacity:.75;
}

.item:hover{
    background:#00aaff22;
    transform:translateX(5px);
}

.item.active{
    background:#00aaff33;
    opacity:1;
    box-shadow:0 0 15px #00aaff55;
}

/* MAIN */
.main{
    flex:1;
    padding:25px;
    overflow:auto;
}

.topbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:25px;
}

.badge{
    background:#00aaff33;
    padding:8px 14px;
    border-radius:999px;
    font-size:12px;
}

.card{
    background:rgba(255,255,255,.03);
    border:1px solid rgba(255,255,255,.06);
    border-radius:18px;
    padding:20px;
    margin-bottom:20px;
}

.card h3{
    margin-bottom:18px;
}

/* SWITCH */
.switch{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin:14px 0;
}

.toggle{
    width:48px;
    height:24px;
    background:#2a2a2a;
    border-radius:999px;
    position:relative;
    cursor:pointer;
    transition:.25s;
}

.toggle::before{
    content:'';
    width:18px;
    height:18px;
    background:white;
    border-radius:50%;
    position:absolute;
    top:3px;
    left:3px;
    transition:.25s;
}

.toggle.active{
    background:#00aaff;
    box-shadow:0 0 12px #00aaff;
}

.toggle.active::before{
    left:27px;
}

/* SLIDER */
.sliderBox{
    margin-top:18px;
}

input[type=range]{
    width:100%;
    margin-top:10px;
}

.value{
    margin-top:6px;
    font-size:13px;
    opacity:.7;
}

/* BUTTONS */
.btns{
    display:flex;
    gap:12px;
    margin-top:20px;
}

.btn{
    flex:1;
    padding:12px;
    border:none;
    border-radius:12px;
    background:#00aaff22;
    color:white;
    cursor:pointer;
    transition:.25s;
}

.btn:hover{
    background:#00aaff55;
    box-shadow:0 0 12px #00aaff55;
}

/* OPEN BUTTON */
.openBtn{
    position:absolute;
    top:20px;
    left:20px;
    padding:12px 18px;
    border:none;
    border-radius:12px;
    background:#00aaff;
    color:white;
    cursor:pointer;
    z-index:999;
    box-shadow:0 0 15px #00aaff88;
}

.hidden{
    display:none;
}

</style>
</head>
<body>

<div class="bg"></div>

<button class="openBtn" id="openBtn">OPEN HUB</button>

<div class="panel" id="panel">

    <!-- SIDEBAR -->
    <div class="sidebar">

        <div class="logo">👻 GHOST HUB</div>
        <div class="small">v2 premium ui</div>

        <div class="item active">🎯 Combat</div>
        <div class="item">👁️ Visual</div>
        <div class="item">⚡ Player</div>
        <div class="item">🤖 Farm</div>
        <div class="item">⚙️ Settings</div>

    </div>

    <!-- MAIN -->
    <div class="main">

        <div class="topbar">
            <h2>Combat Panel</h2>
            <div class="badge">ONLINE</div>
        </div>

        <!-- CARD -->
        <div class="card">
            <h3>Combat Features</h3>

            <div class="switch">
                Aimbot
                <div class="toggle"></div>
            </div>

            <div class="switch">
                Hitbox
                <div class="toggle"></div>
            </div>

            <div class="switch">
                Visual ESP
                <div class="toggle"></div>
            </div>

            <div class="switch">
                Speed
                <div class="toggle"></div>
            </div>

        </div>

        <!-- SLIDER CARD -->
        <div class="card">
            <h3>Settings</h3>

            <div class="sliderBox">
                Hitbox Size
                <input type="range" min="1" max="30" value="10" id="hitbox">
                <div class="value" id="hitboxVal">10</div>
            </div>

            <div class="sliderBox">
                Speed Value
                <input type="range" min="10" max="100" value="25" id="speed">
                <div class="value" id="speedVal">25</div>
            </div>

        </div>

        <!-- BUTTONS -->
        <div class="btns">
            <button class="btn">SAVE CONFIG</button>
            <button class="btn">LOAD CONFIG</button>
            <button class="btn" id="closeBtn">CLOSE</button>
        </div>

    </div>

</div>

<script>

// TOGGLES
let toggles=document.querySelectorAll('.toggle');

for(let t of toggles){
    t.onclick=()=>{
        t.classList.toggle('active');
    }
}

// SLIDERS
let hitbox=document.getElementById('hitbox');
let speed=document.getElementById('speed');

hitbox.oninput=()=>{
    document.getElementById('hitboxVal').innerText=hitbox.value;
}

speed.oninput=()=>{
    document.getElementById('speedVal').innerText=speed.value;
}

// OPEN / CLOSE
let panel=document.getElementById('panel');
let openBtn=document.getElementById('openBtn');
let closeBtn=document.getElementById('closeBtn');

closeBtn.onclick=()=>{
    panel.classList.add('hidden');
}

openBtn.onclick=()=>{
    panel.classList.remove('hidden');
}

// SIDEBAR EFFECT
let items=document.querySelectorAll('.item');

items.forEach(item=>{
    item.onclick=()=>{
        items.forEach(i=>i.classList.remove('active'));
        item.classList.add('active');
    }
})

</script>

</body>
</html>
