import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.percen,
    required this.color,
  }) : super(key: key);

  final String title;
  final String value;
  final String percen;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(
                      height: 6.0,
                    ),
                    Row(
                      children: [
                        Text(
                          value,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          percen,
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      8.0,
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.list,
                  size: 24.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
