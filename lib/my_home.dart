import 'package:flutter/material.dart';
import 'package:simple_database/customer_detail.dart';
import 'package:simple_database/customer_entry.dart';
import 'package:simple_database/local/app_db.dart';
import 'package:simple_database/local/dao/customer_dao.dart';
import 'package:intl/intl.dart';
import 'package:simple_database/animation/scale_route.dart';
import 'package:provider/provider.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Entry"),
      ),
      body: _buildAllCustomers(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, ScaleRoute(page: CustomerEntry()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
  FutureBuilder _buildAllCustomers(){
    return FutureBuilder<List<Customer>>(
      future: Provider.of<CustomerDao>(context,listen:false).getAllCustomers(),
      builder: (context,AsyncSnapshot<List<Customer>> snapshot){
        if(snapshot.connectionState==ConnectionState.done){
          if(snapshot.hasError){
            return Container(
              child: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          }
          final customers=snapshot.data;
          return _listCustomers(customers);
        }
        else{
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  ListView _listCustomers(List<Customer> customers){
    return ListView.builder(
        itemCount: customers.length,
        itemBuilder: (_,index){
          return Card(
            child: Container(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(customers[index].name),
                subtitle: Text(customers[index].address),
                trailing: IconButton(
                  onPressed: (){Navigator.push(context, ScaleRoute(
                    page:CustomerDetail(
                      customerId:customers[index].id,
                      customerName:customers[index].name
                    )
                  ));
                  },
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ),

            ),
          );
        }
    );
  }
}
