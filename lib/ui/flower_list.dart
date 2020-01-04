import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flowers/model/flower.dart';
import 'package:flowers/services/api.dart';
import 'package:flowers/utils/routes.dart';
import 'package:flowers/ui/flower_details/details_page.dart';

class FlowerList extends StatefulWidget {
  @override
  _FlowerListState createState() => _FlowerListState();
}

class _FlowerListState extends State<FlowerList> {
  List<Flower> _flowers = [];
  FlowerApi _api;
  NetworkImage _profileImage;

  @override
  void initState() {
    super.initState();
    _loadFromFirebase();
  }

  _loadFromFirebase() async {
    final api = await FlowerApi.signInWithGoogle();
    final flowers = await api.getAllFlowers();
    setState(() {
      _api = api;
      _flowers = flowers;
      _profileImage = new NetworkImage(api.firebaseUser.photoUrl);
    });
  }

  _reloadFlowers() async {
    if (_api != null) {
      final flowers = await _api.getAllFlowers();
      setState(() {
        _flowers = flowers;
      });
    }
  }

  Widget _buildFlowerItem(BuildContext context, int index) {
    Flower flower = _flowers[index];

    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Flexible(
                      child: FlatButton(
                        onPressed: () =>
                            _navigateToFlowerDetails(flower, index),
                        child: Padding(
                          padding: const EdgeInsets.all(1),
                          child: Hero(
                            tag: index,
                            child: Image.network(
                              flower.imageUrl,
                              height: 150,
                              width: 150,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  flower.name,
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _navigateToFlowerDetails(Flower flower, Object avatarTag) {
    Navigator.of(context).push(
      new FadePageRoute(
        builder: (h) {
          return FlowerDetailsPage(flower, avatarTag: avatarTag);
        },
        settings: new RouteSettings(),
      ),
    );
  }

  Widget _getAppTitleWidget() {
    return Container(
      padding: EdgeInsets.only(top: 27),
      width: 250,
      child: Text(
        'The Most Beautiful Flowers In The World',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline,
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg6.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          _getAppTitleWidget(),
          _getListViewWidget(),
        ],
      ),
    );
  }

  Future<Null> refresh() {
    _reloadFlowers();
    return new Future<Null>.value();
  }

  Widget _getListViewWidget() {
    return Flexible(
      child: RefreshIndicator(
        onRefresh: refresh,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
          ),
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: _flowers.length,
          itemBuilder: _buildFlowerItem,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[700],
      body: _buildBody(),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {},
        tooltip: _api != null
            ? 'Signed-in: ' + _api.firebaseUser.displayName
            : 'Not Signed-in',
        backgroundColor: Colors.lightBlue[700],
        child: new CircleAvatar(
          backgroundImage: _profileImage,
          radius: 50.0,
        ),
      ),
    );
  }
}
