// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:management_store/screens/dataclass.dart';
import 'package:management_store/screens/form_screen.dart';

import 'apiservices.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // buat variable getalldata
  Service serviceAPI = Service();
  late Future<List<storeData>> listData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // untuk memanggil getalldata
    listData = serviceAPI.getAllData();
  }

  FutureOr onGoBack(dynamic value) {
    setState(() {
      listData = serviceAPI.getAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Management Store App"),
        backgroundColor: Colors.teal[600],
        actions: const [],
      ),
      body: Container(
        child: FutureBuilder<List<storeData>>(
          future: listData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<storeData> isiData = snapshot.data!;
              return ListView.builder(
                itemCount: isiData.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blueGrey[400],
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 16, top: 10),
                                child: Text(
                                  isiData[index].name!,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 16, bottom: 10),
                                child: Text(
                                  isiData[index].description!,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                              // Container(
                              //   padding: const EdgeInsets.only(left: 16),
                              //   child: Text(
                              //     'stock : ${isiData[index].stock!}',
                              //     style: const TextStyle(fontSize: 15),
                              //   ),
                              // )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 16, top: 0),
                              child: Text(
                                isiData[index].stock!,
                                style: const TextStyle(fontSize: 17),
                              ),
                            )
                          ],
                        ),

                        IconButton(
                            onPressed: () {
                              deleteData('${isiData[index].id}');
                            },
                            icon: const Icon(Icons.delete))
                        //aku cmn
                        // if (isiData[index].stock != 0) {return Container(child: ,),}
                        // Column(
                        //   crossAxisAlignment: CrossAxisAlignment.end,
                        //   children: [
                        //     if(isiData[index].stock != 0) {

                        //     } else {

                        //     }
                        //   ],
                        // )
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            ;
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FormScreen()));
        },
        backgroundColor: Colors.blueGrey[200],
        child: const Icon(Icons.add),
      ),
    );
  }

  void deleteData(id) async {
    bool response = await serviceAPI.deleteData(id);
    if (response == true) {
      setState(() {
        listData = serviceAPI.getAllData();
      });
    } else {
      log("error = data tidak dapat dihapus");
    }
  }
}
