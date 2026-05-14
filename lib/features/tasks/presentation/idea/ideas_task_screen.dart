import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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

              Column(
                spacing: 10,
                children: [
                  _CategoryOfIdeasWidget(
                    title: 'Self-improvement',
                    ideas: ideas,
                  ),
                  _CategoryOfIdeasWidget(title: 'Mental health', ideas: ideas),
                  _CategoryOfIdeasWidget(title: 'Productivity', ideas: ideas),
                  _CategoryOfIdeasWidget(title: 'Home / Life ', ideas: ideas),
                ],
              ),

              Column(
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
                            color: Theme.of(
                              context,
                            ).primaryColor.withValues(alpha: 0.5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  setState(() {
                    _isDiceRooling = !_isDiceRooling;
                  });
                },
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      !_isDiceRooling
                          ? Image.asset('assets/images/dice.png')
                          : Lottie.asset(
                              'assets/gif/dice.tgs',
                              width: 200,
                              height: 200,
                              frameRate: FrameRate.max,
                              decoder: LottieComposition.decodeGZip,
                              repeat: _isDiceRooling,
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}

class _CategoryOfIdeasWidget extends StatelessWidget {
  final String title;
  final List<String> ideas;
  const _CategoryOfIdeasWidget({required this.title, required this.ideas});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          SizedBox(
            height: 30,
            width: double.infinity,
            child: ListView.builder(
              itemCount: ideas.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFFAD3743),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      ideas[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
