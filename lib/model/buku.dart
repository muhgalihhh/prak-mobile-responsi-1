class Buku {
  int? id;
  int? totalPages;
  String? paperType;
  String? dimensions;
  DateTime? createdAt;
  DateTime? updatedAt;

  Buku({
    this.id,
    this.totalPages,
    this.paperType,
    this.dimensions,
    this.createdAt,
    this.updatedAt,
  });

  factory Buku.fromJson(Map<String, dynamic> json) {
    return Buku(
      id: json['id'],
      totalPages: json['total_pages'],
      paperType: json['paper_type'],
      dimensions: json['dimensions'].toString(), // Ubah menjadi String
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
