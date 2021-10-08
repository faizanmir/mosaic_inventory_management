import 'package:mosaic_inventory_management/models/document.dart';

class Item{
  List<Document>?files;
   int? id;
   String? name;
   double? rate;
   double? count;

//<editor-fold desc="Data Methods">

  Item({
    required this.files,
    required this.id,
    required this.name,
    required this.rate,
    required this.count,
  });







  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          runtimeType == other.runtimeType &&
          files == other.files &&
          id == other.id &&
          name == other.name &&
          rate == other.rate &&
          count == other.count);

  @override
  int get hashCode =>
      files.hashCode ^
      id.hashCode ^
      name.hashCode ^
      rate.hashCode ^
      count.hashCode;

  @override
  String toString() {
    return 'Item{' +
        ' files: $files,' +
        ' id: $id,' +
        ' name: $name,' +
        ' rate: $rate,' +
        ' count: $count,' +
        '}';
  }

  Item copyWith({
    List<Document>? files,
    int? id,
    String? name,
    double? rate,
    double? count,
  }) {
    return Item(
      files: files ?? this.files,
      id: id ?? this.id,
      name: name ?? this.name,
      rate: rate ?? this.rate,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'files': this.files,
      'id': this.id,
      'name': this.name,
      'rate': this.rate,
      'count': this.count,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    List<Document> docList  =  [];
    if(map['files']!=null) {
      map['files'].forEach((e) {
        docList.add(Document.fromMap(e));
      });
    }
    return Item(
      files: docList,
      id: map['id'] as int?,
      name: map['name'] as String?,
      rate: map['rate'] as double?,
      count: map['count'] as double?,
    );
  }

//</editor-fold>
}