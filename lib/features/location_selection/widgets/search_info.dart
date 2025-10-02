import 'package:flutter/material.dart';

class SearchInfo extends StatelessWidget {
  final String text;
  const SearchInfo({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_on, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(text, style: TextTheme.of(context).bodyLarge!.copyWith(color: Colors.grey)),
        ],
      ),
    );
  }
}
