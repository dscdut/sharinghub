import 'package:flutter/material.dart';

typedef RatingChangeCallback = void Function(int rating);

class StarRating extends StatefulWidget {
  final int starCount;
  final int rating;
  final RatingChangeCallback? onRatingChanged;
  final Color color;
  final double size;

  const StarRating({
    super.key,
    this.starCount = 5,
    this.rating = 0,
    this.onRatingChanged,
    this.color = Colors.orangeAccent,
    this.size = 24.0,
  });

  @override
  State<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  late int _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.rating;
  }

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= _rating) {
      icon = Icon(
        Icons.star_border,
        color: widget.color,
        size: widget.size,
      );
    } else if (index > _rating - 1 && index < _rating) {
      icon = Icon(
        Icons.star_half,
        color: widget.color,
        size: widget.size,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: widget.color,
        size: widget.size,
      );
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          _rating = index + 1;
        });
        widget.onRatingChanged?.call(_rating);
      },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          List.generate(widget.starCount, (index) => buildStar(context, index)),
    );
  }
}
