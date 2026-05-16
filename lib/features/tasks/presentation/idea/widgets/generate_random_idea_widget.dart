import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GenerateRandomIdeaWidget extends StatelessWidget {
  const GenerateRandomIdeaWidget({
    super.key,
    required bool isDiceRooling,
    required VoidCallback onTap,
  }) : _isDiceRooling = isDiceRooling,
       _onTap = onTap;

  final bool _isDiceRooling;
  final VoidCallback _onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            !_isDiceRooling
                ? Image.asset('assets/images/dice.png')
                : Lottie.asset(
                    'assets/gif/dice.tgs',
                    width: 200,
                    height: 200,
                    frameRate: FrameRate.max,
                    decoder: LottieComposition.decodeGZip,
                    repeat: _isDiceRooling,
                  ),
          ],
        ),
      ),
    );
  }
}
