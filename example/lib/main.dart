
import 'package:fade_shimmer_master/fade_shimmer_master.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fade Shimmer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final _pages = [
    const ClassicShimmerPage(),
    const EnhancedShimmerPage(),
    const ShimmerListPage(),
    const ShimmerGridPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            label: 'Classic',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gradient),
            label: 'Enhanced',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Grid',
          ),
        ],
      ),
    );
  }
}

// Classic shimmer example (original implementation)
class ClassicShimmerPage extends StatefulWidget {
  const ClassicShimmerPage({super.key});

  @override
  State<ClassicShimmerPage> createState() => _ClassicShimmerPageState();
}

class _ClassicShimmerPageState extends State<ClassicShimmerPage> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          isDarkMode ? const Color(0xff181818) : const Color(0xffF0F2F5),
      appBar: AppBar(
        title: const Text('Classic Shimmer'),
        backgroundColor: isDarkMode ? const Color(0xff242424) : Colors.white,
        foregroundColor: isDarkMode ? Colors.white : Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.wb_sunny,
          color: Colors.white.withAlpha(isDarkMode ? 128 : 255),
        ),
        onPressed: () {
          setState(() {
            isDarkMode = !isDarkMode;
          });
        },
      ),
      body: ListView.separated(
        itemBuilder: (_, i) {
          final delay = (i * 300);
          return Container(
            decoration: BoxDecoration(
                color: isDarkMode ? const Color(0xff242424) : Colors.white,
                borderRadius: BorderRadius.circular(8)),
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                FadeShimmerMaster.round(
                  size: 60,
                  fadeTheme: isDarkMode ? FadeTheme.dark : FadeTheme.light,
                  millisecondsDelay: delay,
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeShimmerMaster(
                      height: 8,
                      width: 150,
                      radius: 4,
                      millisecondsDelay: delay,
                      fadeTheme: isDarkMode ? FadeTheme.dark : FadeTheme.light,
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    FadeShimmerMaster(
                      height: 8,
                      millisecondsDelay: delay,
                      width: 170,
                      radius: 4,
                      fadeTheme: isDarkMode ? FadeTheme.dark : FadeTheme.light,
                    ),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: 20,
        separatorBuilder: (_, __) => const SizedBox(
          height: 16,
        ),
      ),
    );
  }
}

// Enhanced shimmer example (new features)
class EnhancedShimmerPage extends StatefulWidget {
  const EnhancedShimmerPage({super.key});

  @override
  State<EnhancedShimmerPage> createState() => _EnhancedShimmerPageState();
}

class _EnhancedShimmerPageState extends State<EnhancedShimmerPage> {
  FadeTheme _currentTheme = FadeTheme.dark;
  bool _useGradient = true;
  ShimmerDirection _direction = ShimmerDirection.leftToRight;
  int _animationDuration = 1200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enhanced Shimmer'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Theme selector
              const Text('Theme:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8,
                children: [
                  for (final theme in FadeTheme.values)
                    ChoiceChip(
                      label: Text(theme.name),
                      selected: _currentTheme == theme,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _currentTheme = theme;
                          });
                        }
                      },
                    ),
                ],
              ),

              const SizedBox(height: 16),

              // Gradient toggle
              Row(
                children: [
                  const Text('Use Gradient:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  Switch(
                    value: _useGradient,
                    onChanged: (value) {
                      setState(() {
                        _useGradient = value;
                      });
                    },
                  ),
                ],
              ),

              // Direction selector
              const Text('Direction:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8,
                children: [
                  for (final direction in ShimmerDirection.values)
                    ChoiceChip(
                      label: Text(direction.name),
                      selected: _direction == direction,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _direction = direction;
                          });
                        }
                      },
                    ),
                ],
              ),

              // Animation duration slider
              const Text('Animation Duration:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Slider(
                min: 500,
                max: 3000,
                divisions: 25,
                value: _animationDuration.toDouble(),
                label: '${_animationDuration}ms',
                onChanged: (value) {
                  setState(() {
                    _animationDuration = value.toInt();
                  });
                },
              ),

              const SizedBox(height: 24),

              // Basic shimmer examples
              const Text('Basic Shimmer Examples:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Round shimmer
                  Column(
                    children: [
                      const Text('Round'),
                      const SizedBox(height: 8),
                      FadeShimmerMaster.round(
                        size: 64,
                        fadeTheme: _currentTheme,
                        useGradient: _useGradient,
                        shimmerDirection: _direction,
                        animationDuration: _animationDuration,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(51),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Rectangular shimmer
                  Column(
                    children: [
                      const Text('Rectangular'),
                      const SizedBox(height: 8),
                      FadeShimmerMaster.rectangular(
                        width: 120,
                        height: 64,
                        fadeTheme: _currentTheme,
                        useGradient: _useGradient,
                        shimmerDirection: _direction,
                        animationDuration: _animationDuration,
                        border: Border.all(color: Colors.grey.withAlpha(77)),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Card example
              const Text('Card Example:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _currentTheme == FadeTheme.dark
                      ? const Color(0xff242424)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(26),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FadeShimmerMaster.round(
                          size: 50,
                          fadeTheme: _currentTheme,
                          useGradient: _useGradient,
                          shimmerDirection: _direction,
                          animationDuration: _animationDuration,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeShimmerMaster.rectangular(
                              width: 150,
                              height: 15,
                              fadeTheme: _currentTheme,
                              useGradient: _useGradient,
                              shimmerDirection: _direction,
                              animationDuration: _animationDuration,
                            ),
                            const SizedBox(height: 8),
                            FadeShimmerMaster.rectangular(
                              width: 100,
                              height: 10,
                              fadeTheme: _currentTheme,
                              useGradient: _useGradient,
                              shimmerDirection: _direction,
                              animationDuration: _animationDuration,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    FadeShimmerMaster.rectangular(
                      width: double.infinity,
                      height: 120,
                      fadeTheme: _currentTheme,
                      useGradient: _useGradient,
                      shimmerDirection: _direction,
                      animationDuration: _animationDuration,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FadeShimmerMaster.rectangular(
                          width: 80,
                          height: 30,
                          fadeTheme: _currentTheme,
                          useGradient: _useGradient,
                          shimmerDirection: _direction,
                          animationDuration: _animationDuration,
                        ),
                        FadeShimmerMaster.rectangular(
                          width: 80,
                          height: 30,
                          fadeTheme: _currentTheme,
                          useGradient: _useGradient,
                          shimmerDirection: _direction,
                          animationDuration: _animationDuration,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Shimmer list example
class ShimmerListPage extends StatefulWidget {
  const ShimmerListPage({super.key});

  @override
  State<ShimmerListPage> createState() => _ShimmerListPageState();
}

class _ShimmerListPageState extends State<ShimmerListPage> {
  FadeTheme _currentTheme = FadeTheme.dark;
  bool _useGradient = true;
  bool _staggered = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Theme selector
                Row(
                  children: [
                    const Text('Theme:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    DropdownButton<FadeTheme>(
                      value: _currentTheme,
                      onChanged: (FadeTheme? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _currentTheme = newValue;
                          });
                        }
                      },
                      items: FadeTheme.values.map((FadeTheme theme) {
                        return DropdownMenuItem<FadeTheme>(
                          value: theme,
                          child: Text(theme.name),
                        );
                      }).toList(),
                    ),
                  ],
                ),

                // Gradient toggle
                Row(
                  children: [
                    const Text('Use Gradient:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Switch(
                      value: _useGradient,
                      onChanged: (value) {
                        setState(() {
                          _useGradient = value;
                        });
                      },
                    ),
                  ],
                ),

                // Staggered toggle
                Row(
                  children: [
                    const Text('Staggered Animation:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Switch(
                      value: _staggered,
                      onChanged: (value) {
                        setState(() {
                          _staggered = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: FadeShimmerMaster.list(
              itemCount: 15,
              itemHeight: 80,
              fadeTheme: _currentTheme,
              useGradient: _useGradient,
              staggered: _staggered,
              staggeredDelay: 100,
              spacing: 12,
              padding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }
}

// Shimmer grid example
class ShimmerGridPage extends StatefulWidget {
  const ShimmerGridPage({super.key});

  @override
  State<ShimmerGridPage> createState() => _ShimmerGridPageState();
}

class _ShimmerGridPageState extends State<ShimmerGridPage> {
  FadeTheme _currentTheme = FadeTheme.blue;
  bool _useGradient = true;
  bool _staggered = true;
  int _columns = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shimmer Grid'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Theme selector
                Row(
                  children: [
                    const Text('Theme:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    DropdownButton<FadeTheme>(
                      value: _currentTheme,
                      onChanged: (FadeTheme? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _currentTheme = newValue;
                          });
                        }
                      },
                      items: FadeTheme.values.map((FadeTheme theme) {
                        return DropdownMenuItem<FadeTheme>(
                          value: theme,
                          child: Text(theme.name),
                        );
                      }).toList(),
                    ),
                  ],
                ),

                // Gradient toggle
                Row(
                  children: [
                    const Text('Use Gradient:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Switch(
                      value: _useGradient,
                      onChanged: (value) {
                        setState(() {
                          _useGradient = value;
                        });
                      },
                    ),
                  ],
                ),

                // Staggered toggle
                Row(
                  children: [
                    const Text('Staggered Animation:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Switch(
                      value: _staggered,
                      onChanged: (value) {
                        setState(() {
                          _staggered = value;
                        });
                      },
                    ),
                  ],
                ),

                // Columns selector
                Row(
                  children: [
                    const Text('Columns:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Slider(
                      min: 2,
                      max: 4,
                      divisions: 2,
                      value: _columns.toDouble(),
                      label: _columns.toString(),
                      onChanged: (value) {
                        setState(() {
                          _columns = value.toInt();
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: FadeShimmerMaster.grid(
              itemCount: 12,
              itemHeight: 120,
              itemWidth: 120,
              crossAxisCount: _columns,
              fadeTheme: _currentTheme,
              useGradient: _useGradient,
              staggered: _staggered,
              staggeredDelay: 100,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              padding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }
}
