import ddf.minim.*;
import processing.sound.*;

PImage bg;
StopWatchTimer sw;
Minim minim;
AudioPlayer file;
SoundFile song;
boolean isRunning;
String timeToShow, theme;

void setup() {
  size(800,600);
  //fullScreen();
  
  theme = "xmas";
  
  
  bg = loadImage("resources/" + theme + "/bg.jpg");
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
      file = minim.loadFile("resources/" + theme + "/songfast2.mp3");
      //file.rewind();
      file.loop();
      //song = new SoundFile(this, "C:\\Users\\rodav\\Documents\\Processing\\timer\\resources\\" + theme + "\\song.mp3");
      //song.loop(0.5);
      //song.rate(1.5);
    } else if (key == 'r'){
      isRunning = false;
    } else if (key == ' '){
      sw.stop();
      file.pause();
    }
  }
}

void currentTime(){
  fill(255);
  textSize(width/5);
  textAlign(CENTER, height/3);
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
  file = minim.loadFile("resources/three.mp3");
  file.play();
  delay(1000);
  file = minim.loadFile("resources/two.mp3");
  file.play();
  delay(1000);
  file = minim.loadFile("resources/one.mp3");
  file.play();
  delay(1000);
  file = minim.loadFile("resources/go.mp3");
  file.play();
}
