import 'package:flutter/material.dart';

class MyRefreshIndicator extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const MyRefreshIndicator({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: const Color(0xFFFF5A36), // AppColors.red601
      backgroundColor: Colors.white,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
