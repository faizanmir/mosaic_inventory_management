import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mosaic_inventory_management/base/base_state.dart';
import 'package:mosaic_inventory_management/constants.dart';
import 'package:mosaic_inventory_management/item_details/navigator/item_details_navigator.dart';
import 'package:mosaic_inventory_management/item_details/ui/update_rate_count_dialog.dart';
import 'package:mosaic_inventory_management/item_details/viewModel/item_details_view_model.dart';
import 'package:provider/provider.dart';

import 'choose_image_bottom_sheet.dart';

class ItemDetailsScreen extends StatefulWidget {
  final int id;
  final int categoryId;
  const ItemDetailsScreen(
      {Key? key, required this.id, required this.categoryId})
      : super(key: key);

  @override
  _ItemDetailsScreenState createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState
    extends BaseState<ItemDetailsScreen, ItemDetailsViewModel>
    implements ItemDetailsNavigator, FileNavigator {
  @override
  AppBar buildAppBar() {
    return AppBar(
      title: const Text("Item details"),
    );
  }

  @override
  Widget buildBody() {
    return Consumer<ItemDetailsViewModel>(
      builder: (_, __, ___) => (viewModel.item != null)
          ? ListView(
              primary: true,
              padding: const EdgeInsets.only(
                  left: 10, top: 10, right: 10, bottom: 100),
              children: [
                buildHeadingSection(),
                const Text(
                  "Tap on rate or count to edit ",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
                ),
                (viewModel.item!.files!.isNotEmpty)
                    ? buildImageGrid()
                    : const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "No Images present for the item, "
                          "You can add some images by "
                          "pressing + the button in the corner",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
              ],
            )
          : showProgressBar(),
    );
  }

  Widget buildImageGrid() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text("Images ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          ),
          GridView.builder(
              shrinkWrap: true,
              itemCount: viewModel.item?.files!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (_, idx) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Stack(
                    children: [
                      Image.network(
                        viewModel.item!.files![idx].url,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width,
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                            onTap: () {
                              viewModel.deleteFile(
                                  widget.id, viewModel.item!.files![idx].id);
                            },
                            child: Icon(
                              Icons.cancel,
                              color: Colors.red.withOpacity(0.7),
                              size: 30,
                            )),
                      ),
                    ],
                  ),
                );
              }),
        ],
      ),
    );
  }

  @override
  getNavigator() => this;

  @override
  PageIdentifier getPageIdentifier() => PageIdentifier.itemDetails;

  @override
  void loadPageData({value}) {
    viewModel.getItem(widget.id);
  }

  @override
  onFloatingActionButtonPressed() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.white,
      context: context,
      builder: (_) => ChooseImageBottomSheet(
        fileNavigator: this,
      ),
    );
  }

  @override
  Future<bool> provideOnWillPopScopeCallBack() {
    return Future.value(true);
  }

  @override
  showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void onImageAdded() {
    loadPageData();
  }

  @override
  onFileChosen(XFile xFile) {
    viewModel.addFilesToItem(widget.id, xFile);
  }

  @override
  void onImageDeleted() {
    loadPageData();
  }

  Widget buildHeadingSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${viewModel.item?.name}",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        InkWell(
          onTap: () {
            showParameterChangeDialog(false,
                (p0) => viewModel.changeRate(widget.categoryId, widget.id, p0));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Rate",
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 18)),
                Text("${viewModel.item?.rate}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 18)),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            showParameterChangeDialog(
                false,
                (p0) =>
                    viewModel.changeCount(widget.categoryId, widget.id, p0));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Count",
                    style:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 18)),
                Text("${viewModel.item?.count}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 18)),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  showParameterChangeDialog(bool isCount, Function(double) onParameterChange) {
    showDialog(
        context: context,
        builder: (_) => ParameterChangeDialog(
            isCount: isCount, onParameterChange: onParameterChange));
  }

  @override
  void refresh() {
    loadPageData();
  }
}
