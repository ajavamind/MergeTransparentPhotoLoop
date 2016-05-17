// Written by Andy Modla May, 2016
// Inspiration for this code from
// https://processing.org/discourse/beta/num_1212692440.html

final int TOP_LIMIT = 255; // 255 is max tint range;
final int BOTTOM_LIMIT = 128;

String top = "rDSC_1915_cr.jpg";
String bottom = "rDSC_1836.jpg";

PImage bottomImage;
PImage topImage;
int counter = TOP_LIMIT;
int direction = 1;
boolean stop = false;

void setup()
{
  size(700, 540);
  bottomImage = loadImage(bottom);
  topImage = loadImage(top);
  bottomImage.loadPixels();
  topImage.loadPixels();
  frameRate(30);
}

void draw() {
  if (!stop) {
    background(0);
    setTransparency(topImage, counter);
    // Display whole image
    image(topImage, 0, 0);

    setTransparency(bottomImage, TOP_LIMIT - counter);
    blend(bottomImage, 0, 0, bottomImage.width, bottomImage.height, 0, 0, bottomImage.width, bottomImage.height, SOFT_LIGHT);

    counter += direction;
    if (counter > TOP_LIMIT) {
      direction = -direction;
      counter += direction;
    } else if (counter < BOTTOM_LIMIT) {
      direction = -direction;
      counter += direction;
    }

    //if (frameCount < 256) {  // two cycles
    //saveFrame("frames/pond####.tif");
    //}

    // debug
    //println("counter="+ counter);
    //println("frame="+ frameCount);

    // stop when enough frames are made for video
    //if (frameCount >= 255)
    //  stop = true;
  }
}

void setTransparency(PImage pi, int transparency)
{
  transparency <<= 24;
  for (int i = 0; i < pi.width; i++)
  {
    for (int j = 0; j < pi.height; j++)
    {
      color c = pi.pixels[i + j * pi.width];
      c = c & 0x00FFFFFF | transparency;
      pi.pixels[i + j * pi.width] = c;
    }
  }
}