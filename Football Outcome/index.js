/* ranNum_1 gets the random score for Momb */
const k = document.getElementsByTagName("p")[0];
k.textContent = "Dortmund BvB";

const p = document.getElementsByTagName("p")[1];
p.textContent = "Manchester United";


/* ranNum_1 gets the random score for Mombasa */
ranNum_1 = Math.random();
ranNum_1 = ranNum_1 * 5;
ranNum_1 = Math.floor(ranNum_1);

/* ranNum_2 gets the random score for Nairobi */
ranNum_2 = Math.random();
ranNum_2 = ranNum_2 * 5;
ranNum_2 = Math.floor(ranNum_2);

var outcome;

if (ranNum_1 == ranNum_2) {
  var outcome = document.querySelector("h1");
  outcome.textContent = "Draw! No winner this time";
  outcome.style.color = "#9932CC";

} else if (ranNum_1 > ranNum_2) {

  var outcome = document.querySelector("h1");
  outcome.textContent = "Dortmund wins, Philip will be happy";
  outcome.style.color = "#483D8B";

} else if (ranNum_1 < ranNum_2) {

  var outcome = document.querySelector("h1");
  outcome.textContent = "Manchester United wins, Philip will be sad";
  outcome.style.color = "#7B68EE";
}



if (ranNum_1 == 0) {
  const i = document.getElementsByClassName("img1")[0];
  i.src = "images/0.png";
} else if (ranNum_1 == 1) {
  const i = document.getElementsByClassName("img1")[0];
  i.src = "images/1.png";
} else if (ranNum_1 == 2) {
  const i = document.getElementsByClassName("img1")[0];
  i.src = "images/2.png";
} else if (ranNum_1 == 3) {
  const i = document.getElementsByClassName("img1")[0];
  i.src = "images/3.png";
} else if (ranNum_1 == 4) {
  const i = document.getElementsByClassName("img1")[0];
  i.src = "images/4.png";
} else if (ranNum_1 == 5) {
  const i = document.getElementsByClassName("img1")[0];
  i.src = "images/5.png";
}



if (ranNum_2 == 0) {
  const i = document.getElementsByClassName("img2")[0];
  i.src = "images/0.png";
} else if (ranNum_2 == 1) {
  const i = document.getElementsByClassName("img2")[0];
  i.src = "images/1.png";
} else if (ranNum_2 == 2) {
  const i = document.getElementsByClassName("img2")[0];
  i.src = "images/2.png";
} else if (ranNum_2 == 3) {
  const i = document.getElementsByClassName("img2")[0];
  i.src = "images/3.png";
} else if (ranNum_2 == 4) {
  const i = document.getElementsByClassName("img2")[0];
  i.src = "images/4.png";
} else if (ranNum_2 == 5) {
  const i = document.getElementsByClassName("img2")[0];
  i.src = "images/5.png";
}
