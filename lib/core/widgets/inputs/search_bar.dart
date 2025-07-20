import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal:Dimensions.paddingMedium, vertical: Dimensions.paddingSmall),
      color: Colors.black,
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.white),
          hintText: 'Search tracks...',
          hintStyle: TextStyle(color: Colors.white54),
          border: OutlineInputBorder(),
        ),
        onSubmitted: onSearch,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
