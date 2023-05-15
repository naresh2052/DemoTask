

import 'package:floor/floor.dart';

@entity
class TblData{

  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
  String fullName;
  String avatarUrl;

  TblData({this.id,required this.name,required this.fullName,required this.avatarUrl});
}