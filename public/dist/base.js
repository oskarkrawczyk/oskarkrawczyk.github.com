(function(){var e,t,i,n,a,c;c=0,t=0,e=0,n=!1,i=function(){return navigator.userAgent.indexOf("AppleWebKit")===-1},a=function(n,a){var r,d;if(r=n.getBoundingClientRect(),e=document.body.scrollHeight,c=r.top+r.height/2,t=r.left+r.width/2,d="circle(0px at "+t+"px "+c+"px)",a.style["-webkit-clip-path"]=d,a.style.height=e+"px",i())return a.classList.add("hidden")},window.addEventListener("DOMContentLoaded",function(){var r,d,s;return d=document.querySelector(".mail"),s=document.querySelector(".mailSpander"),i()&&s.classList.add("fallback"),a(d,s),d.addEventListener("click",function(r){return r.stopPropagation(),r.preventDefault(),n?(n=!1,d.classList.remove("active"),a(d,s)):(n=!0,d.classList.add("active"),s.style["-webkit-clip-path"]="circle("+2*e+"px at "+t+"px "+c+"px)",i()?s.classList.remove("hidden"):void 0)}),window.addEventListener("resize",function(){return a(d,s)}),r=new Instafeed({get:"user",userId:"427572618",accessToken:"427572618.33afb76.1c728966039a493dbeb18c73401daba3",limit:4}),r.run()})}).call(this);