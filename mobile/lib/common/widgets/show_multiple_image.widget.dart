import 'package:flutter/material.dart';

class ShowMultipleImage extends StatelessWidget {
  final List<dynamic> images;
  const ShowMultipleImage({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: images.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final image = images[index];
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}