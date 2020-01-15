import ddf.minim.*;
import ddf.minim.signals.*;
import controlP5.*;
import java.util.*;
import javax.sound.sampled.*;
import ddf.minim.ugens.*;

Minim minim;
Sampler sampler;
MultiChannelBuffer sampleBuffer;
AudioOutput out;
Mixer.Info[] mixerInfo;
AudioPlayer radio;

ControlP5 cp5,cp6,exitbutton;

PFont title,stationfont,tabfont;
PImage bg;

float gain = 0;
float volume;
static final int FADE = 100;
String r;

String CurrentStation = "http://direct.fipradio.fr/live/fip-midfi.mp3";
String[] stations = {"http://direct.fipradio.fr/live/fip-midfi.mp3", 
  "http://direct.franceinter.fr/live/franceinter-midfi.mp3",
  "http://e1-live-mp3-128.scdn.arkena.com/europe1.mp3",
  "http://novazz.ice.infomaniak.ch/novazz-128.mp3","http://direct.franceinfo.fr/live/franceinfo-midfi.mp3",
  "http://ice912.echo.msk.ru:9120/stream"};

void setup(){
  // Used later to display a random wallpaper
  r = Integer.toString(int(random(1,6)));
  
  size(1920,1080);
  minim = new Minim(this);
  mixerInfo = AudioSystem.getMixerInfo();
  
  for(int i = 0; i < mixerInfo.length; i++)
  {println(i + " = " + mixerInfo[i].getName());} 
  
  
  // 0 pour PC limbothai, 6 pour RPI
  Mixer mixer = AudioSystem.getMixer(mixerInfo[6]);
  minim.setOutputMixer(mixer);
  out = minim.getLineOut();
  
  // CONTINUER ICI: convertir stream en format interprétable par la carte ! courant PCM_SIGNED 48000.0 Hz 16bits stereo 4 bytes/frame, little-endian NOT SUPPORTED
  //AudioFormat af = new AudioFormat( (float )44100, 16, 1, true, false );
  // UNE PISTE : https://www.programcreek.com/java-api-examples/javax.sound.sampled.AudioFormat
  
  //sampleBuffer = new MultiChannelBuffer(1,2048); 
  radio = minim.loadFile(CurrentStation,2048);
  
  radio.play();
  radio.setGain(gain);
  
  CColor moonestoneblue = new CColor();
  moonestoneblue.setBackground(color(0,21,56));
  CColor azureishwhite = new CColor();
  azureishwhite.setBackground(color(211,243,238));
  CColor sandstorm = new CColor();
  sandstorm.setBackground(color(218,204,62));
  CColor cornellred = new CColor();
  cornellred.setBackground(color(188,44,26));
  CColor claret = new CColor();
  claret.setBackground(color(125,21,56));
  
  
  cp5 = new ControlP5(this);
  stationfont = createFont("stationsfont.ttf",32);
  ControlFont cf1 = new ControlFont(stationfont,28);
  cp5.setFont(cf1);
  List l = Arrays.asList("  FIP", "  Inter", "  Europe1", "  NOVA", "  Info","  Echo of Moscow");
  
     
  
  
  /* add a ScrollableList, by default it behaves like a DropdownList */
  
  cp5.addScrollableList("dropdown")
     .setPosition(200, 300)
     .setLabel("  Choose your station, Honey")
     .setColor(sandstorm)
     .setColorLabel(0)
     .setColorValue(100)
     .setSize(384*2, 600)
     .setBarHeight(75)
     .setItemHeight(70)
     .addItems(l);
  
  
  PImage[] imgs = {loadImage("play2.png"),loadImage("pause2.png"),loadImage("plus2.png"),loadImage("minus2.png")};
  
  cp6 = new ControlP5(this);
  ControlFont cf2 = new ControlFont(stationfont,20);
  cp6.setFont(cf2);
  
  cp6.getTab("default")
    .setHeight(50)
    .setColorActive(color(218,204,62))
    .setColorBackground(color(125,21,56))
    ;
  
  cp6.addTab("settings")
     .setColorLabel(color(255))
     .setHeight(50)
     .setColorActive(color(218,204,62))
     .setColorBackground(color(125,21,56))
     ;
  
  cp6.getTab("default")
     .activateEvent(true)
     .setLabel("Dashboard")
     .setId(1)
     ;

  cp6.getTab("settings")
     .activateEvent(true)
     .setId(2)
     ;
  
  cp6.addButton("plus")
     .setValue(1)
     .setImage(imgs[2])
     //.setLabel("+")
     //.setColor(claret)
     .setPosition(384*2+100+400,500)
     .setSize(100,100)
     ;  
  cp6.addButton("minus")
     .setValue(-1)
     .setImage(imgs[3])
     //.setLabel("-")
     //.setColor(claret)
     .setPosition(384*2+250+400,500)
     .setSize(100,100)
     ;
     
   cp6.addButton("play")
   .setColor(cornellred)
   .setImage(imgs[0])
   .setPosition(384*2+100+400,350)
   .setSize(imgs[0])
   ;
   
   cp6.addButton("pause")
   .setColor(cornellred)
   .setImage(imgs[1])
   .setPosition(384*2+250+400,350)
   .setSize(imgs[1])
   ;
   
  bg = loadImage("wallpaper"+r+".jpg");
  
  exitbutton = new ControlP5(this);
  exitbutton.setFont(cf2);
  exitbutton.addButton("exit")
  .setLabel("X")
  .setColor(cornellred)
  .setPosition(width-50,0)
  .setSize(50,50)
  ;
  
  cp5.getController("dropdown").moveTo("global");
  cp6.getController("plus").moveTo("default");
  cp6.getController("minus").moveTo("default");
  cp6.getController("play").moveTo("default");
  cp6.getController("pause").moveTo("default");
  exitbutton.getController("exit").moveTo("global");

  
}

