// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:management_store/screens/apiservices.dart';

class FormScreen extends StatefulWidget {
  FormScreen({Key? key}) : super(key: key);
  int? id;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  bool editForm = false;
  bool result = false;

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController stock = TextEditingController();

  Service serviceAPI = Service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    labelText: "Nama barang",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: description,
                  decoration: const InputDecoration(
                    labelText: "Deskripsi barang",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: stock,
                  decoration: const InputDecoration(
                    labelText: "Stock barang",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () async {
                      result = await serviceAPI.postData(
                          name.text, description.text, stock.text);
                      if (result) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Simpan Data"),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Batal"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

//   void tambahData() async {
//     bool response = await serviceApi.postData('name', 'description', 'stock');

//     if (response = true) {
//       setState(() {
//         listData = serviceAPI.getAllData();
//       });
//     }
//   }
}
