
import 'dart:async';

import 'package:floor/floor.dart';
import 'entity.dart';
import 'tbldao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'database.g.dart';

@Database(version : 2, entities:[TblData])
abstract class AppDatabase extends FloorDatabase{
  TblDao get tblDao;
}