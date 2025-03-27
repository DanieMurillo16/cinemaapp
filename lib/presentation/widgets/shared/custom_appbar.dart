import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: 
          Row(
            children: [
              Icon(Icons.movie_outlined),
              Spacer(),
              Text('Cinema app'),
              Spacer(),
              IconButton(onPressed: (){}, icon: Icon(Icons.search))
              ,
            ],
          ),));
  }
}
