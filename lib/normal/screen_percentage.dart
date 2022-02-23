import 'package:flutter/material.dart';

class ScreenSize
{
  late Height height;
  late Width width;

  ScreenSize(BuildContext context_){
    width = Width(maxWidth: MediaQuery.of(context_).size.width);
    height = Height(maxHeight: MediaQuery.of(context_).size.height);
  }

}

class Width
{
  double maxWidth;
  Width({required this.maxWidth});

  double sizeByPercent(double percent_){
    return maxWidth * percent_;
  }
}

class Height
{
  double maxHeight;
  Height({required this.maxHeight});

  double sizeByPercent(double percent_){
    return maxHeight * percent_;
  }
}