import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

abstract class FileNavigator {
  onFileChosen(XFile file);
}

class ChooseImageBottomSheet extends StatelessWidget {
  final FileNavigator fileNavigator;
  ChooseImageBottomSheet({Key? key, required this.fileNavigator})
      : super(key: key);
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height/4,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8), topRight: Radius.circular(8)),
      ),
      child: IntrinsicHeight(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
              onTap: () async {
                final pickedFile = await _picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 50,
                    maxHeight: 1500,
                    maxWidth: 1500);
                fileNavigator.onFileChosen(pickedFile!);
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        size: 30,
                      ),
                    ),
                    Text(
                      "Click picture",
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final pickedFile = await _picker.pickImage(
                    source: ImageSource.gallery,
                    imageQuality: 50,
                    maxHeight: 1500,
                    maxWidth: 1500);
                fileNavigator.onFileChosen(pickedFile!);
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.phone_iphone_sharp,
                        size: 30,
                      ),
                    ),
                    Text(
                      "Choose from gallery",
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
