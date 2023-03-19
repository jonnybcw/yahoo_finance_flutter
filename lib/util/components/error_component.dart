import 'package:flutter/material.dart';

class ErrorComponent extends StatelessWidget {
  const ErrorComponent({
    required this.onTapRetry,
    Key? key,
  }) : super(key: key);

  final Function() onTapRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 52,
          ),
          const SizedBox(height: 12),
          Text(
            'Something went wrong!',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: onTapRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
