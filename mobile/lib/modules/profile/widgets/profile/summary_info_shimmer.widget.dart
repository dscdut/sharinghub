import 'package:flutter/material.dart';
import 'package:mobile/common/extensions/context.extension.dart';
import 'package:shimmer/shimmer.dart';

class SummaryInfoShimmer extends StatelessWidget {
  const SummaryInfoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(60),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.width / 2,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Container(
                width: context.width / 2,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
