
// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controllers/GetDataController.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  GetDataController getDataController = Get.put(GetDataController());

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return  Scaffold(
      appBar:AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: Obx(() =>
          getDataController.isLoading.value ?
          const Center(
            child: CircularProgressIndicator(),
            )
             : getDataController.dataList != null ? ListView.builder(
              itemCount: getDataController.dataList.length,
              itemBuilder: (context, index){
                return Padding(
                  padding:  EdgeInsets.only(top: size.height*0.002,left: size.width*0.03,right: size.width*0.03),
                  child: Card(
                      child: ListTile(
                        leading: Container(
                          width: size.width*0.12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: NetworkImage('${getDataController.dataList[index].owner!.avatarUrl}'))
                          ),
                        ),
                        title: Text('${getDataController.dataList[index].name}'),
                        subtitle: Text('${getDataController.dataList[index].fullName}'),
                        )),
                );
              }
          )
              : const Center(
            child:Text('Data Not Available'),
          )
       )
    );
  }

  @override
  void initState() {
    getDataController.getData(context);
    super.initState();
  }
}
