import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientOverlayRight extends StatelessWidget {
  const GradientOverlayRight();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        width: 50,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Colors.transparent,
              Colors.black,
            ],
          ),
        ),
      ),
    );
  }
}
