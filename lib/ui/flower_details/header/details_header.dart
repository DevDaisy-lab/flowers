import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:flowers/model/flower.dart';

class FlowerDetailHeader extends StatefulWidget {
  final Flower flower;
  final Object avatarTag;

  FlowerDetailHeader(
    this.flower, {
    @required this.avatarTag,
  });

  @override
  _FlowerDetailHeaderState createState() => _FlowerDetailHeaderState();
}

class _FlowerDetailHeaderState extends State<FlowerDetailHeader> {
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    var avatar = Hero(
      tag: widget.avatarTag,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Image.network(
            widget.flower.imageUrl,
            height: 250,
            width: 250,
          ),
        ),
      ),
    );

    var name = Padding(
        padding: EdgeInsets.all(5),
        child: Text(
          widget.flower.name,
          style: Theme.of(context).textTheme.title,
        ));

    return Stack(
      children: [
        Align(
          alignment: FractionalOffset.bottomCenter,
          heightFactor: 1,
          child: Column(
            children: [
              name,
              avatar,
            ],
          ),
        ),
        Positioned(
          top: 26.0,
          left: 4.0,
          child: BackButton(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
