import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_database/local/app_db.dart';
import 'package:simple_database/local/dao/customer_dao.dart';

class CustomerDetail extends StatefulWidget {
  final int customerId;
  final String customerName;

  CustomerDetail({
    @required this.customerId,
    @required this.customerName
});

  @override
  _CustomerDetailState createState() => _CustomerDetailState();
}

class _CustomerDetailState extends State<CustomerDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customerName),
      ),
      body: FutureBuilder<Customer>(
        future: Provider.of<CustomerDao>(context,listen:false).getCustomer(widget.customerId),
        builder: (context,AsyncSnapshot<Customer> snapshot){
          if(snapshot.connectionState==ConnectionState.done){
            if(snapshot.hasError){
              print(snapshot.error.toString());
            }
            final customers=snapshot.data;
            return Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10),
                  Text("Name: ${customers.name}",style: TextStyle(fontSize: 16),),
                  SizedBox(height: 10),
                  Text("Address: ${customers.address}",style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text("Date: ${customers.date}",style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text("Ph: ${customers.phone}",style: TextStyle(fontSize: 16))
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
