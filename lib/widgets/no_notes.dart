import 'package:flutter/material.dart';

class NoNotes extends StatelessWidget {
  const NoNotes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Image.asset('assets/images/person.png', width: MediaQuery.of(context).size.width * 0.75,),
      SizedBox(height: 24,),
      Text('No Notes Yet!\nStart by Adding a New Note Using the + Button', style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Fredoka',
      ),),
    ],);
  }
}
