import 'package:flutter/material.dart';
import 'fade_shimmer_master.dart';

/// A widget that creates a grid of shimmer items
class FadeShimmerGrid extends StatelessWidget {
  /// The number of shimmer items to display
  final int itemCount;

  /// The height of each shimmer item
  final double itemHeight;

  /// The width of each shimmer item
  final double itemWidth;

  /// The number of columns in the grid
  final int crossAxisCount;

  /// The space between items horizontally
  final double crossAxisSpacing;

  /// The space between items vertically
  final double mainAxisSpacing;

  /// The padding around the grid
  final EdgeInsetsGeometry padding;

  /// The theme for the shimmer items
  final FadeTheme? fadeTheme;

  /// The highlight color for the shimmer items
  final Color? highlightColor;

  /// The base color for the shimmer items
  final Color? baseColor;

  /// The border radius for the shimmer items
  final double radius;

  /// Whether to use a gradient effect
  final bool useGradient;

  /// The direction of the shimmer animation
  final ShimmerDirection shimmerDirection;

  /// The duration of the animation in milliseconds
  final int animationDuration;

  /// Whether to stagger the animations
  final bool staggered;

  /// The delay between staggered animations in milliseconds
  final int staggeredDelay;

  const FadeShimmerGrid({
    super.key,
    required this.itemCount,
    required this.itemHeight,
    required this.itemWidth,
    required this.crossAxisCount,
    this.crossAxisSpacing = 16.0,
    this.mainAxisSpacing = 16.0,
    this.padding = const EdgeInsets.all(16.0),
    this.fadeTheme,
    this.highlightColor,
    this.baseColor,
    this.radius = 8.0,
    this.useGradient = false,
    this.shimmerDirection = ShimmerDirection.leftToRight,
    this.animationDuration = 1200,
    this.staggered = true,
    this.staggeredDelay = 100,
  }) : assert(
         (highlightColor != null && baseColor != null) || fadeTheme != null,
       );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          childAspectRatio: itemWidth / itemHeight,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return FadeShimmerMaster(
            width: itemWidth,
            height: itemHeight,
            radius: radius,
            fadeTheme: fadeTheme,
            highlightColor: highlightColor,
            baseColor: baseColor,
            millisecondsDelay: staggered ? index * staggeredDelay : 0,
            useGradient: useGradient,
            shimmerDirection: shimmerDirection,
            animationDuration: animationDuration,
          );
        },
      ),
    );
  }
}
