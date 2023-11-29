import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressIndicatorDemo extends StatefulWidget {
  @override
  _ProgressIndicatorDemoState createState() => new _ProgressIndicatorDemoState();
}

class _ProgressIndicatorDemoState extends State<ProgressIndicatorDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });

    // Start the animation from 0 to 1
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int percentage = (animation.value * 100).toInt(); // Convert animation value to percentage

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.4),
              Image.asset(
                'assets/images/nv_run.gif',
                width: 50,
                height: 50,
              ),
              const SizedBox(height: 10,),
              Stack(

                children: [

                  Center(
                    child: LinearProgressIndicator(value: animation.value,
                        color: Colors.green,minHeight: 25,
                        borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                   Center(child:
                   DefaultTextStyle(
                     style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                     child: Text('Loading: $percentage%' ),
                   ),
                   )


                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
