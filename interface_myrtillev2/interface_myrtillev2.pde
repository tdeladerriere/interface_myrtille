import ddf.minim.*;
import controlP5.*;
import java.util.*;

Minim minim;
AudioPlayer radio;
ControlP5 cp5,cp6;

float gain = 0;
float volume;
static final int FADE = 300;

String CurrentStation = "http://direct.fipradio.fr/live/fip-midfi.mp3";
String[] stations = {"http://direct.fipradio.fr/live/fip-midfi.mp3", 
  "http://direct.franceinter.fr/live/franceinter-midfi.mp3",
  "http://e1-live-mp3-128.scdn.arkena.com/europe1.mp3",
  "http://novazz.ice.infomaniak.ch/novazz-128.mp3","http://direct.franceinfo.fr/live/franceinfo-midfi.mp3",
  "http://ice912.echo.msk.ru:9120/stream"};

void setup(){
  size(1920,1080);
  minim = new Minim(this);
  radio = minim.loadFile(CurrentStation,2048);
  radio.play();
  radio.setGain(gain);
  
  cp5 = new ControlP5(this);
  ControlFont cf1 = new ControlFont(createFont("TlwgTypewriter",28,true),28);
  cp5.setFont(cf1);
  List l = Arrays.asList("FIP", "Inter", "Europe1", "NOVA", "Info","Echo of Moscow");
  
  /* add a ScrollableList, by default it behaves like a DropdownList */
  
  cp5.addScrollableList("dropdown")
     .setPosition(width/8, height/4)
     .setSize(500, 400)
     .setBarHeight(50)
     .setItemHeight(50)
     .addItems(l);
  
  // OLD: volume slider (left aside because radio.getVolume, radio.setVolume and radio.shiftVolume don't work on minim)
  //cp6 = new ControlP5(this);
  //ControlFont cf2 = new ControlFont(createFont("TlwgTypewriter",28,true),28);
  //cp6.setFont(cf2);
  //cp6.addSlider("volume")
  // .setColorLabel(0)
  // .setColorValue(0)
  // .setPosition(5*width/8,height/4)
  // .setSize(50,300)
  // .setRange(0,100)
  // .setValue(50)
  // ;
  
  //PImage[] imgs = {loadImage("plus.png"),loadImage("minus.png")};
  
  cp6 = new ControlP5(this);
  ControlFont cf2 = new ControlFont(createFont("TlwgTypewriter",20,true),20);
  cp6.setFont(cf2);
  cp6.addButton("plus")
     .setValue(2)
     .setPosition(3*width/5,2*height/5)
     .setSize(75,75)
     ;  
  cp6.addButton("minus")
     .setValue(-3)
     .setPosition(3*width/5,3*height/5)
     .setSize(75,75)
     ;
  
}

void draw(){
  background(200); 
 
  //radio.shiftGain(radio.getGain(),gain,FADE);
  
}

void dropdown(int n){
  CurrentStation = stations[n];
  radio.pause();
  radio = minim.loadFile(CurrentStation,2048);
  radio.play();
  radio.setGain(gain);
}

public void plus(float increment){
  print(radio.getGain());
  radio.shiftGain(radio.getGain(),increment,FADE);
  gain = radio.getGain();
  //print(radio.getGain());
}

public void minus(float decrement){
  radio.shiftGain(radio.getGain(),decrement,FADE);
  gain = radio.getGain();
}

//void  volume(float level){
//  radio.shiftVolume(radio.getVolume(),level/100,FADE);
//  //radio.shiftGain(radio.getGain(),level/100,FADE);
//  println(level/100);
//}


void keyPressed()
{
  if ( radio.isPlaying() )
  {
    radio.pause();
  }
  // if the radio is at the end of the file,
  // we have to rewind it before telling it to play again
  else
  {
    radio.play();
  }
}
