class Document{
   int id;
   String fileName;
   String url;
   int size;
   String fileType;

//<editor-fold desc="Data Methods">

  Document({
    required this.id,
    required this.fileName,
    required this.url,
    required this.size,
    required this.fileType,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Document &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          fileName == other.fileName &&
          url == other.url &&
          size == other.size &&
          fileType == other.fileType);

  @override
  int get hashCode =>
      id.hashCode ^
      fileName.hashCode ^
      url.hashCode ^
      size.hashCode ^
      fileType.hashCode;

  @override
  String toString() {
    return 'Document{' +
        ' id: $id,' +
        ' fileName: $fileName,' +
        ' url: $url,' +
        ' size: $size,' +
        ' fileType: $fileType,' +
        '}';
  }

  Document copyWith({
    int? id,
    String? fileName,
    String? url,
    int? size,
    String? fileType,
  }) {
    return Document(
      id: id ?? this.id,
      fileName: fileName ?? this.fileName,
      url: url ?? this.url,
      size: size ?? this.size,
      fileType: fileType ?? this.fileType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'fileName': this.fileName,
      'url': this.url,
      'size': this.size,
      'fileType': this.fileType,
    };
  }

  factory Document.fromMap(Map<String, dynamic> map) {
    return Document(
      id: map['id'] as int,
      fileName: map['fileName'] as String,
      url: map['url'] as String,
      size: map['size'] as int,
      fileType: map['fileType'] as String,
    );
  }

//</editor-fold>
}