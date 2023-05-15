import 'package:floor/floor.dart';
import 'entity.dart';

@dao
abstract class TblDao{

  @Query('SELECT * FROM TblData')
  Future<List<TblData>> getAllData();

  @insert
  Future<void> insertData(TblData tblData);

  @delete
  Future<void> deleteData(TblData tblData);
}