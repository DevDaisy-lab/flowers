import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'package:flowers/model/flower.dart';
import 'package:flowers/ui/flower_details/header/details_header.dart';
import 'package:flowers/ui/flower_details/footer/details_footer.dart';

class FlowerDetailsPage extends StatefulWidget {
  final Flower flower;
  final Object avatarTag;

  FlowerDetailsPage(
    this.flower, {
    @required this.avatarTag,
  });

  @override
  _FlowerDetailsPageState createState() => _FlowerDetailsPageState();
}

class _FlowerDetailsPageState extends State<FlowerDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/bg6.jpg',
              width: double.infinity,
              height: 700,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 23),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    FlowerDetailHeader(
                      widget.flower,
                      avatarTag: widget.avatarTag,
                    ),
                    FlowerShowcase(widget.flower),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
