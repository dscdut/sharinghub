import 'package:flutter/material.dart';

typedef RatingChangeCallback = void Function(int rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final num rating;
  final RatingChangeCallback? onRatingChanged;
  final Color color;
  final double size;

  const StarRating({
    super.key,
    this.starCount = 5,
    this.rating = .0,
    this.onRatingChanged,
    this.color = Colors.orangeAccent,
    this.size = 24.0,
  });

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        color: color,
        size: size,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: color,
        size: size,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: color,
        size: size,
      );
    }
    return GestureDetector(
      onTap: () => onRatingChanged?.call(index + 1),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(starCount, (index) => buildStar(context, index)),
    );
  }
}
