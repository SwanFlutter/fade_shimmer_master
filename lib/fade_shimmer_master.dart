import 'dart:async';

import 'package:flutter/material.dart';

import 'fade_shimmer_grid.dart';
import 'fade_shimmer_list.dart';

/// Defines the available themes for the shimmer effect
enum FadeTheme { light, dark, blue, purple, green }

/// Defines the direction of the shimmer animation
enum ShimmerDirection { leftToRight, rightToLeft, topToBottom, bottomToTop }

/// A widget that displays a shimmer effect, commonly used for loading states
class FadeShimmerMaster extends StatefulWidget {
  /// The highlight color of the shimmer effect
  final Color? highlightColor;

  /// The base color of the shimmer effect
  final Color? baseColor;

  /// The radius of the container's corners
  final double radius;

  /// The width of the shimmer container
  final double width;

  /// The height of the shimmer container
  final double height;

  /// Predefined theme with preset highlight and base colors
  /// Must provide this or both highlightColor and baseColor
  final FadeTheme? fadeTheme;

  /// Delay before starting the animation, useful for creating cascading effects
  final int millisecondsDelay;

  /// Duration of the animation cycle in milliseconds
  final int animationDuration;

  /// Whether to use a gradient effect instead of solid color transition
  final bool useGradient;

  /// The direction of the shimmer animation
  final ShimmerDirection shimmerDirection;

  /// Border radius for each corner individually
  final BorderRadius? customBorderRadius;

  /// Optional border for the shimmer
  final BoxBorder? border;

  /// Optional box shadow for the shimmer
  final List<BoxShadow>? boxShadow;

  const FadeShimmerMaster({
    super.key,
    this.millisecondsDelay = 0,
    this.radius = 0,
    this.fadeTheme,
    this.highlightColor,
    this.baseColor,
    required this.width,
    required this.height,
    this.animationDuration = 1200,
    this.useGradient = false,
    this.shimmerDirection = ShimmerDirection.leftToRight,
    this.customBorderRadius,
    this.border,
    this.boxShadow,
  }) : assert(
         (highlightColor != null && baseColor != null) || fadeTheme != null,
       );

  /// Creates a round shimmer widget
  factory FadeShimmerMaster.round({
    required double size,
    Color? highlightColor,
    Color? baseColor,
    FadeTheme? fadeTheme,
    int millisecondsDelay = 0,
    int animationDuration = 1200,
    bool useGradient = false,
    ShimmerDirection shimmerDirection = ShimmerDirection.leftToRight,
    BoxBorder? border,
    List<BoxShadow>? boxShadow,
  }) => FadeShimmerMaster(
    height: size,
    width: size,
    radius: size / 2,
    baseColor: baseColor,
    highlightColor: highlightColor,
    fadeTheme: fadeTheme,
    millisecondsDelay: millisecondsDelay,
    animationDuration: animationDuration,
    useGradient: useGradient,
    shimmerDirection: shimmerDirection,
    border: border,
    boxShadow: boxShadow,
  );

