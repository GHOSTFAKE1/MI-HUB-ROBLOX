<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>ghost fake</title>

<style>
body{
    margin:0;
    background:#0b0f1a;
    font-family:Consolas, monospace;
    color:white;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

/* PANEL */
.panel{
    width:90%;
    max-width:900px;
    height:520px;
    background:rgba(0,170,255,0.25);
    border-radius:20px;
    display:flex;
    overflow:hidden;
    border:1px solid rgba(255,255,255,0.1);
}

/* TOP */
.top{
    position:absolute;
    width:90%;
    max-width:900px;
    display:flex;
    justify-content:space-between;
    padding:10px 15px;
}

.title{
    font-weight:bold;
}

.subtitle{
    font-size:12px;
    opacity:0.7;
}

/* SIDEBAR */
.sidebar{
    width:180px;
    background:rgba(0,0,0,0.4);
    padding-top:50px;
}

.item{
    padding:12px;
    cursor:pointer;
    opacity:0.7;
}

.item.active{
    background:rgba(255,255,255,0.1);
    opacity:1;
}

/* MAIN */
.main{
    flex:1;
    padding:60px 20px;
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
    background:#333;
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
input[type=range]{
    width:100%;
}

.small{
    font-size:12px;
    opacity:0.7;
}
</style>
</head>

<body>

<div class="panel">

    <!-- SIDEBAR -->
    <div class="sidebar">
        <div class="item">🎯 Hitboxes</div>
        <div class="item active">⚔️ Kill Aura</div>
        <div class="item">🛡️ Whitelist</div>
        <div class="item">👁️ Visual</div>
    </div>

    <!-- MAIN -->
    <div class="main">

        <h2>ghost fake</h2>
        <div class="small">by hack</div>

        <hr>

        <div class="switch">
            Enable Kill Aura
            <div class="toggle"></div>
        </div>

        <div class="switch">
            Attack Robots
            <div class="toggle"></div>
        </div>

        <div class="switch">
            Sync Hitbox
            <div class="toggle"></div>
        </div>

        <br>

        Attack Range
        <input type="range" min="1" max="20" value="8" id="range">
        <div class="small" id="rangeVal">8</div>

        <br><br>

        Delay
        <input type="range" min="0.01" max="0.1" step="0.01" value="0.03" id="delay">
        <div class="small" id="delayVal">0.03</div>

    </div>

</div>

<script>

// TOGGLES
document.querySelectorAll(".toggle").forEach(t=>{
    t.onclick=()=>t.classList.toggle("active");
});

// SLIDERS
let r=document.getElementById("range");
let d=document.getElementById("delay");

r.oninput=()=>document.getElementById("rangeVal").innerText=r.value;
d.oninput=()=>document.getElementById("delayVal").innerText=d.value;

</script>

</body>
</html>
