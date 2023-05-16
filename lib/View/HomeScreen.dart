
// ignore_for_file: invalid_use_of_protected_member, unnecessary_null_comparison

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../Controllers/GetDataController.dart';
import '../DataBase/tbldao.dart';

class HomeScreen extends StatefulWidget {
  TblDao tblDao;
  HomeScreen({Key? key,required this.tblDao}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  GetDataController getDataController = Get.put(GetDataController());

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return  StreamBuilder<ConnectivityResult>(
       stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot){
          return Scaffold(
              appBar:AppBar(
                title: const Text('Home Screen'),
                centerTitle: true,
              ),
              body: Obx(() =>
              getDataController.isLoading.value ?
              Center(
                child: Container(
                    height: size.height*0.13,
                    width: size.width*0.13,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                    ),
                    child: const Center(
                      child: SpinKitFadingCircle(
                        color: Colors.white,
                        size: 50.0,
                      ),
                    )),
              )
                  :snapshot.data != ConnectivityResult.none
                  ? ListView.builder(
                  itemCount: getDataController.dataList.length,
                  itemBuilder: (context, index ){
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
                  :buildListView()
              )
          );
        }
    );
  }

  @override
  void initState() {
    getDataController.getData(context,widget.tblDao);
    super.initState();
  }



  Widget buildListView(){
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: widget.tblDao.getAllData(),
        builder: (index,snapshot){
          if (snapshot.data == null) {
            return Center(
                child: Text(
                  '',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: size.width * .05,
                      fontWeight: FontWeight.w500),
                ));
          }else{
            return  ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index){
                  return Padding(
                    padding:  EdgeInsets.only(top: size.height*0.002,left: size.width*0.03,right: size.width*0.03),
                    child: Card(
                        child: ListTile(
                          // leading: Container(
                          //   width: size.width*0.12,
                          //   decoration: BoxDecoration(
                          //       shape: BoxShape.circle,
                          //       image: DecorationImage(image: NetworkImage(snapshot.data![index].avatarUrl))
                          //   ),
                          // ),
                          title: Text(snapshot.data![index].name),
                          subtitle: Text(snapshot.data![index].fullName,),
                        )),
                  );
                }
            );
          }
        });
  }

}
