import 'package:mosaic_inventory_management/models/item.dart';

class ItemWrapper {
  List<Item> items;

//<editor-fold desc="Data Methods">

  ItemWrapper({
    required this.items,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemWrapper &&
          runtimeType == other.runtimeType &&
          items == other.items);

  @override
  int get hashCode => items.hashCode;

  @override
  String toString() {
    return 'ItemWrapper{' + ' items: $items,' + '}';
  }

  ItemWrapper copyWith({
    List<Item>? items,
  }) {
    return ItemWrapper(
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'items': this.items,
    };
  }

  factory ItemWrapper.fromMap(Map<String, dynamic> map) {
    List<Item> itemsList = [];
    map['items'].forEach((e) {
      itemsList.add(Item.fromMap(e));
    });

    return ItemWrapper(items: itemsList);
  }

//</editor-fold>
}
