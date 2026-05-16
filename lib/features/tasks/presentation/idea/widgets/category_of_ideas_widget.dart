import 'package:flutter/material.dart';

class CategoryOfIdeasWidget extends StatelessWidget {
  final String title;
  final List<String> ideas;
  const CategoryOfIdeasWidget({
    required this.title,
    required this.ideas,
    super.key,
  });

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
