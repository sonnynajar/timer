import ddf.minim.*;

PImage bg;
StopWatchTimer sw;
Minim minim;
AudioPlayer file;
boolean isRunning;
String timeToShow;

void setup() {
  //size(1600,950);
  fullScreen();
  bg = loadImage("thanksgiving.jpg");
  bg.resize(width,height);
  minim = new Minim(this);
  background(bg);
  isRunning = false;
}

void draw() {
  background(bg);
  currentTime();
  
  if (keyPressed == true){
    if (key == 's'){
      countdown();
      isRunning = true;
      sw = new StopWatchTimer();  
      sw.start();
    } else if (key == 'r'){
      isRunning = false;
    } else if (key == ' '){
      sw.stop();
    }
  }
}

void currentTime(){
  fill(255,140,0);
  textSize(400);
  textAlign(CENTER, CENTER);
  if (isRunning){
    timeToShow = nf(sw.minute(), 2)+":"+nf(sw.second(), 2)+":"+nf(sw.hundrensec(), 2);
  } else {
    timeToShow = "00:00:00";
  }
  text(timeToShow, width/2, height/2);
}

class StopWatchTimer {
  int startTime = 0, stopTime = 0;
  boolean running = false;  
    
    void start() {
        startTime = millis();
        running = true;
    }
    void stop() {
      if(running){
        stopTime = millis();
        running = false;
      }
    }
    int getElapsedTime() {
        int elapsed;
        if (running) {
             elapsed = (millis() - startTime);
        }
        else {
            elapsed = (stopTime - startTime);
        }
        return elapsed;
    }
    int hundrensec(){
      return (getElapsedTime() / 10) % 100; 
    } 
    int second(){
      return (getElapsedTime() / 1000) % 60;
    }
    int minute() {
      return (getElapsedTime() / (1000*60)) % 60;
    }
}

void countdown(){
  file = minim.loadFile("three.mp3");
  file.play();
  delay(1000);
  file = minim.loadFile("two.mp3");
  file.play();
  delay(1000);
  file = minim.loadFile("one.mp3");
  file.play();
  delay(1000);
  file = minim.loadFile("go.mp3");
  file.play();
}
