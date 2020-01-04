import 'package:flutter/material.dart';

import 'package:flowers/model/flower.dart';

class DescriptionShowcase extends StatelessWidget {
  final Flower flower;

  DescriptionShowcase(this.flower);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: new Text(
              flower.description,
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.subtitle,
            ),
          ),
        ),
      ],
    );
  }
}
