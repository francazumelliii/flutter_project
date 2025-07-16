
import 'package:flutter/cupertino.dart';

import '../../../utils/dimensions.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        url,
        width: Dimensions.coverImageWidth,
        height: Dimensions.coverImageHeight,
        fit: BoxFit.cover,
      ),
    );
  }
}
