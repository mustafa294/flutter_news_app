class Source {
  dynamic id;
  String? name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) {
    return Source(
      id: json['id'] == null ? "" : json['id'],
      name: json['name'] == null ? "" : json['name'],
    );
  }
}
