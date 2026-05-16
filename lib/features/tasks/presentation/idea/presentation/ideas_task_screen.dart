import 'package:flutter/material.dart';
import 'package:mind_map/features/tasks/presentation/idea/widgets/category_of_ideas_widget.dart';
import 'package:mind_map/features/tasks/presentation/idea/widgets/generate_random_idea_widget.dart';

class IdeasTaskScreen extends StatefulWidget {
  const IdeasTaskScreen({super.key});

  @override
  State<IdeasTaskScreen> createState() => _IdeasTaskScreenState();
}

class _IdeasTaskScreenState extends State<IdeasTaskScreen> {
  final TextEditingController _randomIdeaController = TextEditingController();
  bool _isDiceRooling = false;
  //! TODO: Replace with actual ideas
  final List<String> ideas = [
    'Self-improvement',
    'Health',
    'Finance',
    'Personal',
    'Learning',
    'Other',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/red_logo.png'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20,
            children: [
              Text(
                'Ideas for tasks',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFAD3743),
                ),
              ),

              _MainInfoBloc(ideas: ideas),

              _BottomInfoWidget(
                randomIdeaController: _randomIdeaController,
                isDiceRooling: _isDiceRooling,
                onTap: () {
                  setState(() {
                    _isDiceRooling = !_isDiceRooling;
                  });
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}

class _MainInfoBloc extends StatelessWidget {
  const _MainInfoBloc({required this.ideas});

  final List<String> ideas;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        CategoryOfIdeasWidget(title: 'Self-improvement', ideas: ideas),
        CategoryOfIdeasWidget(title: 'Mental health', ideas: ideas),
        CategoryOfIdeasWidget(title: 'Productivity', ideas: ideas),
        CategoryOfIdeasWidget(title: 'Home / Life ', ideas: ideas),
      ],
    );
  }
}

class _BottomInfoWidget extends StatelessWidget {
  const _BottomInfoWidget({
    required TextEditingController randomIdeaController,
    required bool isDiceRooling,
    required VoidCallback onTap,
  }) : _randomIdeaController = randomIdeaController,
       _isDiceRooling = isDiceRooling,
       _onTap = onTap;

  final TextEditingController _randomIdeaController;
  final bool _isDiceRooling;
  final VoidCallback _onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          'Random idea generator',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        Container(
          height: 67,
          width: double.infinity,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: TextFormField(
              controller: _randomIdeaController,
              cursorColor: Theme.of(context).primaryColor,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.casino,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                hintText: 'Send a kind message to someone',
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        GenerateRandomIdeaWidget(isDiceRooling: _isDiceRooling, onTap: _onTap),
      ],
    );
  }
}
