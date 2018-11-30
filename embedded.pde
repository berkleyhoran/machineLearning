int generation = 0;
int children = 500;
int solved = 0;
float[] positionx = new float[children];
float[] positiony = new float[children];
float[] mutatex = new float[children];
float[] mutatey = new float[children];
float[] directionx = new float[children];
float[] directiony = new float[children];
float[] distance = new float[children];
float[] score = new float[children];
float[] color1 = new float[children];
float[] color2 = new float[children];
float[] color3 = new float[children];
float bestscore;
int bestchild = 0;
float bestmutatex = 0;
float bestmutatey = 0;
float speed = 5;
float mutationrate = .005;
int count;

//goal location
float answerx = random(400, 750);
float answery = random(400, 750);




void setup(){
  size(800,800);
  frameRate(60);
  
  
  //color of species
  //initial mutation
  for(int c = 0; c < children; c++){
    
    positionx[c] = 200;
    positiony[c] = 200;
    
    mutatex[c] = random(-mutationrate,mutationrate);
    mutatey[c] = random(-mutationrate,mutationrate);
    
    color1[c] = random(0,255);
    color2[c] = random(0,255);
    color3[c] = random(0,255);
  }
}

void draw(){
  
  background(255);
  
  //init
  data();
  test();
  
  //render
  rect(answerx, answery, 10, 10);
  
  //make children
  for(int c = 0; c < children; c++){
    
      //random color
      fill(color1[c],color2[c],color3[c]);
      
      //render lil boy
      rect(positionx[c],positiony[c],10,10);
    
      //determine running direction
      directionx[c] = random(-1,1) + mutatex[c];
      directiony[c] = random(-1,1) + mutatey[c];
      
      //act upon direction
      positionx[c] += speed*directionx[c];
      positiony[c] += speed*directiony[c];
      
      
      if(distance[c] < 10){
        kill();
      }
  
  
}

}

void test(){
  
  
  //test children to see if suitable for rebreed
  for(int c = 0; c < children; c++){
    distance[c] = round(dist(positionx[c],positiony[c],answerx,answery));
    score[c] = 1000-distance[c];
    bestscore = max(score);
  }
}

void kill(){
  
  for(int c = 0; c < children; c++){
    
    //get index of best child
    if(bestscore == score[c]){
      bestchild = c;
    }
    
    
  }
  
    bestmutatex = mutatex[bestchild];
    bestmutatey = mutatey[bestchild];

  
  //reset all to 0,0
  for(int c = 0; c < children; c++){
    
    positionx[c] = 200;
    positiony[c] = 200;
  
    color1[c] = random(color1[bestchild]-1,color1[bestchild]+1);
    color2[c] = random(color2[bestchild]-1,color2[bestchild]+1);
    color3[c] = random(color3[bestchild]-1,color3[bestchild]+1);
    
    
    
    mutatex[c] = random(bestmutatex - .1,bestmutatex + .1);
    mutatey[c] = random(bestmutatey - .1,bestmutatey + .1);
  
  }
  
}

void keyPressed() {
    if (key == 'b' || key == 'B') {
      kill();
    }
}


void data(){
  //text on screen
  textSize(32);
  fill(0, 102, 153, 51);
  text("score :" + bestscore, 550, 60); 
  text("count : " + count, 550, 90); 
  text("bchild :" + bestmutatex, 550, 120); 
  text("bmut :" + mutatex[bestchild], 550, 150); 
}