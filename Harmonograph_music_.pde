
float nx;
float ny;
float x;
float y;
//time variable 
float t=0;
//amplitudes for x
float a1;
float a2 = 0;
//amplitude for y
float a3;
float a4 = 0;
//Frequencies for x 
float f1 = 8; 
float f2 = 6; 
//Frequencies for y 
float f3 = 4;
float f4 = 3;
//Phases for x 
float p1 = 0;
float p2 = 0; 
//Phases for y
float p3 = 0;
float p4 = 0; 
//dampening constants
float d1= .001;
float d2 = .005;
float d3 = .01;
float d4 = .005;
//base frequency for each beat 
float[] base_frequencies = {493.880, 293.660, 392.000, 466.160, 233.080, 
  311.130, 155.560, 155.560, 392.000, 466.160, 311.130, 92.499, 92.499, 246.94, 
  174.610, 233.080, 233.080, 155.560, 220.000, 146.830, 293.660, 392.000, 277.180, 
  369.990, 369.990, 493.880, 349.230, 466.160, 466.160, 311.130, 311.130, 277.180
};
String[] intervals = {"Perfect 5th", "Octave", "Major 3rd", "Major 7th", "Octave", "Perfect 5th", "Major 2nd",
"Perfect 5th", "Perfect 5th", "Octave", "Major 3rd", "Major 6th", "Octave", "Perfect 5th", "Major 2nd", "Perfect 5th", "Octave",
"Perfect 5th", "Major 2nd", "Perfect 5th", "Octave", "Perfect 5th", "Major 2nd", "Minor 6th", "Octave", "Tritone/Augmented 4th",
"Major 2nd", "Major 6th", "Octave", "Minor 2nd", "Minor 2nd", "Diminished 4th"};
//x multiplier for ratio 
int[] xratio = {3, 2, 5, 7, 2, 3, 9, 3, 3, 2, 5, 5, 2, 3, 9, 3, 2, 3, 9, 3, 2, 3, 9, 8, 2, 7, 9, 5, 2, 16, 16, 4};
//y multiplier for ratio
int[] yratio = {2, 1, 4, 4, 1, 2, 8, 2, 2, 1, 4, 3, 1, 2, 8, 2, 1, 2, 8, 2, 1, 2, 8, 5, 1, 5, 8, 3, 1, 15, 15, 1};
//index counter for harmonic ratio stuff
int a = 0;
void setup() {
  //adjusts how many times draw() executes per second 
  frameRate(15);
  size(1000, 1000);
  background(0);
  x = width/2;
  y = height/2;
  a1 = a3 = 150;
  for(float n:base_frequencies){
    print(n + ",");
  }  
}
void draw() {
  if(a == 31){
    text("End of Song, Click 'r' to restart", 10, 300);
    noLoop();
  }  
  float r = random(255);
  float g = random(255);
  float b = random(255);
  color c = color(r, g, b);
  //stroke(r,g,b);
  stroke(255);
  textSize(32);
  //measure number string
  int textA = a + 1;
  String mNum = "Beat Number: " + textA;
  text(mNum,50, width/2);
  text("press 'a' to move to the next measure", 50, 100);
  text("press 'space' to pause the drawing", 50, 140);
  text("ratio: " + xratio[a] + "/" + yratio[a], 50, 800);
  text("interval: " + intervals[a], 50, 740);
  drawRatio();
  //gets euler's number 
  nx = width/2 + a1*cos(f1*t + p1)*exp(-d1*t) + a2*cos(f2*t + p2)*exp(-d2*t);
  ny = height/2 + a3*sin(f3*t + p3)*exp(-d3*t) + a4*sin(f4*t + p4)*exp(-d4*t);
  //print("x:" + nx);
  //print("y" + ny);
  if (t==0) {
    stroke(0);
  }
  line(x, y, nx, ny);
  //setting line position to be the current x and y positions so the line is drawn from the last loops coordinates 
  //to this one and you get a clean curve
  x = nx;
  y = ny;
  //increase time every draw at a rate of framerate
  t = t+.01;
  //print(t);
  float bf = .5;
}
void drawRatio() {
  if(a < base_frequencies.length){
    f1 = f2 = xratio[a]*base_frequencies[a];
    f3 = f4 = yratio[a]*base_frequencies[a];
  }  
}  
void keyPressed(){
  //space bar 
  if(keyCode == 32){
    if (looping) noLoop();
    else loop();
  }
  //'a' key
  if(keyCode == 65){
    background(0);
    a++;
  } 
  // 'r' key
  if(keyCode == 82){
    background(0);
    a = 0;
    loop();
  }  
}  
