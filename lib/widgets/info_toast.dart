import 'package:flutter/material.dart';
import 'package:lol/normal/size.dart';
import 'package:oktoast/oktoast.dart';

class InfoToast
{
  static show(String text_){
    showToastWidget(
      Padding(
        padding: EdgeInsets.only(bottom: size(60)),
        child: Container(
          height: size(48),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size(20)),
              color: Colors.white

          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(left: size(33), right: size(33)),
                child: Text(
                  text_,
                  style: TextStyle(
                    color: Color(0xff85B6FF),
                    fontSize: size(12),
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      position: ToastPosition.bottom,
    );
  }
}