// TO DO: show hide control panel (dark mode on/off, veille

void draw(){
  background(bg);
  
  title = createFont("titlefont.ttf",32);
  textFont(title);
  textSize(150);
  textAlign(CENTER);
  fill(255,255,255);
  text("Myrtille Wonderland",width/2,200);
  
  fill(125,21,56); 
  noStroke();
  rect(384*2+100+400-40,350-40, 330, 330,30);
  
  fill(218,204,62);  // Set fill to claret
  noStroke();
  rect(190,290,384*2+20, 500+20,30);
  
  
  //background(211,243,238); 
  // Default rectMode is CORNER
  //fill(194,232,18);;  // Set fill to white
  //noStroke();
  //rect(0, 0, width/5, height);
  
  //fill(145,245,173);;  // Set fill to white
  //noStroke();
  //rect(384, 0, width/5, height);
  
  
  //fill(139,158,183);;  // Set fill to white
  //noStroke();
  //rect(384*2, 0, width/5, height);
  
  //fill(116,82,150);;  // Set fill to white
  //noStroke();
  //rect(384*3, 0, width/5, height);
 
  //fill(125,21,56);;  // Set fill to white
  //noStroke();
  //rect(384*4, 0, width/5, height);
 
  //radio.shiftGain(radio.getGain(),gain,FADE);
  
}


void controlEvent(ControlEvent theControlEvent) {
  if (theControlEvent.isTab()) {
    println("got an event from tab : "+theControlEvent.getTab().getName()+" with id "+theControlEvent.getTab().getId());
  }
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
  radio.shiftGain(radio.getGain(),radio.getGain()+increment,FADE);
  gain = radio.getGain();
  //print(radio.getGain());
}

public void minus(float decrement){
  radio.shiftGain(radio.getGain(),radio.getGain()+decrement,FADE);
  gain = radio.getGain();
}

public void play(){
  radio.play();
}

public void pause(){
  radio.pause();
}
  


void exitbutton(){
  exit();
}
