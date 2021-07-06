import 'package:flutter/material.dart';

class Board extends StatelessWidget {
  Function tapFunc;
  List label;
  bool end;

  Board(this.tapFunc, this.label, this.end,);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.9,),
      child: _buildBoard(),
    );
  }

  Widget _buildBoard() {
    final col = <Widget>[];
    for (var i = 0; i < label.length; i++) {
      final r = <Widget>[];
      for (var j = 0; j < List.from(label[i]).length; j++) {
        r.add(GestureDetector(
          onTap: () {
            if (!end) {
              tapFunc(i, j);
            }
          },
          child: Container(
            decoration:
                BoxDecoration(
                    border: Border.all(color: Color(0xff73CDD6)),
                  color: Colors.white,
                ),
            height: 32.1,
            width: 32.6,
            child: Center(
                child: label[i][j] == '' ? SizedBox() :
                  Image.asset(
                    label[i][j] == 'X' ? 'assets/image/x.png' : 'assets/image/o.png'
                )
            ),
          ),
        ));
      }
      col.add(Row(children: r));
    }
    return Column(children: col);
  }
}
