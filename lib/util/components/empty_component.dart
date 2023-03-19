import 'package:flutter/material.dart';

class EmptyComponent extends StatelessWidget {
  const EmptyComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_rounded,
            size: 52,
          ),
          const SizedBox(height: 12),
          Text(
            'No results found',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
