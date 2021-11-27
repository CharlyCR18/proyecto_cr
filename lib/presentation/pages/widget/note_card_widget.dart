import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_cr/presentation/pages/model/note.dart';

final _lightColors = [
  Colors.blue,
  Colors.blue.shade400,
  Colors.blue.shade200,
  Colors.purple,
  Colors.purple.shade400,
  Colors.purple.shade200
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
    final time = DateFormat('yyyy-MM-dd – kk:mm').format(note.createdTime);
    final minHeight = getMinHeight(index);

    return Card(
      color: color,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.all(8),
        child: Center(
          child: Column(
          //mainAxisSize: MainAxisSize.min,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 18),
            Text(
              time,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.yellow.shade600,
                fontSize: 20,
                //decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 18),
            Text(
              note.description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 20,
                //fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
          ],
        ),
        ) 
        
      ),
    );
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
