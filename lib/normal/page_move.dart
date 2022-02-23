
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class PageMove{
  // static move(BuildContext context_ , Widget page_){
  //   Navigator.push(context_, MaterialPageRoute(
  //       builder: (context){
  //         return page_;
  //       }
  //   ));
  // }

  static move(BuildContext context_ , Widget page_){
    Navigator.push(context_, PageTransition(type: PageTransitionType.rightToLeft, child: page_));
  }

  static moveWithAnime(BuildContext context_ , Widget page_ , PageTransitionType anime_ , Duration duration_){
    Navigator.push(context_, PageTransition(type: anime_, duration : duration_, child: page_));
  }

  static popMove(BuildContext context_ , Widget page_){
    Navigator.pop(context_);
    Navigator.push(context_, MaterialPageRoute(
        builder: (context){
          return page_;
        }
    ));
  }

  static newMove(BuildContext context_ , Widget page_){
    Navigator.pushNamedAndRemoveUntil(context_, '/', (_) => false);
    Navigator.push(context_, MaterialPageRoute(
        builder: (context){
          return page_;
        }
    ));
  }

  static back(BuildContext context_){
    Navigator.pop(context_);
  }

}