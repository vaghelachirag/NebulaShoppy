import 'package:flutter/material.dart';
class Example  extends StatefulWidget {
    const Example ({Key? key, required this.title}) : super(key: key);

      final String title;

      @override
      State<Example > createState() => _ExampleState ();
    }

    class _ExampleState  extends State<Example > {
    
      void myFunction(){
        print('hello dart');
          }
    

     @override
      Widget build(BuildContext context) {

        return Scaffold(
          appBar: AppBar(

            title: Text(widget.title),
          ),
          body: TextButton(
              onPressed: (){
             
              },
              child: Text('tab me')
          )
        );
      }
    }