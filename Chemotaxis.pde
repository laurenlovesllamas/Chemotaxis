Walker[] ohio;

class Walker {
  //Three member variables = Object data
  int myX, myY, myColor, lifespan; //Color doesn't need to be three seperate integers, Processing complies integers into one unit
  //Four member functions
  //One special member is CONSTRUCTOR = Object setup
  //Whose job is to initalize member variables
  Walker() { //No arguments will start at the center, constructor
    //Walker sets up the member variables
    myX = width/2;
    myY = height/2;
    myColor = color(255, 255, 255);
    lifespan = (int)(Math.random()*500) + 100; //Random lifespan between 100 and 600
  }
  Walker(int x, int y) { //Overloading constructor, x and y coordinates
    myX = x;
    myY = y;
    myColor = color((int)(Math.random()*255), (int)(Math.random()*255), (int)(Math.random()*255)); //One for each integer
    lifespan = (int)(Math.random()*500) + 100;
  }

  void walk() {
    // Used to give the walker pull towards the cursor but still random movement
    float biasX = (mouseX- myX)/50.0;
    float biasY = (mouseY - myY)/50.0;

    myX += (int)((Math.random()*3)-1 + biasX); // -1, 0, 1
    myY += (int)((Math.random()*3)-1 + biasY); //Move up and down a little bit

    //Wrap around edges
    if (myX < 0) myX = width;
    if (myX > width) myX = 0;
    if (myY < 0) myY = height;
    if (myY > height) myY = 0;

    lifespan--; // Decrease lifespan
  }
  void show() {
    fill(myColor, lifespan * 0.5); //Color fades with lifespan
    ellipse(myX, myY, 10, 10);
  }
  // Reproduce: chance to spawn a new walker nearby
  Walker reproduce() {
    if (Math.random() < 0.01 && lifespan > 50) { // 1% chance to reproduce if lifespan > 50
      return new Walker(myX + (int)(Math.random() * 20 - 10), myY + (int)(Math.random() * 20 - 10));
    }
    return null;
  }

  // Check if the walker is still alive
  boolean isAlive() {
    return lifespan > 0;
  }
} //End of Walker class

void setup() {
  size(500, 500);
  //bob = new Walker(); //Creation of a single instance of the Walker Class
  ohio = new Walker[1000]; //First call to new, for new apartments
  //Stores a large number of walker objects
  for (int i = 0; i < ohio.length; i++) { //Second call to new, for each indivdual apartment
    //Initializes each element of the ohio array with a new walker object
    ohio[i] = new Walker((int)(Math.random()*width), (int)(Math.random()*height)); //Walkers move randomly
  }
}

void draw() {
  background(0); // Clear the screen for smoother animation

  // ArrayList to store new walkers from reproduction
  ArrayList<Walker> newWalkers = new ArrayList<>();

  for (int i = 0; i < ohio.length; i++) {
    if (ohio[i] != null) {
      ohio[i].walk();
      ohio[i].show();

      // Reproduce and add new walker to newWalkers list if applicable
      Walker offspring = ohio[i].reproduce();
      if (offspring != null) {
        newWalkers.add(offspring);
      }

      // Remove walkers that have died
      if (!ohio[i].isAlive()) {
        ohio[i] = null;
      }
    }
  }
  // Add new walkers to ohio array
  for (Walker newWalker : newWalkers) {
    for (int i = 0; i < ohio.length; i++) {
      if (ohio[i] == null) { // Add to the first empty spot
        ohio[i] = newWalker;
        break;
      }
    }
  }
}

//Setup and draw instantiates Walker
//Results in creation
//Walker bob; //Single instance
//Walker [] army = {new Walker(), new Walker(), new Walker(), new Walker()}; //Call constructor a bunch of times
//Walker [] ohio; //Declaration to contrast previous array

/*void draw() {
 bob.walk();
 bob.show();
 for (int i = 0; i < army.length; i++) { //Use for loop to access index of array
 army[i].walk();
 army[i].show();
 }
 for (int i = 0; i < ohio.length; i++) { //Use for loop to access
 ohio[i].walk();
 ohio[i].show();
 }
 }
 }*/

//"FAMES" stands for Fields, Actions, Methods, and Everything Else
//Fields (also called Attributes or Member Variables) are properties or data that describe the class (Ex: int my X, int mY)
//Actions (also called Methods or Functions) are behaviors or functions of the class (Ex: walk(), show())
//Methods (Constructors) are special methods used to create objects of a class (Ex: Walker(), Walker(int x, int y))
//They initalize the object's member variables (fields)
//Everything Else includes extra features or specific keywords that control access scope, or additional functionality
