import 'package:flutter/material.dart';

class BuildBackgroundImage extends StatelessWidget {
  const BuildBackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Image

        Container(
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/background.jpg"), fit: BoxFit.cover),
          ),
        ),

        // Shadows
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 1.1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  colors: [
                    Colors.black26.withOpacity(.0),
                    Colors.black26.withOpacity(.1),
                    Colors.black26.withOpacity(.4),
                    Colors.black26.withOpacity(.6),
                    Colors.black54,
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
