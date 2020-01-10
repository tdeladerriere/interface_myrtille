/**
 * ControlP5 ScrollableList
 *
 * replaces DropdownList and and ListBox. 
 * List can be scrolled by dragging the list or using the scroll-wheel. 
 *
 * by Andreas Schlegel, 2014
 * www.de/libraries/controlp5
 *
 */


import controlP5.*;
import java.util.*;
import processing.sound.*;


ControlP5 cp5,cp6;
Sound s;

float Volume = 0.5;
String CurrentStation = "http://direct.fipradio.fr/live/fip-midfi.mp3";

String[] stations = {"http://direct.fipradio.fr/live/fip-midfi.mp3", 
  "http://direct.franceinter.fr/live/franceinter-midfi.mp3",
  "http://e1-live-mp3-128.scdn.arkena.com/europe1.mp3",
  "http://novazz.ice.infomaniak.ch/novazz-128.mp3","http://direct.franceinfo.fr/live/franceinfo-midfi.mp3",
  "http://ice912.echo.msk.ru:9120/stream"};


void setup() {
  size(1920,1080);
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
   
  ControlFont cf2 = new ControlFont(createFont("TlwgTypewriter",28,true),28);
  cp6 = new ControlP5(this);
  cp6.setFont(cf2);
  cp6.addSlider("Volume")
   .setColorLabel(0)
   .setColorValue(0)
   .setPosition(5*width/8,height/4)
   .setSize(50,300)
   .setRange(0,100)
   .setValue(50)
   ;

  

  //// Plays a sample sin osc
  //SinOsc sin = new SinOsc(this);
  //sin.play(200, 0.2);
  //sin = new SinOsc(this);
  //sin.play(205, 0.2);

  s = new Sound(this);
  //println(s.list());
  //s.outputDevice(1);
}


void draw() {
  background(240);
  
  s.volume(Volume/100);
  //fill(Volume);
  //rect(0,0,width,100);
  
}

void dropdown(int n) {
  /* request the selected item based on index n */

  //println(stations.get(n), cp5.get(ScrollableList.class, "dropdown").getItem(n));
  
  CurrentStation = stations[n];
  //print(CurrentStation);
  //println(cp5.get(ScrollableList.class, "dropdown").getItem(n));
   
  // Changes color of line when already selected before
  //CColor c = new CColor();
  //c.setBackground(color(255,0,0));
  //cp5.get(ScrollableList.class, "dropdown").getItem(n).put("color", c);
  
  exec("bash","/home/limbothai/sketchbook/interface_myrtille/kill_vlc.sh");
  delay(300);
  exec("/usr/bin/cvlc",CurrentStation, "--gain","0.5");
  
}



