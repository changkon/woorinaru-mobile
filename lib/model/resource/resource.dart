import 'dart:typed_data';

class Resource {
  int id;
  String description;
  ByteData resource;

  Resource({
    this.id,
    this.description,
    this.resource,
  });

  factory Resource.fromJson(Map<String, dynamic> json) {
    int id = json['id'] as int;
    String description = json['description'] as String;

    return Resource(id: id, description: description);
  }
}
