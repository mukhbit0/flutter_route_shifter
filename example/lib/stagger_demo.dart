import 'package:flutter/material.dart';
import 'package:flutter_route_shifter/flutter_route_shifter.dart';

/// Demonstrates the enhanced stagger effect with deep widget traversal.
class StaggerDemoPage extends StatelessWidget {
  const StaggerDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enhanced Stagger Effects'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Demo buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      _navigateWithStagger(context, StaggerType.basic),
                  child: const Text('Basic Stagger'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      _navigateWithStagger(context, StaggerType.advanced),
                  child: const Text('Advanced Stagger'),
                ),
                ElevatedButton(
                  onPressed: () =>
                      _navigateWithStagger(context, StaggerType.reverse),
                  child: const Text('Reverse Stagger'),
                ),
              ],
            ),
          ),
          // Sample content that will be staggered
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // These cards are wrapped in various containers to test deep traversal
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Card(
                      child: ListTile(
                        leading: const Icon(Icons.star, color: Colors.amber),
                        title: const Text('Nested Card in Container + Padding'),
                        subtitle: const Text('Tests deep widget traversal'),
                      ),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Center(
                    child: Card(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: const Text('Card in Align + Center wrapper'),
                      ),
                    ),
                  ),
                ),

                Card(
                  child: ListTile(
                    leading: const Icon(Icons.home, color: Colors.blue),
                    title: const Text('Direct Card'),
                    subtitle: const Text('No wrapper widgets'),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Card with Multiple Children',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'This card contains multiple child widgets',
                          ),
                          const SizedBox(height: 8),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Action Button'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Different widget types
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.settings, color: Colors.green),
                    title: const Text('Container with ListTile'),
                    subtitle: const Text('Different widget type'),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(8),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(8),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Material with InkWell'),
                      ),
                    ),
                  ),
                ),

                Card(
                  child: ExpansionTile(
                    leading: const Icon(Icons.expand_more),
                    title: const Text('Expansion Tile'),
                    children: [
                      ListTile(title: const Text('Child 1'), onTap: () {}),
                      ListTile(title: const Text('Child 2'), onTap: () {}),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _navigateWithStagger(BuildContext context, StaggerType type) {
    RouteShifterBuilder builder;

    switch (type) {
      case StaggerType.basic:
        builder = RouteShifterBuilder().stagger(
          interval: const Duration(milliseconds: 100),
          baseEffect: SlideEffect.fromBottom(),
        );
        break;

      case StaggerType.advanced:
        builder = RouteShifterBuilder().stagger(
          interval: const Duration(milliseconds: 80),
          elementSelector: (element) {
            final widget = element.widget;
            final size = element.size;
            // Only stagger larger widgets
            return (widget is Card ||
                    widget is Material ||
                    widget is Container) &&
                size != null &&
                size.height > 50;
          },
          baseEffect: const ScaleEffect(start: 0.8),
        );
        break;

      case StaggerType.reverse:
        builder = RouteShifterBuilder()
            .stagger(
              interval: const Duration(milliseconds: 60),
              reverse: true,
              selector: (widget) =>
                  widget is Card || widget is ListTile || widget is Material,
              baseEffect: const FadeEffect(),
            )
            .slideFromRight();
        break;
    }

    Navigator.of(
      context,
    ).push(builder.toRoute(page: const StaggerResultPage()));
  }
}

/// The destination page that shows the stagger effect result.
class StaggerResultPage extends StatelessWidget {
  const StaggerResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stagger Effect Result'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check_circle, size: 100, color: Colors.green),
            SizedBox(height: 16),
            Text(
              'Stagger Animation Complete!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'The enhanced stagger effect successfully discovered\nand animated nested widgets using Element.visitChildren()',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}

enum StaggerType { basic, advanced, reverse }