  /// Creates a rectangular shimmer with custom border radius
  factory FadeShimmerMaster.rectangular({
    required double width,
    required double height,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(8)),
    Color? highlightColor,
    Color? baseColor,
    FadeTheme? fadeTheme,
    int millisecondsDelay = 0,
    int animationDuration = 1200,
    bool useGradient = false,
    ShimmerDirection shimmerDirection = ShimmerDirection.leftToRight,
    BoxBorder? border,
    List<BoxShadow>? boxShadow,
  }) => FadeShimmerMaster(
    width: width,
    height: height,
    customBorderRadius: borderRadius,
    baseColor: baseColor,
    highlightColor: highlightColor,
    fadeTheme: fadeTheme,
    millisecondsDelay: millisecondsDelay,
    animationDuration: animationDuration,
    useGradient: useGradient,
    shimmerDirection: shimmerDirection,
    border: border,
    boxShadow: boxShadow,
  );

  /// Creates a list of shimmer items
  static Widget list({
    required int itemCount,
    required double itemHeight,
    double? itemWidth,
    double spacing = 16.0,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),
    FadeTheme? fadeTheme,
    Color? highlightColor,
    Color? baseColor,
    double radius = 8.0,
    bool useGradient = false,
    ShimmerDirection shimmerDirection = ShimmerDirection.leftToRight,
    int animationDuration = 1200,
    bool staggered = true,
    int staggeredDelay = 100,
  }) => FadeShimmerList(
    itemCount: itemCount,
    itemHeight: itemHeight,
    itemWidth: itemWidth,
    spacing: spacing,
    padding: padding,
    fadeTheme: fadeTheme,
    highlightColor: highlightColor,
    baseColor: baseColor,
    radius: radius,
    useGradient: useGradient,
    shimmerDirection: shimmerDirection,
    animationDuration: animationDuration,
    staggered: staggered,
    staggeredDelay: staggeredDelay,
  );

  /// Creates a grid of shimmer items
  static Widget grid({
    required int itemCount,
    required double itemHeight,
    required double itemWidth,
    required int crossAxisCount,
    double crossAxisSpacing = 16.0,
    double mainAxisSpacing = 16.0,
    EdgeInsetsGeometry padding = const EdgeInsets.all(16.0),
    FadeTheme? fadeTheme,
    Color? highlightColor,
    Color? baseColor,
    double radius = 8.0,
    bool useGradient = false,
    ShimmerDirection shimmerDirection = ShimmerDirection.leftToRight,
    int animationDuration = 1200,
    bool staggered = true,
    int staggeredDelay = 100,
  }) => FadeShimmerGrid(
    itemCount: itemCount,
    itemHeight: itemHeight,
    itemWidth: itemWidth,
    crossAxisCount: crossAxisCount,
    crossAxisSpacing: crossAxisSpacing,
    mainAxisSpacing: mainAxisSpacing,
    padding: padding,
    fadeTheme: fadeTheme,
    highlightColor: highlightColor,
    baseColor: baseColor,
    radius: radius,
    useGradient: useGradient,
    shimmerDirection: shimmerDirection,
    animationDuration: animationDuration,
    staggered: staggered,
    staggeredDelay: staggeredDelay,
  );

  @override
  State<FadeShimmerMaster> createState() => _FadeShimmerMasterState();
}

