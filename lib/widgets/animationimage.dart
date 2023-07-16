import 'package:flutter/material.dart';

class AnimationImage extends StatefulWidget {
  const AnimationImage({Key? key}) : super(key: key);

  @override
  State<AnimationImage> createState() => _AnimationImageState();
}

class _AnimationImageState extends State<AnimationImage> with SingleTickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 2000));
    CurvedAnimation curved = CurvedAnimation(parent: animationController, curve: Curves.bounceOut);
    animation=Tween(begin: 200.0,end:300.0).animate(curved);
    animation.addStatusListener((AnimationStatus status) =>setState(() {
      if(status==AnimationStatus.completed){
        animationController.reverse();
      }else if(status == AnimationStatus.dismissed){
        animationController.forward();
      }
    }));
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context , widget){
        return SizedBox(
          width:animation.value,
          height: animation.value,
          child: Center(
              child: Image.asset('assets/shop+shopping+store+icon-1320191097413967934_512.png',fit: BoxFit.fill,),
              // Transform.rotate(angle: Tween(begin: 0.0,end: 24.0).evaluate(animation),
              // child: Image.asset('assets/shop+shopping+store+icon-1320191097413967934_512.png',fit: BoxFit.fill,),
              // ),
          ),
        );
      }, 
    );
  }
}
