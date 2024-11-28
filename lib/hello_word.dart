import 'package:flutter/material.dart';

class HelloWord extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HelloWordState();
  }
  
}
class HelloWordState extends State<HelloWord>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Belajar Flutter'),
      ),
      body: const Center(
        child: Text('Hello Word'),
      ),
    );
  }
  
}