function show(c_Str)
{if(document.all(c_Str).style.display=='none')
{document.all(c_Str).style.display='block';}
else{document.all(c_Str).style.display='none';}}
function high(){
if (event.srcElement.className=="k"){
event.srcElement.style.background="336699"
event.srcElement.style.color="white"
}
}
function low(){
if (event.srcElement.className=="k"){
event.srcElement.style.background="99CCFF"
event.srcElement.style.color=""
}
}