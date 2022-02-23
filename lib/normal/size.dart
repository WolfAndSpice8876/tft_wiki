const double stdWidth = 360;
double screenWidth = 360;

double size(double size){
  return size * screenWidth / stdWidth;
}

void setSize(double screenWidth_){
  screenWidth = screenWidth_;
}