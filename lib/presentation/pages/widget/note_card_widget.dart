import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_cr/presentation/pages/model/note.dart';

final _lightColors = [
  Colors.yellow,
  Colors.yellow.shade400,
  Colors.yellow.shade300,
  Colors.yellow.shade200,
  Colors.yellow.shade300,
  Colors.yellow.shade400
];

class NoteCardWidget extends StatelessWidget {
  NoteCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Note note;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final color = _lightColors[index % _lightColors.length];
    final time = DateFormat('yyyy-MM-dd kk:mm').format(note.createdTime);
    final minHeight = getMinHeight(index);

    return Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: 100,
                        height: 30,
                        color: Colors.transparent,
                        /*decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(40.0)
                        ),*/
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.yellow.shade600,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5),
                                topRight: Radius.circular(5)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 1, vertical: 1),
                            child: Center(
                              child: Text(
                                time,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  //decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                        child: Container(
                          width: 100,
                        height: 30,
                            color: Colors.transparent,
                            child: new Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                              ),
                              child: Text(""),
                            ))),
                  ],
                ),
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5), topRight: Radius.circular(5))
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(height: 18.0,),
                    Text(
                      note.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //SizedBox(height: 18),
                    /*Text(
                      time,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.yellow.shade600,
                        fontSize: 20,
                        //decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),*/
                    SizedBox(height: 10),
                    Text(
                      note.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 20,
                        //fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 18),
                  ],
                ),
                ),
                
              ],
            ),
          );
      /*Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(8),
        child: 
        
      ),*/ 
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
