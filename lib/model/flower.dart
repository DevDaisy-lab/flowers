import 'package:meta/meta.dart';

class Flower {
  final String documentId;
  final int externalId;
  final String name;
  final String description;

  //final String harvesting;
  //final String use;
  final String imageUrl;

  Flower({
    @required this.documentId,
    @required this.externalId,
    @required this.name,
    @required this.description,
    // @required this.harvesting,
    // @required this.use,
    @required this.imageUrl,
  });
}
