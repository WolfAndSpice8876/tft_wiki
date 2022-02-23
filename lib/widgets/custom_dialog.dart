import 'package:flutter/material.dart';
import 'package:lol/normal/size.dart';

class CustomDialog extends StatefulWidget {
  CustomDialog({Key? key}) : super(key: key);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size(200),
      height: size(48),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size(20)),
          color: Colors.white
      ),
      child: Center(
        child: Text(
            "인터넷 연결이 불안정 합니다."
        ),
      ),
    );
  }
}

class CustomDialogClass
{
  bool isOn = false;
  Function setState;
  double offTime;

  CustomDialogClass({required this.setState , required this.offTime});

  Widget get(){
    if(isOn == false)
      return SizedBox();
    else
     return CustomDialog();
  }

  void set(bool isOn_){
    isOn = isOn_;
  }

  void on(){
    isOn = true;
    setState.call();
    Future.delayed(const Duration(milliseconds: 500), () {
      isOn = false;
      setState.call();
    });
  }
}
