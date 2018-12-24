import ddf.minim.*;

PImage bg;
StopWatchTimer swOne, swTwo;
Minim minim;
AudioPlayer file;
boolean isRunning;
String timeOne, timeTwo, theme;
String[] songs;
int r;

void setup() {
  size(800,600);
  //fullScreen();
  
  theme = "xmas";
  
  bg = loadImage("resources\\" + theme + "\\bg.jpg");
  bg.resize(width,height);
  minim = new Minim(this);
  background(bg);
  isRunning = false;
  songs = new String[] {"angeles", "belen", "burrito", "campana", "esfera", 
                        "falalala", "navidad", "noche", "peces", "rodolfo",
                        "santa", "tambor", "town"};
}

void draw() {
  background(bg);
  currentTime();
  
  if (keyPressed == true){
    if (key == 's'){
      countdown();
      isRunning = true;
      swOne = new StopWatchTimer();  
      swOne.start();
      swTwo = new StopWatchTimer();  
      swTwo.start();
      r = int(random(13));
      file = minim.loadFile("resources\\" + theme + "\\" + songs[r] + ".mp3");
      file.rewind();
      file.loop();
    } else if (key == 'r'){
      isRunning = false;
    } else if (key == ' '){
      swOne.stop();
    } else if (key ==  'b'){
      swTwo.stop();
      file.pause();
    }
  }
}

void currentTime(){
  fill(255);
  textSize(width/5);
  textAlign(CENTER, height/3);
  if (isRunning){
    timeOne = nf(swOne.minute(), 2)+":"+nf(swOne.second(), 2)+":"+nf(swOne.hundrensec(), 2);
    timeTwo = nf(swTwo.minute(), 2)+":"+nf(swTwo.second(), 2)+":"+nf(swTwo.hundrensec(), 2);
  } else {
    timeOne = "00:00:00";
    timeTwo = "00:00:00";
  }
  text(timeOne, width/2, height/3);
  text(timeTwo, width/2, 2*height/3);
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
  file = minim.loadFile("resources\\three.mp3");
  file.play();
  delay(1000);
  file = minim.loadFile("resources\\two.mp3");
  file.play();
  delay(1000);
  file = minim.loadFile("resources\\one.mp3");
  file.play();
  delay(1000);
  file = minim.loadFile("resources\\go.mp3");
  file.play();
}
