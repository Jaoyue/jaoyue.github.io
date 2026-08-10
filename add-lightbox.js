/**
 * add-lightbox.js
 * 给 notes-to-html-pages / ObsidianSite 导出的 HTML 注入图片点击放大（lightbox）功能。
 * 用法: node add-lightbox.js [目标目录，默认 ./page]
 * 特性:
 *  - 幂等可重跑：已注入(含旧版)的文件会先清除再写入最新模块。
 *  - 仅对包含 <img> 的页面注入；无图片页面自动跳过。
 *  - 采用 document 捕获阶段委托，兼容 SPA / 动态加载的图片，且不会触发原有链接跳转。
 */
const fs = require("fs");
const path = require("path");

const TARGET = process.argv[2] || path.join(__dirname, "page");

const CSS = `<style>.n2hp-lightbox{position:fixed;inset:0;background:rgba(15,15,20,.88);display:none;align-items:center;justify-content:center;z-index:2147483647;cursor:zoom-out}.n2hp-lightbox.open{display:flex}.n2hp-lightbox img{max-width:94vw;max-height:94vh;box-shadow:0 8px 50px rgba(0,0,0,.6);cursor:default;background:#fff;border-radius:4px}.n2hp-lightbox .n2hp-close{position:absolute;top:14px;right:20px;color:#fff;font-size:34px;line-height:1;cursor:pointer;opacity:.8}.n2hp-lightbox .n2hp-close:hover{opacity:1}.n2hp-lightbox .n2hp-cap{position:absolute;left:0;right:0;bottom:14px;text-align:center;color:#cfcfd8;font-size:13px;padding:0 20px;word-break:break-all}.n2hp-zoomable{cursor:zoom-in}</style>`;

const JS = `<script>(function(){function isContentImage(img){if(!img||img.tagName!=="IMG"||!img.getAttribute("src"))return false;if(img.closest&&img.closest("#n2hp-lightbox"))return false;var p=img;while(p&&p!==document.body){if(p.classList){var c=p.className||"";if(typeof c==="string"&&/(sidebar|graph|reader-control|callout|avatar|icon|logo)/i.test(c))return false;}p=p.parentElement;}return true;}function init(){if(document.getElementById("n2hp-lightbox"))return;var lb=document.createElement("div");lb.id="n2hp-lightbox";lb.className="n2hp-lightbox";lb.innerHTML='<span class="n2hp-close" aria-label="close">&#215;</span><img alt=""><div class="n2hp-cap"></div>';document.body.appendChild(lb);var limg=lb.querySelector("img");var cap=lb.querySelector(".n2hp-cap");function closeLb(){lb.classList.remove("open");}lb.addEventListener("click",function(e){if(e.target===lb||(e.target.classList&&e.target.classList.contains("n2hp-close")))closeLb();});document.addEventListener("keydown",function(e){if(e.key==="Escape")closeLb();});document.addEventListener("click",function(e){var t=e.target;if(t&&t.tagName==="IMG"&&isContentImage(t)){e.preventDefault();e.stopPropagation();limg.src=t.currentSrc||t.src;limg.alt=t.alt||"";cap.textContent=t.alt||"";lb.classList.add("open");}},true);}if(document.readyState==="loading")document.addEventListener("DOMContentLoaded",init);else init();})();</script>`;

const BLOCK = `<!--N2HP_LIGHTBOX_START-->` + CSS + JS + `<!--N2HP_LIGHTBOX_END-->`;

// 清除任何旧版 / 本版注入，保证幂等可重跑
function stripOld(html) {
  return html
    .replace(/<!--N2HP_LIGHTBOX_START-->[\s\S]*?<!--N2HP_LIGHTBOX_END-->/g, "")
    .replace(/<style>\.n2hp-lightbox\{[\s\S]*?<\/style>/g, "")
    .replace(/<script>\(function\(\)\{function isContentImage[\s\S]*?\}\)\(\);<\/script>/g, "");
}

function walk(dir, out) {
  for (const name of fs.readdirSync(dir)) {
    const full = path.join(dir, name);
    const st = fs.statSync(full);
    if (st.isDirectory()) walk(full, out);
    else if (name.toLowerCase().endsWith(".html")) out.push(full);
  }
}

const files = [];
walk(TARGET, files);
let patched = 0, skipped = 0, noImg = 0;

for (const file of files) {
  let html = fs.readFileSync(file, "utf8");
  const hadOld = html.includes("n2hp-lightbox");
  html = stripOld(html);

  if (!html.includes("<img")) { noImg++; if (hadOld) fs.writeFileSync(file, html); continue; }

  const bodyClose = html.lastIndexOf("</body>");
  if (bodyClose >= 0) html = html.slice(0, bodyClose) + BLOCK + html.slice(bodyClose);
  else html = html + BLOCK;

  fs.writeFileSync(file, html);
  if (hadOld) patched++; else patched++;
}

console.log(`扫描 HTML: ${files.length}`);
console.log(`已写入/更新灯箱: ${patched}`);
console.log(`无图片跳过: ${noImg}`);
