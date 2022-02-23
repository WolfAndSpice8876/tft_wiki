import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lol/contents/palette.dart' as Palette;
import 'package:lol/normal/size.dart';

final BoxShadow commonBoxShadow = BoxShadow(
  color: Colors.black.withOpacity(0.08),
  offset: Offset(size(2),size(2)),
  blurRadius: size(2),
);

final BoxShadow tftShadow = BoxShadow(
  color: Colors.black.withOpacity(0.15),
  offset: Offset(0,size(4)),
  blurRadius: size(4),
);

final BoxShadow profileShadow = BoxShadow(
  color: Colors.black.withOpacity(0.08),
  offset: Offset(4,4),
  blurRadius: 4,
);


final Border blankBorder = Border.all(color: Colors.white.withOpacity(0));


const Expanded expanded = Expanded(
  child: SizedBox(),
);

final BoxDecoration blankDecoration = BoxDecoration(
  border: Border.all(color: Colors.white.withOpacity(0))
);

BoxDecoration testBorder(){
  return BoxDecoration(
      border: Border.all(color: Colors.black, width: 2)
  );
}



hBox(double value_){
  return SizedBox(height: value_,);
}

wBox(double value_){
  return SizedBox(width: value_,);
}

void setSystemColor(Color statusBar_ , String overLayStyle_){

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: statusBar_));

  if(overLayStyle_ == "light"){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }else if(overLayStyle_ == "dark"){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }
}

ThemeData getScrollColor(BuildContext context_)
{
  return Theme.of(context_).copyWith(
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Palette.scrollColor),
  );
}


class User
{
  static final BoxShadow matchElementShadow = BoxShadow(
    color: Colors.black.withOpacity(0.15),
    offset: Offset(0,size(4)),
    blurRadius: size(4),
  );

  static final BoxShadow profileElementShadow = BoxShadow(
    color: Colors.black.withOpacity(0.08),
    offset: Offset(size(3),size(3)),
    blurRadius: size(3),
  );

}

class Main
{
  static BoxDecoration commonBox = BoxDecoration(
    color: Color(0xffEAEEF1),
    borderRadius: BorderRadius.circular(size(10))
  );

  static BoxDecoration commonShadowBox = BoxDecoration(
    color: Color(0xffEAEEF1),
    borderRadius: BorderRadius.circular(size(10)),
    boxShadow: [tftShadow]
  );
}

class Champions
{
  static BoxShadow commonShadow = BoxShadow(
    offset: Offset(0,4),
    blurRadius: 4,
    color: Colors.black.withOpacity(0.15),
  );
}
