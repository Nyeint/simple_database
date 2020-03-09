import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_database/local/app_db.dart';

import 'local/dao/customer_dao.dart';

class CustomerEntry extends StatefulWidget {
  @override
  _CustomerEntryState createState() => _CustomerEntryState();
}

class _CustomerEntryState extends State<CustomerEntry> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController(
      text: new DateTime.now().toString());
  final TextEditingController _phoneController = TextEditingController(
      text: "09");

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Entery"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: TextFormField(
                    controller: _nameController,
                    maxLines: 1,
                    validator: (value) {
                      if (value.length < 1 || value.length > 255) {
                        return "Name must be within 1 to 255 charachers";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Name",
                        labelText: "customer's name",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                Container(
                  child: TextFormField(
                    controller: _addressController,
                    maxLines: 1,
                    validator: (value) {
                      if (value.length < 1 || value.length > 255) {
                        return "Address must be within 1 to 255 charachers";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Address",
                        labelText: "customer's address",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2)
                        )
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                FormBuilder(
                  key: _fbKey,
                  initialValue: {
                    'date': DateTime.now(),
                    'accept_terms': false
                  },
                  autovalidate: true,
                  child: FormBuilderDateTimePicker(
                    attribute: "date",
                    inputType: InputType.date,
                    format: DateFormat("dd-MM-yyyy"),
                    decoration: InputDecoration(
                        labelText: "Date"),
                    onChanged: (value) {
                      _dobController.text = value.toString();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                Container(
                  child: TextFormField(
                    controller: _phoneController,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    maxLines: 1,
                    validator: (value) {
                      RegExp exp = RegExp(r'^[0-9]+$');
                      if (!exp.hasMatch(value) || value.length < 6) {
                        return "Phone format invalid";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: ("Phone Number"),
                        labelText: ("Ph no."),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2)
                        )
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            var name = _nameController.text;
            var address = _addressController.text;
            var phone = _phoneController.text;
            var date = DateTime.parse(_dobController.text);
            print(
                "HHHello name=$name  &&  address=$address  &&  phone=$phone && date=$date");
            Customer customer = Customer(
              id: null,
              name: _nameController.text,
              address: _addressController.text,
              phone: _phoneController.text,
              date: DateTime.parse(_dobController.text),
            );
            await Provider.of<CustomerDao>(context, listen: false)
                .insertCustomer(customer);
            Navigator.pop(context);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}