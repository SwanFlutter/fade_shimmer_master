import 'package:flutter/material.dart';
import 'fade_shimmer_master.dart';

/// A widget that creates a list of shimmer items, useful for loading states in lists
class FadeShimmerList extends StatelessWidget {
  /// The number of shimmer items to display
  final int itemCount;

  /// The height of each shimmer item
  final double itemHeight;

  /// The width of each shimmer item (defaults to full width)
  final double? itemWidth;

  /// The space between items
  final double spacing;

  /// The padding around the list
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

  const FadeShimmerList({
    super.key,
    required this.itemCount,
    required this.itemHeight,
    this.itemWidth,
    this.spacing = 16.0,
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
      child: ListView.separated(
        itemCount: itemCount,
        separatorBuilder: (context, index) => SizedBox(height: spacing),
        itemBuilder: (context, index) {
          return FadeShimmerMaster(
            width: itemWidth ?? double.infinity,
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
