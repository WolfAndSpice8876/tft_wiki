import 'package:flutter/material.dart';

class Wrapping<T>
{
  Wrapping({required this.value});

  Wrapping.blank(){

  }

  T? value;
}