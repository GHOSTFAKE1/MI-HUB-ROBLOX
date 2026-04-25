<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ghost fake panel</title>

<style>
body{
    margin:0;
    background:#02030a;
    font-family:Consolas, monospace;
    color:white;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

/* PANEL */
.panel{
    width:900px;
    height:520px;
    background:rgba(20,20,30,0.6);
    backdrop-filter: blur(12px);
    border-radius:20px;
    display:flex;
    overflow:hidden;
    box-shadow:0 0 30px #000;
}

/* TOP BAR */
.topbar{
    position:absolute;
    width:900px;
    height:50px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:0 15px;
}

.title{
    font-size:18px;
}

.subtitle{
    font-size:11px;
    opacity:0.6;
}

.icons{
    display:flex;
    gap:10px;
}

.icon{
    cursor:pointer;
    opacity:0.7;
}

.icon:hover{
    opacity:1;
}

/* SIDEBAR */
.sidebar{
    width:200px;
    background:rgba(30,30,40,0.7);
    padding-top:60px;
}

.menu{
    padding:15px;
    cursor:pointer;
    opacity:0.7;
}

.menu.active{
    background:rgba(255,255,255,0.1);
    opacity:1;
}

/* MAIN */
.main{
    flex:1;
    padding:70px 30px 30px 30px;
}

/* SWITCH */
.switch{
    display:flex;
    justify-content:space-between;
    margin:10px 0;
}

.toggle{
    width:40px;
    height:20px;
    background:#444;
    border-radius:20px;
    position:relative;
    cursor:pointer;
}

.toggle::before{
    content:'';
    width:16px;
    height:16px;
    background:white;
    border-radius:50%;
    position:absolute;
    top:2px;
    left:2px;
    transition:0.3s;
}

.toggle.active{
    background:#00aaff;
}

.toggle.active::before{
    left:22px;
}

/* SLIDER */
.slider{
    width:100%;
}

.value{
    font-size:12px;
    opacity:0.7;
}

/* BUTTONS */
.presets{
    display:flex;
    gap:10px;
    margin-top:10px;
}

.btn{
    padding:10px;
    background:#111;
    border-radius:10px;
    cursor:pointer;
    flex:1;
    text-align:center;
}

.btn:hover{
    background:#222;
}
</style>
</head>

<body>

<div class="panel">

    <!-- TOP BAR -->
    <div class="topbar">
        <div>
            <div class="title">ghost fake</div>
            <div class="subtitle">by hack</div>
        </div>

        <div class="icons">
            <div class="icon">🔍</div>
            <div class="icon">➖</div>
            <div class="icon">⛶</div>
            <div class="icon">❌</div>
        </div>
    </div>

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="menu">🎯 Hitboxes</div>
        <div class="menu active">⚔️ Kill Aura</div>
        <div class="menu">🛡️ Whitelist</div>
        <div class="menu">👁️ Visual</div>
    </div>

    <!-- MAIN -->
    <div class="main">

        <h3>Kill Aura</h3>

        <div class="switch">
            Enable Kill Aura
            <div class="toggle"></div>
        </div>

        <div class="switch">
            Attack Robots
            <div class="toggle"></div>
        </div>

        <div class="switch">
            Sync with Hitbox
            <div class="toggle"></div>
        </div>

        <br>

        Attack Range
        <input type="range" min="1" max="20" value="8" class="slider" id="range">
        <div class="value" id="rangeVal">8</div>

        <br>

        Attack Delay (sec)
        <input type="range" min="0.01" max="0.1" step="0.005" value="0.03" class="slider" id="delay">
        <div class="value" id="delayVal">0.03</div>

        <br>

        ⚡ Presets

        <div class="presets">
            <div class="btn" onclick="setDelay(0.03)">Fast</div>
            <div class="btn" onclick="setDelay(0.045)">Medium</div>
            <div class="btn" onclick="setDelay(0.06)">Slow</div>
        </div>

    </div>

</div>

<script>

/* TOGGLES */
document.querySelectorAll(".toggle").forEach(t=>{
    t.onclick=()=> t.classList.toggle("active");
});

/* SLIDERS */
let range = document.getElementById("range");
let delay = document.getElementById("delay");

range.oninput = ()=> document.getElementById("rangeVal").innerText = range.value;
delay.oninput = ()=> document.getElementById("delayVal").innerText = delay.value;

/* PRESETS */
function setDelay(val){
    delay.value = val;
    document.getElementById("delayVal").innerText = val;
}

</script>

</body>
</html>
