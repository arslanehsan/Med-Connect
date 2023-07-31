import 'package:flutter/material.dart';

class HealthEducationListScreen extends StatelessWidget {
  final List<String> healthEducationTopics = [
    'Healthy Diet',
    'Exercise and Fitness',
    'Mental Health',
    'Sleep Hygiene',
    'Hydration and Water Intake',
    'Stress Management',
    // Add more health education topics here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Education Topics'),
      ),
      body: ListView.builder(
        itemCount: healthEducationTopics.length,
        itemBuilder: (context, index) {
          return ListTile(
            trailing: const Icon(Icons.arrow_forward),
            leading: const Icon(Icons.healing),
            title: Text(healthEducationTopics[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HealthEducationDetailScreen(
                    title: healthEducationTopics[index],
                    content:
                        'This is the content for ${healthEducationTopics[index]}.\n'
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class HealthEducationDetailScreen extends StatelessWidget {
  final String title;
  final String content;

  HealthEducationDetailScreen({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  content,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
