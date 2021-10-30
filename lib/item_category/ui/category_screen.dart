import 'package:flutter/material.dart';
import 'package:mosaic_inventory_management/base/base_state.dart';
import 'package:mosaic_inventory_management/constants.dart';
import 'package:mosaic_inventory_management/item_category/navigator/item_category_navigator.dart';
import 'package:mosaic_inventory_management/item_category/viewModel/category_view_model.dart';
import 'package:mosaic_inventory_management/items/ui/items_screen.dart';
import 'package:mosaic_inventory_management/login/ui/login_ui.dart';
import 'package:provider/provider.dart';

class CategoryListing extends StatefulWidget {
  const CategoryListing({Key? key}) : super(key: key);

  @override
  _CategoryListingState createState() => _CategoryListingState();
}

class _CategoryListingState
    extends BaseState<CategoryListing, CategoryViewModel>
    implements CategoryNavigator {
  @override
  AppBar buildAppBar() {
    return AppBar(
      leading: null,
      title: const Text("Categories"),
      actions: [
        IconButton(onPressed: (){
          viewModel.onLogout();
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>const LoginScreen()));
        }, icon: const Icon(Icons.logout))
      ],
    );
  }

  @override
  Widget buildBody() {
    return Consumer<CategoryViewModel>(
      builder: (_, __, ___) => (viewModel.userCategoryResponse != null)
          ? (viewModel.userCategoryResponse?.categories != null &&
                  viewModel.userCategoryResponse!.categories!.isNotEmpty)
              ? ListView.separated(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, bottom: 50, top: 10),
                  shrinkWrap: true,
                  primary: true,
                  itemBuilder: (_, idx) => Dismissible(
                        key: UniqueKey(),
                        background: Container(
                          color: Colors.red,
                        ),
                        onDismissed: (direction) {
                          viewModel.deleteCategory(viewModel
                              .userCategoryResponse!.categories![idx].id!);
                        },
                        child: ListTile(
                          trailing: Container(
                              height: 10,
                              width: 10,
                              decoration: (viewModel.userCategoryResponse!
                                      .categories![idx].requiresAction!)
                                  ? const BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    )
                                  : const BoxDecoration()),
                          title: Text(
                              "${viewModel.userCategoryResponse!.categories![idx].categoryName}"),
                          onTap: () {
                            push(
                                widget: ItemsPage(
                                    categoryId: viewModel.userCategoryResponse!
                                        .categories![idx].id!));
                          },
                        ),
                      ),
                  separatorBuilder: (_, idx) => Container(
                        color: Colors.grey,
                        height: 1,
                      ),
                  itemCount: viewModel.userCategoryResponse!.categories!.length)
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Flexible(child: Text("No items added"))],
                  ),
                )
          : showProgressBar(),
    );
  }

  @override
  getNavigator() {
    return this;
  }

  @override
  PageIdentifier getPageIdentifier() {
    return PageIdentifier.categoryListing;
  }

  @override
  void loadPageData({value}) {
    viewModel.getCategories();
  }

  @override
  Future<bool> provideOnWillPopScopeCallBack() => Future.value(false);

  @override
  onFloatingActionButtonPressed() {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => CategoryDialog(
              onCategoryAdded: (value) {
                viewModel.addCategory(value);
              },
            ));
  }

  @override
  onCategoryAdded() {
    loadPageData();
  }

  @override
  onCategoryDeleted() {
    loadPageData();
  }

  @override
  showMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class CategoryDialog extends StatelessWidget {
  final Function onCategoryAdded;
  final _controller = TextEditingController();
  CategoryDialog({Key? key, required this.onCategoryAdded}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 3,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Enter Category name",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  label: Text("Category Name"),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                ),
              ),
              MaterialButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    onCategoryAdded(_controller.text);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text("Add Category"),
                color: Colors.blue,
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
