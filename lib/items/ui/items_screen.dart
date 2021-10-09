import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mosaic_inventory_management/base/base_state.dart';
import 'package:mosaic_inventory_management/constants.dart';
import 'package:mosaic_inventory_management/item_details/ui/item_details_screen.dart';
import 'package:mosaic_inventory_management/items/navigator/item_navigator.dart';
import 'package:mosaic_inventory_management/items/ui/add_item_dialog.dart';
import 'package:mosaic_inventory_management/items/viewModel/items_view_model.dart';
import 'package:provider/provider.dart';

class ItemsPage extends StatefulWidget {
  final int categoryId;
  const ItemsPage({Key? key, required this.categoryId}) : super(key: key);

  @override
  _ItemsPageState createState() => _ItemsPageState();
}

class _ItemsPageState extends BaseState<ItemsPage, ItemsViewModel>
    implements ItemNavigator {
  @override
  AppBar buildAppBar() => AppBar(
        title: const Text("Items"),
      );
  @override
  Widget buildBody() {
    return Consumer<ItemsViewModel>(
      builder: (_, vm, __) => (vm.itemWrapper != null &&
              vm.itemWrapper?.items != null)
          ? (vm.itemWrapper!.items.isNotEmpty)
              ? ListView.separated(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 100),
                  itemBuilder: (_, index) => Dismissible(
                        background: Container(
                          color: Colors.red,
                        ),
                        key: UniqueKey(),
                        onDismissed: (dir) {
                          viewModel.deleteItem(vm.itemWrapper!.items[index].id!,
                              widget.categoryId);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              // viewModel.getItem(vm.itemWrapper!.items[index].id!);
                              push(
                                  widget: ItemDetailsScreen(
                                      id: vm.itemWrapper!.items[index].id!,
                                      categoryId: widget.categoryId));
                            },
                            child: Column(
                              children: [
                                () {
                                  if (vm.itemWrapper!.items[index].files!
                                      .isNotEmpty) {
                                    return Image.network(
                                      vm.itemWrapper!.items[index].files!.first
                                          .url,
                                      fit: BoxFit.fitWidth,
                                      height: 100,
                                      width: MediaQuery.of(context).size.width,
                                    );
                                  }
                                  return Container();
                                }(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "${vm.itemWrapper?.items[index].name}",
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Colors.red,
                                          ),
                                          onPressed: () {
                                            onChangeCountInitiated(
                                                isIncrement: false,
                                                onCountChange: (value) {
                                                  viewModel.updateCountForItem(
                                                      widget.categoryId,
                                                      vm.itemWrapper!
                                                          .items[index].id!,
                                                      value);
                                                },
                                                count: vm.itemWrapper
                                                    ?.items[index].count);
                                          },
                                        ),
                                        Text(
                                            "${vm.itemWrapper?.items[index].count}"),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.add,
                                            color: Colors.green,
                                          ),
                                          onPressed: () {
                                            onChangeCountInitiated(
                                                isIncrement: true,
                                                onCountChange: (value) {
                                                  viewModel.updateCountForItem(
                                                      widget.categoryId,
                                                      vm.itemWrapper!
                                                          .items[index].id!,
                                                      value);
                                                },
                                                count: vm.itemWrapper
                                                    ?.items[index].count);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  separatorBuilder: (_, index) => Container(
                        height: 1,
                        color: Colors.black26,
                      ),
                  itemCount: vm.itemWrapper?.items.length ?? 0)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Center(child: Text("No items present for the category"))
                  ],
                )
          : showProgressBar(),
    );
  }

  @override
  getNavigator() => this;

  @override
  PageIdentifier getPageIdentifier() => PageIdentifier.itemsListing;

  @override
  void loadPageData({value}) {
    viewModel.getItems(widget.categoryId);
  }

  @override
  onFloatingActionButtonPressed() {
    // viewModel.addItem(widget.categoryId,
    //     "test-flutter ${DateTime.now().second}", 1000, 10000);
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: AddItemDialog(
          onItemAdded: (item) => viewModel.addItem(
              widget.categoryId, "${item.name}", item.rate!, item.count!),
        ),
      ),
    );
  }

  @override
  Future<bool> provideOnWillPopScopeCallBack() => Future.value(true);

  @override
  onItemUploadFailed(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  onItemUploaded(String message) {
    loadPageData();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
    loadPageData();
  }

  @override
  showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  onChangeCountInitiated(
      {bool? isIncrement, Function? onCountChange, double? count}) {
    showDialog(
        context: context,
        builder: (_) => CountChangeDialog(
              isIncrement: isIncrement!,
              onCountChange: onCountChange!,
              count: count!,
            ));
  }
}

class CountChangeDialog extends StatefulWidget {
  final bool isIncrement;
  final Function onCountChange;
  final double count;

  const CountChangeDialog(
      {Key? key,
      required this.isIncrement,
      required this.onCountChange,
      required this.count})
      : super(key: key);

  @override
  _CountChangeDialogState createState() => _CountChangeDialogState();
}

class _CountChangeDialogState extends State<CountChangeDialog> {
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              child: Text(
                widget.isIncrement
                    ? "Please enter the quantity to increase "
                    : "Please enter the quantity to decrease ",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: controller,
              decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  )),
            ),
            MaterialButton(
              textColor: Colors.white,
              child: const Text("Change"),
              color: Colors.blue,
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  var change = double.parse(controller.text);
                  if (widget.isIncrement) {
                    widget.onCountChange(change + widget.count);
                  } else {
                    if (widget.count - change >= 0) {
                      widget.onCountChange(widget.count - change);
                    }
                  }
                  Navigator.of(context).pop();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
