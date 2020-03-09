import 'package:moor_flutter/moor_flutter.dart';

class Customers extends Table{
  IntColumn get id=> integer().autoIncrement()();
  TextColumn get name=> text().withLength(min: 1,max: 255)();
  TextColumn get phone=>text().withLength(min: 5,max: 12)();
  TextColumn get address=>text().withLength(min: 1,max: 255)();
  DateTimeColumn get date=> dateTime().nullable()();
  BoolColumn get isVIP=> boolean().withDefault(Constant(true))();

  @override
  Set<Column> get primaryKey=> {id};
}