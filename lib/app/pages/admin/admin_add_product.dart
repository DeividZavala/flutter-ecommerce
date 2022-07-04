import 'package:ecommerce/app/providers.dart';
import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import "dart:io";

final addImageProvider = StateProvider<XFile?>((_) => null);

class AdminAddProductPage extends ConsumerStatefulWidget {
  const AdminAddProductPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdminAddProductPageState();
}

class _AdminAddProductPageState extends ConsumerState<AdminAddProductPage> {
  final titleEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final priceEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Add product")),
        body: Padding(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomInputFieldFb1(
                      inputController: titleEditingController,
                      labelText: "Product Name",
                      hintText: "Product Name"),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomInputFieldFb1(
                      inputController: descriptionEditingController,
                      labelText: "Product description",
                      hintText: "Product description"),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomInputFieldFb1(
                      inputController: priceEditingController,
                      labelText: "Product price",
                      hintText: "Product price"),
                  const SizedBox(height: 15),
                  Consumer(
                    builder: (context, watch, child) {
                      final image = ref.watch(addImageProvider);
                      return image != null
                          ? Image.file(File(image.path), height: 200)
                          : const Text("No image selected");
                    },
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          ref.watch(addImageProvider.state).state = image;
                        }
                      },
                      child: const Text("Upload image")),
                  ElevatedButton(
                      onPressed: () {
                        _addProduct();
                      },
                      child: const Text("Add Product")),
                ],
              ),
            )));
  }

  _addProduct() async {
    final storage = ref.watch(databaseProvider);
    final fileStorage = ref.watch(storageProvider);
    final imageFile = ref.watch(addImageProvider.state).state;

    if (fileStorage == null || imageFile == null || storage == null) {
      print("Error: storage, fileStorage or imageFile is null");
      return;
    }

    final imageUrl = await fileStorage.uploadFile(imageFile.path);
    await storage.addProduct(Product(
        name: titleEditingController.text,
        description: descriptionEditingController.text,
        imageUrl: imageUrl,
        price: double.parse(priceEditingController.text)));
    Navigator.pop(context);
  }
}

class CustomInputFieldFb1 extends StatelessWidget {
  final TextEditingController inputController;
  final String hintText;
  final Color primaryColor;
  final String labelText;

  const CustomInputFieldFb1(
      {Key? key,
      required this.inputController,
      required this.hintText,
      required this.labelText,
      this.primaryColor = Colors.indigo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextField(
        controller: inputController,
        onChanged: (value) {
          //Do something wi
        },
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          fillColor: Colors.transparent,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          border: UnderlineInputBorder(
            borderSide:
                BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor, width: 2.0),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: primaryColor.withOpacity(.1), width: 2.0),
          ),
        ),
      ),
    );
  }
}
