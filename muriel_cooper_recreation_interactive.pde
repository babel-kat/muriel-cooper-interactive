// Multiple Interaction Team (Exhibition cover), 1973, Muriel Cooper
// Written by Katerina Labrou
// For course MAS.S48: Recreating the past (MAS.S68), instr. Zach Lieberman
// Fall 2020


PFont font;

//text attributes
int txtSize = 48; // (width - 2*border - 19*charOffset) / 19
String phrase = "MULTIPLEINTERACTION";

//canvas setup
float fix = -6.5;
float border_x = fix;
int border_y = 73;
int y_step =  txtSize - int(txtSize/4 - 5); // y - step

float phraseWidth;
float phraseEnd = 0;

float easing = 0.6;
float posCurr[] = new float[19]; // interactive text positions/row
float posPrev[] = new float[19]; 
float target;

void setup(){
  size(646, 850);
  background(240, 234, 217);
  fill(0);
  font = createFont("Swiss-721-BT.ttf", txtSize);
  textFont(font);
  frameRate(30);
  
  for(int i=0; i<19 ; i++){
    text(phrase, width/2, i * y_step);
  }
  
  phraseWidth = textWidth(phrase);
  textAlign(RIGHT);
  phraseEnd = width - (width - phraseWidth)/2;
  target = 11 + phraseEnd;
  for(int i=0; i<19; i++) {
    posCurr[i] = target;
    posPrev[i] = posCurr[i];
  }
}

void draw(){
  background(240, 234, 217);
  smooth();
  textAlign(CENTER);
  pushMatrix();
  translate(border_x, border_y);
  
  // Draw 19 rows 
  for(int i=0; i<19 ; i++){
    text(phrase, width/2, i * y_step);
  }
  
  phraseWidth = textWidth(phrase);
  textAlign(RIGHT);
  phraseEnd = width - (width - phraseWidth)/2;
  
  for(int i=0; i<19 ; i++){
    //fill(255, 0, 0);
    //Aligh I with N
    if (mouseY > (i) * y_step && mouseY < (i + 1) * y_step){
      // map(value, current min, current max, target min, target max)
      posCurr[i] = map(mouseX, 11 + phraseEnd, width - phraseEnd, target, 500);
      text(phrase.substring(8), posCurr[i], i * y_step);
      println("in for i =", i);
      posPrev[i] = posCurr[i];
    } 
    else {
      if (posCurr[i] < target){
        posCurr[i] = posPrev[i] + easing;
      }
      text(phrase.substring(8), posCurr[i], i * y_step);
      //println(11 + phraseEnd); // 603.5
      posPrev[i] = posCurr[i];
    }
  }  
  popMatrix();
  
  saveFrame("recreation_###.png");
}
