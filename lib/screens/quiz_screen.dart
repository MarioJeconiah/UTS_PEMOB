import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        centerTitle: true,
        leading: const Icon(Icons.quiz_rounded),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(
                    constraints.maxWidth * 0.06,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Question 1 of 5',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium,
                          ),
                          Text(
                            '20%',
                            style: TextStyle(
                              color: colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const LinearProgressIndicator(
                        value: 0.2,
                        minHeight: 8,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Icon(
                        Icons.lightbulb_outline_rounded,
                        size: 64,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Pertanyaan 1',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Apa ibu kota negara Indonesia?',
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge,
                      ),
                      const SizedBox(height: 28),
                      _buildOption(context, 'A', 'Bandung'),
                      _buildOption(context, 'B', 'Jakarta'),
                      _buildOption(context, 'C', 'Surabaya'),
                      _buildOption(context, 'D', 'Medan'),
                      const SizedBox(height: 24),
                      FilledButton(
                        onPressed: () {},
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                        ),
                        child: const Text('Berikutnya'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOption(
    BuildContext context,
    String label,
    String answer,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(label),
        ),
        title: Text(answer),
        trailing: const Icon(Icons.circle_outlined),
        onTap: () {},
      ),
    );
  }
}