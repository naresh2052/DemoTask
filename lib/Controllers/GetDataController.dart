// ignore_for_file: invalid_use_of_protected_member, use_build_context_synchronously, unnecessary_null_comparison

import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../DataBase/entity.dart';
import '../DataBase/tbldao.dart';
import '../Model/DataModel.dart';
import '../Utils/AppConstants.dart';

class GetDataController extends GetxController{

  var isLoading = false.obs;
  TblDao? tblDao;
  RxList<DataModel> dataList= <DataModel>[].obs;
  Future getData(BuildContext context, TblDao? tblDao)async{
   try{

       isLoading.value = true;
       final dio = Dio();
       var response = await dio.get(AppConstants.url);
       log('ApiResponce = ${response.data}');
       if (response.statusCode == 200) {
         for (var i in response.data) {
           dataList.value.add(DataModel.fromJson(i));
             tblDao!.insertData(
                 TblData(
                   name:DataModel.fromJson(i).name!,
                   fullName: DataModel.fromJson(i).fullName!,
                   avatarUrl: DataModel.fromJson(i).owner!.avatarUrl!,
                 )
             );
         }
         isLoading.value = false;
       }
   }catch(e){
     print(e.toString());
   }
  }
}
