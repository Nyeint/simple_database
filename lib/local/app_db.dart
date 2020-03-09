import 'package:moor_flutter/moor_flutter.dart';
import 'package:simple_database/local/dao/customer_dao.dart';
import 'package:simple_database/local/model/customer_table.dart';

part 'app_db.g.dart';

@UseMoor(tables:[Customers],daos: [CustomerDao])

class AppDb extends _$AppDb{
  AppDb() : super(FlutterQueryExecutor.inDatabaseFolder(
      path: 'db.sqlite',logStatements: true));

  @override
  int get schemaVersion =>1;

  Future <List<Customer>>getAllCustomers() => select(customers).get();
  Future insertCustomer(Insertable<Customer> customer) =>into(customers).insert(customer);
  Future updateCustomer(Insertable<Customer> customer) =>update(customers).replace(customer);
  Future deleteCustomer(Insertable<Customer> customer) =>delete(customers).delete(customer);
  Future <Customer> getCustomer(int id){
    return (select(customers)..where((customers) => customers.id.equals(id))).getSingle();
  }


}