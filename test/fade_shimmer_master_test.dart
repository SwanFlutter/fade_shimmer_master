import 'package:flutter_test/flutter_test.dart';

import 'package:fade_shimmer_master/fade_shimmer_master.dart';

void main() {
  test('creates FadeShimmerMaster with correct dimensions', () {
    final shimmer = FadeShimmerMaster(height: 30, width: 100);
    expect(shimmer.height, 30);
    expect(shimmer.width, 100);
  });
}
