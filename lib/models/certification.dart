class Certification {
  final int? id;
  final String certName;
  final String certType;
  final String? certDescription;
  final String? imageUrl;

  Certification({
    this.id,
    required this.certName,
    required this.certType,
    this.certDescription,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cert_name': certName,
      'cert_type': certType,
      'cert_description': certDescription,
      'image_url': imageUrl,
    };
  }

  factory Certification.fromMap(Map<String, dynamic> map) {
    return Certification(
      id: map['id'] as int?,
      certName: map['cert_name'] as String,
      certType: map['cert_type'] as String,
      certDescription: map['cert_description'] as String?,
      imageUrl: map['image_url'] as String?,
    );
  }
}
