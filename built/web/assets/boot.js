"use strict";let e=new URL(location.href).host.split(".")[0],t=navigator.language.split("-")[0];/^(en|ja)$/.test(t)||(t="en");const i=navigator.userAgent.toLowerCase(),n=/mobile|iphone|ipad|android/.test(i),a=document.getElementsByTagName("head")[0];if(n){const e=document.createElement("meta");e.setAttribute("name","viewport"),e.setAttribute("content",[["width","device-width"],["initial-scale","1"],["minimum-scale","1"],["maximum-scale","1"],["user-scalable","no"]].map(e=>e.join("=")).join(",")),a.appendChild(e)}"misskey"==e&&(e=n?"mobile":"desktop");const s=document.createElement("script");s.setAttribute("src",`/assets/${e}.0.0.1902-2.${t}.js`),s.setAttribute("async","true"),s.setAttribute("defer","true"),a.appendChild(s);