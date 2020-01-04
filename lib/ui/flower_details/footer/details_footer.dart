import 'package:flutter/material.dart';

import 'package:flowers/model/flower.dart';
import 'package:flowers/ui/flower_details/footer/showcase_description.dart';

class FlowerShowcase extends StatefulWidget {
  final Flower flower;

  FlowerShowcase(this.flower);

  @override
  _FlowerShowcaseState createState() => _FlowerShowcaseState();
}

class _FlowerShowcaseState extends State<FlowerShowcase>
    with TickerProviderStateMixin {
  List<Tab> _tabs;
  List<Widget> _pages;
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _tabs = [
      Tab(text: 'Description'),
    ];
    _pages = [
      DescriptionShowcase(widget.flower),
    ];
    _controller = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TabBar(
            labelColor: Colors.white,
            labelStyle: Theme.of(context).textTheme.title,
            controller: _controller,
            tabs: _tabs,
            indicatorColor: Colors.white,
          ),
          SizedBox.fromSize(
            size: const Size.fromHeight(300.0),
            child: TabBarView(
              controller: _controller,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}
