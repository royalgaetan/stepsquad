import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stepsquad/services/getRandomImage.dart';

class BuildCircleAvatar extends StatelessWidget {
  const BuildCircleAvatar({super.key, required this.radius, this.photoIndex});

  final double radius;
  final int? photoIndex;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchRandomImage(photoIndex: photoIndex),
      builder: (context, snapshot) {
        // HAS ERROR
        if (snapshot.hasError) {
          return CircleAvatar(
            radius: radius,
            backgroundColor: Colors.grey.shade300,
          );
        }

        // HAS DATA
        if (snapshot.hasData) {
          return CircleAvatar(
            radius: radius,
            backgroundImage: NetworkImage(snapshot.data ?? ""),
            backgroundColor: Colors.grey.shade300,
          );
        }

        // IS LOADING
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade400,
          child: CircleAvatar(
            radius: radius,
            backgroundColor: Colors.grey.shade300,
          ),
        );
      },
    );
  }
}
