import 'package:flutter/material.dart';
import 'package:lol/contents/palette.dart' as Palette;

class SearchBox extends StatefulWidget {
  const SearchBox({Key? key}) : super(key: key);

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: const Color(0xff424242),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              offset: Offset(0,1),
            )
          ]
      ),
      height: 50,

      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "소환사 이름으로 검색",
                hintStyle: TextStyle(fontSize:20,color:Palette.lightColor, fontFamily: "Nanum"),
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 2),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          )
        ],
      ),
      //color: Colors.grey,
    );
  }
}
