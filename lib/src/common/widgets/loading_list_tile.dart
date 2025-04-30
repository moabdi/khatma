import 'package:flutter/material.dart';
import 'package:khatma/src/common/widgets/placeholders.dart';
import 'package:shimmer/shimmer.dart';

class LoadingListTile extends StatelessWidget {
  const LoadingListTile({super.key, this.itemCount = 1});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Theme.of(context).cardColor,
          highlightColor: Theme.of(context).disabledColor,
          enabled: true,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: 16.0),
              ContentPlaceholder(lineType: ContentLineType.twoLines),
              SizedBox(height: 16.0),
            ],
          ),
        );
      },
    );
  }
}