class _FadeShimmerMasterState extends State<FadeShimmerMaster>
    with TickerProviderStateMixin {
  // Changed from SingleTickerProviderStateMixin
  AnimationController? _controller;
  late Animation<double> _animation;
  bool isHighLight = true;
  StreamSubscription? _subscription;
  Timer? _delayTimer;

  // Stream that toggles between true and false every second
  static final isHighLightStream =
      Stream<bool>.periodic(
        const Duration(seconds: 1),
        (x) => x % 2 == 0,
      ).asBroadcastStream();

  Color get highLightColor {
    if (widget.highlightColor != null) {
      return widget.highlightColor!;
    }
    if (widget.fadeTheme != null) {
      switch (widget.fadeTheme) {
        case FadeTheme.light:
          return const Color(0xffF9F9FB);
        case FadeTheme.dark:
          return const Color(0xff3A3E3F);
        case FadeTheme.blue:
          return const Color(0xff1E88E5);
        case FadeTheme.purple:
          return const Color(0xff9C27B0);
        case FadeTheme.green:
          return const Color(0xff4CAF50);
        default:
          return const Color(0xff3A3E3F);
      }
    }
    throw Exception('No highlightColor or fadeTheme provided');
  }

  Color get baseColor {
    if (widget.baseColor != null) {
      return widget.baseColor!;
    }
    if (widget.fadeTheme != null) {
      switch (widget.fadeTheme) {
        case FadeTheme.light:
          return const Color(0xffE6E8EB);
        case FadeTheme.dark:
          return const Color(0xff2A2C2E);
        case FadeTheme.blue:
          return const Color(0xff90CAF9);
        case FadeTheme.purple:
          return const Color(0xffE1BEE7);
        case FadeTheme.green:
          return const Color(0xffA5D6A7);
        default:
          return const Color(0xff2A2C2E);
      }
    }
    throw Exception('No baseColor or fadeTheme provided');
  }

  Alignment get gradientStartAlignment {
    switch (widget.shimmerDirection) {
      case ShimmerDirection.leftToRight:
        return Alignment.centerLeft;
      case ShimmerDirection.rightToLeft:
        return Alignment.centerRight;
      case ShimmerDirection.topToBottom:
        return Alignment.topCenter;
      case ShimmerDirection.bottomToTop:
        return Alignment.bottomCenter;
    }
  }

  Alignment get gradientEndAlignment {
    switch (widget.shimmerDirection) {
      case ShimmerDirection.leftToRight:
        return Alignment.centerRight;
      case ShimmerDirection.rightToLeft:
        return Alignment.centerLeft;
      case ShimmerDirection.topToBottom:
        return Alignment.bottomCenter;
      case ShimmerDirection.bottomToTop:
        return Alignment.topCenter;
    }
  }

  @override
  void dispose() {
    _cleanupResources();
    super.dispose();
  }

  void _cleanupResources() {
    _delayTimer?.cancel();
    _delayTimer = null;
    _subscription?.cancel();
    _subscription = null;
    _controller?.dispose();
    _controller = null;
  }

  void safeSetState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _setupAnimation();
  }

  @override
  void didUpdateWidget(covariant FadeShimmerMaster oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.useGradient != widget.useGradient ||
        oldWidget.animationDuration != widget.animationDuration ||
        oldWidget.millisecondsDelay != widget.millisecondsDelay) {
      _cleanupResources();
      _setupAnimation();
    }
  }

  void _setupAnimation() {
    // Ensure clean state before creating new resources
    _cleanupResources();

    if (widget.useGradient) {
      _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.animationDuration),
      );

      _animation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));

      if (widget.millisecondsDelay > 0) {
        _delayTimer = Timer(
          Duration(milliseconds: widget.millisecondsDelay),
          () {
            if (mounted && _controller != null) {
              _controller!.repeat(reverse: true);
            }
          },
        );
      } else {
        _controller!.repeat(reverse: true);
      }
    } else {
      // For non-gradient mode, we don't need AnimationController
      _subscription = isHighLightStream.listen((value) {
        if (widget.millisecondsDelay > 0) {
          _delayTimer?.cancel();
          _delayTimer = Timer(
            Duration(milliseconds: widget.millisecondsDelay),
            () {
              if (mounted) {
                isHighLight = value;
                safeSetState();
              }
            },
          );
        } else {
          isHighLight = value;
          safeSetState();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius =
        widget.customBorderRadius ?? BorderRadius.circular(widget.radius);

    if (widget.useGradient && _controller != null) {
      return AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: gradientStartAlignment,
                end: gradientEndAlignment,
                colors: [baseColor, highLightColor, baseColor],
                stops: [
                  _animation.value - 0.3 < 0 ? 0 : _animation.value - 0.3,
                  _animation.value,
                  _animation.value + 0.3 > 1 ? 1 : _animation.value + 0.3,
                ],
              ),
              borderRadius: borderRadius,
              border: widget.border,
              boxShadow: widget.boxShadow,
            ),
          );
        },
      );
    } else {
      return AnimatedContainer(
        curve: Curves.easeInOut,
        duration: Duration(milliseconds: widget.animationDuration),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: isHighLight ? highLightColor : baseColor,
          borderRadius: borderRadius,
          border: widget.border,
          boxShadow: widget.boxShadow,
        ),
      );
    }
  }
}
