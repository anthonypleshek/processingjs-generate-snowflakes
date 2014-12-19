var MAX_DEPTH = 2;
var currentDepth = 0;
var list = new Array();
var noiseOffset = 8888;
var rotationOffset = 30;
var noiseStartVal;

var bgColor = color(0);
var strokeColor = color(255,10);

void setup() {
  size(400,400);
  
  stroke(strokeColor);
  
  initialize();
}

void initialize() {
  background(bgColor);
  list = new Array();
  
  var start = {};
  start.depth = 0;
  start.counter = 0;
  start.maxLength = width/2-20;
  start.startLoc = new PVector(width/2,height/2);
  list.push(start);
  
  noiseStartVal = noise(noiseOffset);
}

void mousePressed() {
  initialize();
}

void draw() {
  var expand = false;
  var expandLength = 0;
  if(list.length > 0) {
    var firstItem = list[list.length-1];
    var noiseVal = noise(noiseOffset+firstItem.counter);
    currentDepth = firstItem.depth;
    if(currentDepth < MAX_DEPTH && random(1) > .965) {
      expand = true;
//      expandLength = noise(noiseOffset+list[list.length-1].counter)*abs(list[list.length-1].maxLength/2-list[list.length-1].counter);
      expandLength = firstItem.maxLength/2-abs(firstItem.maxLength/2-firstItem.counter);
    }
  }
  
  for(int i=list.length-1; i>=0; i--) {
    var item = list[i];
    if(item.counter < item.maxLength) {
      if(expand) {
        for(int j=0; j<6; j++) {
          var newStart = {};
          newStart.depth = item.depth+1;
          newStart.counter = 0;
          newStart.maxLength = expandLength;
          newStart.startLoc = new PVector(item.startLoc.x+item.counter*cos(radians(60*j+rotationOffset)),item.startLoc.y+item.counter*sin(radians(60*j+rotationOffset)));
          list.push(newStart);
        }
      }
      drawHexagonally(item.startLoc,item.counter);
      item.counter += .4;
    } else {
      //Remove this item from the list
      list.splice(i,1);
    }
  }
  
//  rotationOffset += .7;
}

void drawHexagonally(PVector startLoc, var distanceFromCenter) {
  for(int i=0; i<6; i++) {
    pushStyle();
    translate(startLoc.x,startLoc.y);
    rotate(radians(60*i+rotationOffset));
    line(0,0,distanceFromCenter,0);
    popStyle();
  }
}
