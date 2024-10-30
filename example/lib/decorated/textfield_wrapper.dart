import 'package:flutter/material.dart';

class TextfieldWrapper extends StatelessWidget {
  final Widget child;
  const TextfieldWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 88, 87, 87),
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}



class BaseBackground extends StatelessWidget {
  final Widget child;
  BorderRadiusGeometry? borderRadius;
  BaseBackground({
    super.key,
    required this.child,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.11, 1.0],
            colors: [
              Color(0xff1C1C1C),
              Color(0xff1B1B1B),
              Color.fromARGB(255, 5, 5, 5),
            ],
          ),
        ),
        child: child);
  }
}
