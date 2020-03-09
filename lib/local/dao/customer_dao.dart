import 'package:moor_flutter/moor_flutter.dart';
import 'package:simple_database/local/app_db.dart';
import 'package:simple_database/local/model/customer_table.dart';

part 'customer_dao.g.dart';

@UseDao(
  tables:[Customers]
)

class CustomerDao extends DatabaseAccessor<AppDb> with _$CustomerDaoMixin{
  final AppDb db;
  CustomerDao(this.db):super(db);

  Future <List<Customer>>getAllCustomers() => select(customers).get();
  Future insertCustomer(Insertable<Customer> customer) =>into(customers).insert(customer);
  Future updateCustomer(Insertable<Customer> customer) =>update(customers).replace(customer);
  Future deleteCustomer(Insertable<Customer> customer) =>delete(customers).delete(customer);
  Future <Customer> getCustomer(int id){
    return (select(customers)..where((customers) => customers.id.equals(id))).getSingle();
  }

}