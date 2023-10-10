class storeData {
  int? id;
  String? name;
  String? description;
  String? stock;

  storeData({
    required this.id,
    required this.name,
    required this.description,
    required this.stock,
  });

  factory storeData.fromJson(Map<String, dynamic> json) {
    return storeData(
      id: json['id'] != null ? (json['id'] as int?)?.toInt() : null,
      name: json['name'] as String?,
      description: json['description'] as String?,
      stock: json['stock'] as String?,
    );
  }
}
