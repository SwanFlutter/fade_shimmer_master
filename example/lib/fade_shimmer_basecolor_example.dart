import 'package:fade_shimmer_master/fade_shimmer_list.dart';
import 'package:fade_shimmer_master/fade_shimmer_master.dart';
import 'package:flutter/material.dart';

class FadeShimmerBaseColorExample extends StatelessWidget {
  final bool isDarkMode;
  const FadeShimmerBaseColorExample({super.key, this.isDarkMode = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fade Shimmer BaseColor Example',
      home: Scaffold(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        appBar: AppBar(title: const Text('Custom baseColor Example')),
        body: FadeShimmerList(
          itemCount: 10,
          itemHeight: 80,
          spacing: 16,
          padding: const EdgeInsets.all(16),
          baseColor: Colors.amber.withValues(alpha: 0.1),
          highlightColor: Colors.amber.withValues(alpha: 0.3),
          fadeTheme: isDarkMode ? FadeTheme.dark : FadeTheme.light,
          radius: 12,
          useGradient: false,
          shimmerDirection: ShimmerDirection.leftToRight,
          animationDuration: 1000,
          staggered: true,
          staggeredDelay: 120,
        ),
      ),
    );
  }
}
