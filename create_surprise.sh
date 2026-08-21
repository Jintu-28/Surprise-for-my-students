#!/usr/bin/env bash
set -e

OUTDIR="surprise_package"
ZIPNAME="surprise_package.zip"

# remove old
rm -rf "$OUTDIR" "$ZIPNAME"
mkdir -p "$OUTDIR/videos"

echo "Creating files in ./$OUTDIR ..."

# surprise.html (updated: videos not muted; play overlay for video2)
cat > "$OUTDIR/surprise.html" <<'HTML'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Mathematical Physics Surprise</title>
<style>
*{box-sizing:border-box}
body{margin:0;min-height:100vh;font-family:Arial,Helvetica,sans-serif;background:linear-gradient(135deg,#667eea,#764ba2);display:flex;justify-content:center;align-items:center;overflow-x:hidden}
.container{width:94%;max-width:1000px;min-height:620px;margin:25px auto;padding:40px;background:rgba(255,255,255,.97);border-radius:30px;box-shadow:0 25px 70px rgba(0,0,0,.3);text-align:center}
.screen{display:none;animation:fade .8s ease}.screen.active{display:block}
@keyframes fade{from{opacity:0;transform:translateY(30px)}to{opacity:1;transform:none}}
h1{color:#3f3d56;font-size:42px;margin:15px 0 20px}h2{color:#4b4b4b;font-size:30px;line-height:1.4}p{color:#555;font-size:20px;line-height:1.6}.emoji{font-size:75px;margin:10px}
.buttons{margin-top:45px;display:flex;justify-content:center;align-items:center;gap:30px;position:relative;min-height:100px}
button{border:0;padding:16px 40px;font-size:20px;font-weight:bold;border-radius:50px;cursor:pointer}
.yes-btn{color:white;background:linear-gradient(135deg,#28a745,#20c997);box-shadow:0 8px 20px rgba(40,167,69,.35)}
.no-btn{color:white;background:linear-gradient(135deg,#dc3545,#ff416c);position:relative}
.video-container{margin-top:30px;position:relative}
video{width:100%;max-width:850px;border-radius:20px;background:#000;box-shadow:0 15px 40px rgba(0,0,0,.3)}
.video-note{font-size:16px;color:#777}
.scratch-title{color:#764ba2;font-size:32px}
.scratch-wrapper{width:750px;max-width:95%;height:470px;margin:30px auto;position:relative;border-radius:25px;overflow:hidden;background:#fff;box-shadow:0 15px 45px rgba(0,0,0,.3)}
.hidden-question{position:absolute;inset:0;display:flex;justify-content:center;align-items:center;background:#fff;opacity:0;transform:scale(.5) rotate(-5deg);z-index:1}
.hidden-question img{width:100%;height:100%;object-fit:contain;background:#fff}
.hidden-question.revealed{opacity:1;transform:scale(1) rotate(0);animation:questionReveal 1.6s cubic-bezier(.175,.885,.32,1.275)}
@keyframes questionReveal{0%{opacity:0;transform:scale(.3) rotate(-10deg);filter:blur(15px)}50%{opacity:1;transform:scale(1.12) rotate(3deg);filter:blur(0)}75%{transform:scale(.96) rotate(-1deg)}100%{opacity:1;transform:scale(1) rotate(0)}}
.scratch-message{position:absolute;z-index:10;top:50%;left:50%;transform:translate(-50%,-50%);width:90%;color:#fff;font-size:34px;font-weight:900;text-align:center;line-height:1.5;text-shadow:2px 3px 8px rgba(0,0,0,.8);pointer-events:none;transition:opacity .5s}
.scratch-message span{font-size:18px;font-weight:normal}
#scratchCanvas{position:absolute;top:0;left:0;width:100%;height:100%;cursor:crosshair;touch-action:none;z-index:5}
.progress-container{width:750px;max-width:90%;margin:10px auto 20px}.progress-bar{width:100%;height:20px;background:#e4e4e4;border-radius:20px;overflow:hidden}.progress-fill{width:0;height:100%;background:linear-gradient(90deg,#667eea,#764ba2,#ff4b8b);border-radius:20px;transition:width .15s}
#progressText{margin:8px 0 0;font-size:17px;font-weight:bold;color:#764ba2}.scratch-info{font-size:17px;color:#777}
.challenge-box{background:linear-gradient(135deg,#f7f2ff,#fff);border-radius:20px;padding:25px;margin:25px auto;max-width:900px;box-shadow:0 8px 25px rgba(0,0,0,.1)}.challenge-box h3{color:#764ba2;font-size:30px}.challenge-box img{max-width:100%;height:auto;border-radius:15px}
#finalMessage{display:none;position:fixed;inset:0;width:100vw;height:100vh;z-index:99999;background:radial-gradient(circle at center,#fff 0%,#f3e8ff 35%,#667eea 100%);justify-content:center;align-items:center;flex-direction:column;text-align:center;overflow:hidden}
#finalMessage.show{display:flex;animation:finalFade 1.5s ease}.stars{font-size:65px;animation:star 2s ease-in-out infinite}
.best-luck{margin:0;padding:0 20px;font-size:clamp(55px,10vw,145px);font-weight:900;letter-spacing:5px;background:linear-gradient(90deg,#ff512f,#dd2476,#7b2ff7,#2575fc);-webkit-background-clip:text;-webkit-text-fill-color:transparent;animation:best 2s ease,glow 2s ease-in-out infinite alternate}
.from-sir{margin-top:30px;font-size:clamp(30px,5vw,70px);font-weight:700;color:#3f3d56;animation:up 2s ease .7s both}.final-subtitle{margin-top:25px;padding:0 20px;font-size:clamp(18px,3vw,28px);color:#555;animation:up 2s ease 1.2s both}
.play-overlay{position:absolute;left:50%;top:50%;transform:translate(-50%,-50%);z-index:30;background:rgba(0,0,0,.45);border-radius:999px;padding:24px;display:flex;align-items:center;justify-content:center;cursor:pointer}
.play-overlay .icon{width:80px;height:80px;border-radius:50%;background:linear-gradient(90deg,#ff512f,#7b2ff7);display:flex;align-items:center;justify-content:center;box-shadow:0 10px 30px rgba(0,0,0,.35)}
.play-overlay .icon:after{content:'►';color:#fff;font-size:36px;font-weight:700;margin-left:6px}
@keyframes finalFade{from{opacity:0}to{opacity:1}}@keyframes best{0%{transform:scale(.2);opacity:0}60%{transform:scale(1.15);opacity:1}100%{transform:scale(1)}}@keyframes glow{from{filter:drop-shadow(0 0 5px rgba(255,255,255,.4))}to{filter:drop-shadow(0 0 30px rgba(255,255,255,.95))}}@keyframes up{from{transform:translateY(50px);opacity:0}to{transform:none;opacity:1}}@keyframes star{0%,100%{transform:scale(1) rotate(0)}50%{transform:scale(1.2) rotate(8deg)}}
@media(max-width:700px){.container{width:95%;padding:25px 15px;min-height:550px}h1{font-size:30px}h2{font-size:23px}p{font-size:17px}.emoji{font-size:60px}.scratch-wrapper{height:450px}.scratch-message{font-size:25px}}
</style>
</head>
<body>
<main class="container" role="main">
  <section id="screen1" class="screen active" aria-hidden="false">
    <div class="emoji" aria-hidden="true">🎁</div>
    <h1>Dear Students!</h1>
    <p>I have a <strong>SURPRISE</strong> for you! 😎</p>
    <p>But first... you have to answer one question.</p>
    <h2>Do you want to reveal the surprise?</h2>
    <div class="buttons">
      <button type="button" class="yes-btn" id="yesReveal">YES 😍</button>
      <button type="button" class="no-btn" id="noButton1" aria-label="No, I don't want to reveal">NO 😜</button>
    </div>
  </section>

  <section id="screen2" class="screen" aria-hidden="true">
    <div class="emoji" aria-hidden="true">❤️</div>
    <h1>One More Question!</h1>
    <h2>Do you love<br>Mathematical Physics? 📐</h2>
    <p>Be honest... there is only one correct answer! 😄</p>
    <div class="buttons">
      <button type="button" class="yes-btn" id="yesPhysics">YES ❤️</button>
      <button type="button" class="no-btn" id="noButton2" aria-label="No, I don't love it">NO 😜</button>
    </div>
  </section>

  <section id="screen3" class="screen" aria-hidden="true">
    <div class="emoji" aria-hidden="true">🎬</div>
    <h1>Excellent Choice! 🎉</h1>
    <p>very good </p>
    <div class="video-container">
      <!-- no muted, no autoplay -->
      <video id="video1" controls playsinline preload="metadata">
        <source src="videos/video1.mp4" type="video/mp4" />
        Your browser does not support HTML5 video.
      </video>
    </div>
    <p class="video-note">🎬 Watch the video until the end to unlock your surprise.</p>
  </section>

  <section id="screen4" class="screen" aria-hidden="true">
    <div class="emoji" aria-hidden="true">🎁✨</div>
    <h1>Your Surprise Is Here!</h1>
    <p>The question is completely hidden!</p>
    <h2 class="scratch-title">✨ Scratch 100% to Reveal Your Question ✨</h2>

    <div class="scratch-wrapper" id="scratchWrapper" aria-live="polite">
      <div class="hidden-question" id="hiddenQuestion" aria-hidden="true">
        <img src="questions.svg" alt="Mathematical Physics Questions" />
      </div>

      <div class="scratch-message" id="scratchMessage" aria-hidden="true">
        ✨ SCRATCH TO REVEAL ✨<br /><span>Your Mathematical Physics Challenge</span>
      </div>

      <canvas id="scratchCanvas" role="img" aria-label="scratch card"></canvas>
    </div>

    <div class="progress-container">
      <div class="progress-bar" aria-hidden="true"><div id="scratchProgress" class="progress-fill"></div></div>
      <p id="progressText" aria-live="polite">0% scratched</p>
    </div>

    <p class="scratch-info">🖱️ Use your mouse or finger to scratch the entire card.</p>
  </section>

  <section id="screen5" class="screen" aria-hidden="true">
    <div class="emoji" aria-hidden="true">🎉</div>
    <h1>Surprise Revealed!</h1>
    <p>Congratulations! You discovered your Mathematical Physics challenge.</p>
    <div class="challenge-box">
      <h3>🔥 Your Challenge</h3>
      <img src="questions.svg" alt="Mathematical Physics Questions" />
    </div>
    <p>🎬 And now... one final surprise!</p>

    <div class="video-container" style="position:relative;">
      <!-- final video: user must press overlay to play with sound -->
      <video id="video2" controls playsinline preload="metadata">
        <source src="videos/video2.mp4" type="video/mp4" />
        Your browser does not support HTML5 video.
      </video>

      <!-- play overlay: visible until user clicks to play video2 -->
      <div id="playOverlay" class="play-overlay" aria-hidden="false" title="Play final message">
        <div class="icon" role="button" aria-label="Play final video"></div>
      </div>
    </div>

    <p class="video-note">Tap the button to play the final message with sound ❤️</p>
  </section>
</main>

<div id="finalMessage" role="dialog" aria-live="polite" aria-hidden="true">
  <div class="stars" aria-hidden="true">✨ ⭐ ✨</div>
  <h1 class="best-luck">BEST OF LUCK!</h1>
  <div class="from-sir">❤️ From JOYANTA Sir ❤️</div>
  <div class="final-subtitle">Keep Learning • Keep Exploring • Keep Shining! 🌟</div>
</div>

<noscript>
  <div style="position:fixed;inset:0;display:flex;align-items:center;justify-content:center;background:rgba(0,0,0,.5);color:#fff;padding:20px;text-align:center;z-index:99999">
    This experience requires JavaScript. Please enable JavaScript to play the reveal.
  </div>
</noscript>

<script>
/* Navigation and ARIA handling */
function goToScreen(n){
  document.querySelectorAll(".screen").forEach(s=>{
    s.classList.remove("active");
    s.setAttribute("aria-hidden","true");
  });
  const s=document.getElementById("screen"+n);
  if(s){
    s.classList.add("active");
    s.setAttribute("aria-hidden","false");
    const focusable = s.querySelector("button, [href], input, select, textarea, video");
    if(focusable) focusable.focus();
  }
}

/* NO buttons that move away - improved positioning + keyboard support */
function makeNoButtonMove(id){
  const b=document.getElementById(id);
  if(!b) return;
  const container = b.parentElement;
  function move(e){
    if(e && e.preventDefault) e.preventDefault();
    const r = container.getBoundingClientRect();
    const br = b.getBoundingClientRect();
    const padding = 12;
    const maxX = Math.max(padding, r.width - br.width - padding);
    const maxY = Math.max(0, r.height - br.height - padding);
    const left = Math.round(Math.random() * maxX);
    const top = Math.round(Math.random() * maxY);
    b.style.position = "absolute";
    b.style.left = left + "px";
    b.style.top = top + "px";
  }
  b.addEventListener("mouseenter", move);
  b.addEventListener("touchstart", move, {passive:false});
  b.addEventListener("click", move);
  b.addEventListener("focus", move);
  b.addEventListener("keydown", (ev) => {
    if (ev.key === "Enter" || ev.key === " ") { ev.preventDefault(); move(ev); }
  });
}
makeNoButtonMove("noButton1");
makeNoButtonMove("noButton2");

/* Wire up buttons (avoid inline onclick attributes) */
document.getElementById("yesReveal").addEventListener("click", ()=>goToScreen(2));
document.getElementById("yesPhysics").addEventListener("click", startVideo1);

/* Video handling */
/* video1 will be started by the user's click on the "YES" button (user gesture allows unmuted play) */
function startVideo1(){
  goToScreen(3);
  const v=document.getElementById("video1");
  if(!v) return;
  v.currentTime = 0;
  v.play().catch(()=>console.log("Browser blocked unmuted autoplay; press play on the video."));
}

/* End event for video1: move to scratch screen */
const v1 = document.getElementById("video1");
if(v1){
  v1.addEventListener("ended", ()=>{
    goToScreen(4);
    setTimeout(initializeScratchCard, 500);
  });
}

/* Scratch card logic with DPI scaling + throttled updates */
let scratchInitialized = false;
let scratchCompleted = false;

function initializeScratchCard(){
  if(scratchInitialized) return;
  scratchInitialized = true;

  const canvas = document.getElementById("scratchCanvas");
  const wrapper = document.getElementById("scratchWrapper");
  if(!canvas || !wrapper) return;
  const ctx = canvas.getContext("2d");

  const rect = wrapper.getBoundingClientRect();
  const ratio = window.devicePixelRatio || 1;
  canvas.width = Math.floor(rect.width * ratio);
  canvas.height = Math.floor(rect.height * ratio);
  canvas.style.width = rect.width + "px";
  canvas.style.height = rect.height + "px";

  ctx.setTransform(ratio, 0, 0, ratio, 0, 0);

  const g = ctx.createLinearGradient(0, 0, rect.width, rect.height);
  g.addColorStop(0, "#454545");
  g.addColorStop(.2, "#888");
  g.addColorStop(.45, "#d5d5d5");
  g.addColorStop(.65, "#999");
  g.addColorStop(1, "#414141");
  ctx.fillStyle = g;
  ctx.fillRect(0, 0, rect.width, rect.height);

  ctx.fillStyle = "rgba(255,255,255,.12)";
  for(let i=0;i<120;i++){
    let x = Math.random() * rect.width;
    let y = Math.random() * rect.height;
    let r = Math.random() * 15 + 4;
    ctx.beginPath();
    ctx.arc(x, y, r, 0, Math.PI*2);
    ctx.fill();
  }

  let scratching = false;
  let lastX = 0, lastY = 0;
  function pos(e){
    const r = canvas.getBoundingClientRect();
    const t = e.touches && e.touches.length ? e.touches[0] : e;
    return { x: t.clientX - r.left, y: t.clientY - r.top };
  }

  function scratchMoveTo(p){
    ctx.globalCompositeOperation = "destination-out";
    ctx.lineWidth = 60;
    ctx.lineCap = "round";
    ctx.lineJoin = "round";
    ctx.beginPath();
    ctx.moveTo(lastX, lastY);
    ctx.lineTo(p.x, p.y);
    ctx.stroke();
    ctx.beginPath();
    ctx.arc(p.x, p.y, 30, 0, Math.PI*2);
    ctx.fill();
  }

  function scratch(e){
    if(!scratching) return;
    if(e && e.preventDefault) e.preventDefault();
    const p = pos(e);
    scratchMoveTo(p);
    lastX = p.x; lastY = p.y;
    scheduleUpdate();
  }
  function startScr(e){
    if(scratchCompleted) return;
    scratching = true;
    const p = pos(e);
    lastX = p.x; lastY = p.y;
    scratchMoveTo(p);
    scheduleUpdate();
  }
  function stopScr(){
    scratching = false;
    scheduleUpdate();
  }

  canvas.addEventListener("mousedown", startScr);
  canvas.addEventListener("mousemove", scratch);
  window.addEventListener("mouseup", stopScr);
  canvas.addEventListener("mouseleave", stopScr);

  canvas.addEventListener("touchstart", startScr, {passive:false});
  canvas.addEventListener("touchmove", scratch, {passive:false});
  canvas.addEventListener("touchend", stopScr);

  let needsUpdate = false;
  function scheduleUpdate(){
    if(!needsUpdate){
      needsUpdate = true;
      requestAnimationFrame(()=>{
        needsUpdate = false;
        updateProgress();
      });
    }
  }

  function updateProgress(){
    if(scratchCompleted) return;
    const img = ctx.getImageData(0, 0, canvas.width, canvas.height);
    const data = img.data;
    let transparent = 0;
    let sampled = 0;
    const sampleStep = 6;
    for (let y = 0; y < canvas.height; y += sampleStep) {
      for (let x = 0; x < canvas.width; x += sampleStep) {
        const idx = (y * canvas.width + x) * 4;
        const a = data[idx + 3];
        sampled++;
        if (a < 50) transparent++;
      }
    }
    const pct = Math.min(100, Math.floor((transparent / sampled) * 100));
    document.getElementById("scratchProgress").style.width = pct + "%";
    document.getElementById("progressText").innerText = pct + "% scratched";
    if(pct >= 100) revealQuestion();
  }
}

/* reveal sequence */
function revealQuestion(){
  if(scratchCompleted) return;
  scratchCompleted = true;
  document.getElementById("scratchProgress").style.width = "100%";
  document.getElementById("progressText").innerText = "100% scratched! 🎉";
  const msg = document.getElementById("scratchMessage");
  if(msg) msg.style.display = "none";
  const canvas = document.getElementById("scratchCanvas");
  if(canvas){
    canvas.style.transition = "opacity 1s";
    canvas.style.opacity = "0";
    canvas.style.pointerEvents = "none";
  }
  setTimeout(()=>{
    const hidden = document.getElementById("hiddenQuestion");
    if(hidden){
      hidden.classList.add("revealed");
      hidden.setAttribute("aria-hidden","false");
    }
    createConfetti(100);
    setTimeout(()=>{
      goToScreen(5);
      // Try to autoplay video2 unmuted automatically. If the browser blocks it
      // (no fresh user gesture), fall back to the tap-to-play overlay.
      const v2 = document.getElementById("video2");
      const overlay = document.getElementById("playOverlay");
      if(v2){
        v2.currentTime = 0;
        v2.play().then(()=>{
          if(overlay){ overlay.style.display = "none"; overlay.setAttribute("aria-hidden","true"); }
        }).catch(()=>{
          if(overlay){ overlay.style.display = "flex"; overlay.setAttribute("aria-hidden","false"); }
        });
      }
    }, 5000);
  }, 1000);
}

/* confetti (uses Web Animations API if available) */
function createConfetti(count){
  for(let i=0;i<count;i++){
    const c=document.createElement("div");
    c.style.cssText = `position:fixed;width:10px;height:10px;left:${Math.random()*100}vw;top:-20px;z-index:100000;pointer-events:none;border-radius:3px;background:hsl(${Math.random()*360},90%,60%)`;
    document.body.appendChild(c);
    const d = 2500 + Math.random()*3000;
    const h = (Math.random() - .5) * 300;
    const rot = Math.random() * 1500;
    if (c.animate) {
      c.animate([
        { transform: "translate(0,0) rotate(0)", opacity: 1 },
        { transform: `translate(${h}px,110vh) rotate(${rot}deg)`, opacity: 0 }
      ], { duration: d, easing: "ease-out" });
      setTimeout(()=>c.remove(), d + 100);
    } else {
      c.style.transition = `transform ${d}ms ease-out, opacity ${d}ms ease-out`;
      requestAnimationFrame(()=>{ c.style.transform = `translate(${h}px,110vh) rotate(${rot}deg)`; c.style.opacity = "0"; });
      setTimeout(()=>c.remove(), d + 100);
    }
  }
}

/* Final video overlay behavior */
const overlay = document.getElementById("playOverlay");
const v2 = document.getElementById("video2");
if(overlay && v2){
  overlay.addEventListener("click", ()=>{
    // user gesture: play with sound
    v2.currentTime = 0;
    v2.play().catch(()=>console.log("Play was blocked — press the play button on the video."));
    overlay.style.display = "none";
    overlay.setAttribute("aria-hidden","true");
  });
  // also hide overlay if user plays using the video controls directly
  v2.addEventListener("play", ()=>{ overlay.style.display = "none"; overlay.setAttribute("aria-hidden","true"); });
  // when final video ends, show final message as before
  v2.addEventListener("ended", ()=>{
    const fm = document.getElementById("finalMessage");
    if(fm){
      fm.classList.add("show");
      fm.setAttribute("aria-hidden","false");
      createConfetti(150);
    }
  });
}

/* Optional: re-init scratch if window resizes when screen4 is active */
let resizeTimeout = null;
window.addEventListener("resize", ()=>{
  if (document.getElementById("screen4").classList.contains("active") && !scratchCompleted){
    clearTimeout(resizeTimeout);
    resizeTimeout = setTimeout(()=>{
      scratchInitialized = false;
      initializeScratchCard();
    }, 300);
  }
});
</script>
</body>
</html>
HTML

# questions.svg (simple placeholder)
cat > "$OUTDIR/questions.svg" <<'SVG'
<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="800" viewBox="0 0 1200 800">
  <rect width="100%" height="100%" fill="#fff"/>
  <g transform="translate(60,60)">
    <rect x="0" y="0" width="1080" height="680" rx="24" fill="#f7f7ff" stroke="#e6e0ff" />
    <text x="540" y="160" font-family="Arial, Helvetica, sans-serif" font-size="48" font-weight="700" text-anchor="middle" fill="#3f3d56">Mathematical Physics</text>
    <text x="540" y="260" font-family="Arial, Helvetica, sans-serif" font-size="32" text-anchor="middle" fill="#555">Your Challenge Questions</text>
    <g fill="#764ba2" font-family="Arial, Helvetica, sans-serif" font-size="26">
      <text x="80" y="360">1. Derive the wave equation from first principles.</text>
      <text x="80" y="410">2. Prove energy conservation for this system.</text>
      <text x="80" y="460">3. Solve the eigenvalue problem on [0,π].</text>
    </g>
  </g>
</svg>
SVG

# videos README (user should add mp4 files)
cat > "$OUTDIR/videos/README.txt" <<'TXT'
Place your video files here:

- video1.mp4   --> used on screen 3 (will play unmuted after user clicks "YES")
- video2.mp4   --> used on screen 5 (auto-attempts unmuted playback; falls back to a tap-to-play button if the browser blocks it)

If you don't have videos, you can add short MP4 clips with those names, or adjust surprise.html to reference other filenames or use external URLs.
TXT

# create small placeholder text files in place of mp4s
echo "PLACEHOLDER for video1.mp4 - add your MP4 here" > "$OUTDIR/videos/video1.txt"
echo "PLACEHOLDER for video2.mp4 - add your MP4 here" > "$OUTDIR/videos/video2.txt"

# create zip
cd "$OUTDIR"
zip -r "../$ZIPNAME" .
cd ..

echo "Created $ZIPNAME — contains surprise.html (updated), questions.svg, and videos/README.txt (+ placeholders)."
echo "Unzip and replace videos/video1.mp4 & videos/video2.mp4 with your MP4 files."
