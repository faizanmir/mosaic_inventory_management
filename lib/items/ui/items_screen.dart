import 'package:flutter/material.dart';
import 'package:mosaic_inventory_management/base/base_state.dart';
import 'package:mosaic_inventory_management/constants.dart';
import 'package:mosaic_inventory_management/items/navigator/item_navigator.dart';
import 'package:mosaic_inventory_management/items/viewModel/items_view_model.dart';

class ItemsPage extends StatefulWidget {
  final int categoryId;
  const ItemsPage({Key? key, required this.categoryId}) : super(key: key);

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends BaseState<ItemsPage,ItemsViewModel> implements ItemNavigator{


  @override
  AppBar buildAppBar() =>AppBar(title: const Text("Items"),);
  @override
  Widget buildBody() {
    return Container();
  }

  @override
  getNavigator() =>this;

  @override
  PageIdentifier getPageIdentifier() =>PageIdentifier.itemsListing;

  @override
  void loadPageData({value}) {
    viewModel.getItems(widget.categoryId);
  }

  @override
  onFloatingActionButtonPressed() {
    viewModel.addItem(widget.categoryId, "test-flutter", 1000, 10000);
  }

  @override
  Future<bool> provideOnWillPopScopeCallBack() =>Future.value(true);

  @override
  onItemUploadFailed(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  onItemUploaded(String message) {
    loadPageData();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