/*
a list of all methods available for the ScrollableList Controller
use ControlP5.printPublicMethodsFor(ScrollableList.class);
to print the following list into the console.

You can find further details about class ScrollableList in the javadoc.

Format:
ClassName : returnType methodName(parameter type)


controlP5.Controller : CColor getColor() 
controlP5.Controller : ControlBehavior getBehavior() 
controlP5.Controller : ControlWindow getControlWindow() 
controlP5.Controller : ControlWindow getWindow() 
controlP5.Controller : ControllerProperty getProperty(String) 
controlP5.Controller : ControllerProperty getProperty(String, String) 
controlP5.Controller : ControllerView getView() 
controlP5.Controller : Label getCaptionLabel() 
controlP5.Controller : Label getValueLabel() 
controlP5.Controller : List getControllerPlugList() 
controlP5.Controller : Pointer getPointer() 
controlP5.Controller : ScrollableList addCallback(CallbackListener) 
controlP5.Controller : ScrollableList addListener(ControlListener) 
controlP5.Controller : ScrollableList addListenerFor(int, CallbackListener) 
controlP5.Controller : ScrollableList align(int, int, int, int) 
controlP5.Controller : ScrollableList bringToFront() 
controlP5.Controller : ScrollableList bringToFront(ControllerInterface) 
controlP5.Controller : ScrollableList hide() 
controlP5.Controller : ScrollableList linebreak() 
controlP5.Controller : ScrollableList listen(boolean) 
controlP5.Controller : ScrollableList lock() 
controlP5.Controller : ScrollableList onChange(CallbackListener) 
controlP5.Controller : ScrollableList onClick(CallbackListener) 
controlP5.Controller : ScrollableList onDoublePress(CallbackListener) 
controlP5.Controller : ScrollableList onDrag(CallbackListener) 
controlP5.Controller : ScrollableList onDraw(ControllerView) 
controlP5.Controller : ScrollableList onEndDrag(CallbackListener) 
controlP5.Controller : ScrollableList onEnter(CallbackListener) 
controlP5.Controller : ScrollableList onLeave(CallbackListener) 
controlP5.Controller : ScrollableList onMove(CallbackListener) 
controlP5.Controller : ScrollableList onPress(CallbackListener) 
controlP5.Controller : ScrollableList onRelease(CallbackListener) 
controlP5.Controller : ScrollableList onReleaseOutside(CallbackListener) 
controlP5.Controller : ScrollableList onStartDrag(CallbackListener) 
controlP5.Controller : ScrollableList onWheel(CallbackListener) 
controlP5.Controller : ScrollableList plugTo(Object) 
controlP5.Controller : ScrollableList plugTo(Object, String) 
controlP5.Controller : ScrollableList plugTo(Object[]) 
controlP5.Controller : ScrollableList plugTo(Object[], String) 
controlP5.Controller : ScrollableList registerProperty(String) 
controlP5.Controller : ScrollableList registerProperty(String, String) 
controlP5.Controller : ScrollableList registerTooltip(String) 
controlP5.Controller : ScrollableList removeBehavior() 
controlP5.Controller : ScrollableList removeCallback() 
controlP5.Controller : ScrollableList removeCallback(CallbackListener) 
controlP5.Controller : ScrollableList removeListener(ControlListener) 
controlP5.Controller : ScrollableList removeListenerFor(int, CallbackListener) 
controlP5.Controller : ScrollableList removeListenersFor(int) 
controlP5.Controller : ScrollableList removeProperty(String) 
controlP5.Controller : ScrollableList removeProperty(String, String) 
controlP5.Controller : ScrollableList setArrayValue(float[]) 
controlP5.Controller : ScrollableList setArrayValue(int, float) 
controlP5.Controller : ScrollableList setBehavior(ControlBehavior) 
controlP5.Controller : ScrollableList setBroadcast(boolean) 
controlP5.Controller : ScrollableList setCaptionLabel(String) 
controlP5.Controller : ScrollableList setColor(CColor) 
controlP5.Controller : ScrollableList setColorActive(int) 
controlP5.Controller : ScrollableList setColorBackground(int) 
controlP5.Controller : ScrollableList setColorCaptionLabel(int) 
controlP5.Controller : ScrollableList setColorForeground(int) 
controlP5.Controller : ScrollableList setColorLabel(int) 
controlP5.Controller : ScrollableList setColorValue(int) 
controlP5.Controller : ScrollableList setColorValueLabel(int) 
controlP5.Controller : ScrollableList setDecimalPrecision(int) 
controlP5.Controller : ScrollableList setDefaultValue(float) 
controlP5.Controller : ScrollableList setHeight(int) 
controlP5.Controller : ScrollableList setId(int) 
controlP5.Controller : ScrollableList setImage(PImage) 
controlP5.Controller : ScrollableList setImage(PImage, int) 
controlP5.Controller : ScrollableList setImages(PImage, PImage, PImage) 
controlP5.Controller : ScrollableList setImages(PImage, PImage, PImage, PImage) 
controlP5.Controller : ScrollableList setLabel(String) 
controlP5.Controller : ScrollableList setLabelVisible(boolean) 
controlP5.Controller : ScrollableList setLock(boolean) 
controlP5.Controller : ScrollableList setMax(float) 
controlP5.Controller : ScrollableList setMin(float) 
controlP5.Controller : ScrollableList setMouseOver(boolean) 
controlP5.Controller : ScrollableList setMoveable(boolean) 
controlP5.Controller : ScrollableList setPosition(float, float) 
controlP5.Controller : ScrollableList setPosition(float[]) 
controlP5.Controller : ScrollableList setSize(PImage) 
controlP5.Controller : ScrollableList setSize(int, int) 
controlP5.Controller : ScrollableList setStringValue(String) 
controlP5.Controller : ScrollableList setUpdate(boolean) 
controlP5.Controller : ScrollableList setValue(float) 
controlP5.Controller : ScrollableList setValueLabel(String) 
controlP5.Controller : ScrollableList setValueSelf(float) 
controlP5.Controller : ScrollableList setView(ControllerView) 
controlP5.Controller : ScrollableList setVisible(boolean) 
controlP5.Controller : ScrollableList setWidth(int) 
controlP5.Controller : ScrollableList show() 
controlP5.Controller : ScrollableList unlock() 
controlP5.Controller : ScrollableList unplugFrom(Object) 
controlP5.Controller : ScrollableList unplugFrom(Object[]) 
controlP5.Controller : ScrollableList unregisterTooltip() 
controlP5.Controller : ScrollableList update() 
controlP5.Controller : ScrollableList updateSize() 
controlP5.Controller : String getAddress() 
controlP5.Controller : String getInfo() 
controlP5.Controller : String getName() 
controlP5.Controller : String getStringValue() 
controlP5.Controller : String toString() 
controlP5.Controller : Tab getTab() 
controlP5.Controller : boolean isActive() 
controlP5.Controller : boolean isBroadcast() 
controlP5.Controller : boolean isInside() 
controlP5.Controller : boolean isLabelVisible() 
controlP5.Controller : boolean isListening() 
controlP5.Controller : boolean isLock() 
controlP5.Controller : boolean isMouseOver() 
controlP5.Controller : boolean isMousePressed() 
controlP5.Controller : boolean isMoveable() 
controlP5.Controller : boolean isUpdate() 
controlP5.Controller : boolean isVisible() 
controlP5.Controller : float getArrayValue(int) 
controlP5.Controller : float getDefaultValue() 
controlP5.Controller : float getMax() 
controlP5.Controller : float getMin() 
controlP5.Controller : float getValue() 
controlP5.Controller : float[] getAbsolutePosition() 
controlP5.Controller : float[] getArrayValue() 
controlP5.Controller : float[] getPosition() 
controlP5.Controller : int getDecimalPrecision() 
controlP5.Controller : int getHeight() 
controlP5.Controller : int getId() 
controlP5.Controller : int getWidth() 
controlP5.Controller : int listenerSize() 
controlP5.Controller : void remove() 
controlP5.Controller : void setView(ControllerView, int) 
controlP5.ScrollableList : List getItems() 
controlP5.ScrollableList : Map getItem(String) 
controlP5.ScrollableList : Map getItem(int) 
controlP5.ScrollableList : ScrollableList addItem(String, Object) 
controlP5.ScrollableList : ScrollableList addItems(List) 
controlP5.ScrollableList : ScrollableList addItems(Map) 
controlP5.ScrollableList : ScrollableList addItems(String[]) 
controlP5.ScrollableList : ScrollableList clear() 
controlP5.ScrollableList : ScrollableList close() 
controlP5.ScrollableList : ScrollableList open() 
controlP5.ScrollableList : ScrollableList removeItem(String) 
controlP5.ScrollableList : ScrollableList removeItems(List) 
controlP5.ScrollableList : ScrollableList setBackgroundColor(int) 
controlP5.ScrollableList : ScrollableList setBarHeight(int) 
controlP5.ScrollableList : ScrollableList setBarVisible(boolean) 
controlP5.ScrollableList : ScrollableList setItemHeight(int) 
controlP5.ScrollableList : ScrollableList setItems(List) 
controlP5.ScrollableList : ScrollableList setItems(Map) 
controlP5.ScrollableList : ScrollableList setItems(String[]) 
controlP5.ScrollableList : ScrollableList setOpen(boolean) 
controlP5.ScrollableList : ScrollableList setScrollSensitivity(float) 
controlP5.ScrollableList : ScrollableList setType(int) 
controlP5.ScrollableList : boolean isBarVisible() 
controlP5.ScrollableList : boolean isOpen() 
controlP5.ScrollableList : int getBackgroundColor() 
controlP5.ScrollableList : int getBarHeight() 
controlP5.ScrollableList : int getHeight() 
controlP5.ScrollableList : void controlEvent(ControlEvent) 
controlP5.ScrollableList : void keyEvent(KeyEvent) 
controlP5.ScrollableList : void setDirection(int) 
controlP5.ScrollableList : void updateItemIndexOffset() 
java.lang.Object : String toString() 
java.lang.Object : boolean equals(Object) 

created: 2015/03/24 12:21:22

*/
