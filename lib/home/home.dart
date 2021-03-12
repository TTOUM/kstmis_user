import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kstmis/category_page/category_page.dart';
import 'package:kstmis/home/detail.dart';
import 'package:kstmis/models/group.dart';
import 'package:kstmis/models/products.dart';
import 'package:kstmis/products_page/product_page.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'screens/home_mobile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

List<Products> listProduct = [];
List<Products> displayProduct = [];
String rl = 'api.kstmis.me';

class _HomeState extends State<Home> {
  fetchProduct() async {
    final endpoint = Uri.https('$rl', '/public/api/products');
    final response = await http.get(endpoint);
    final jsonString = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        jsonString.forEach((v) {
          final product = Products.fromJson(v);
          listProduct.add(product);
        });
        displayProduct = listProduct;
      });
    } else {
      throw Exception("Failed to load data");
    }
  }

  ///Group Product
  List datas = [];
  List<GroupCategory> groups = [];

  fetchAllDataGroup() async {
    final url = Uri.https(rl, '/public/api/group');
    final response = await http.get(url);
    final jsonToString = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        jsonToString.forEach((v) {
          final group = GroupCategory.fromJson(v);
          groups.add(group);
        });
      });
    } else {
      throw Exception("Failed to load data Group");
    }
  }

  @override
  void initState() {
    fetchProduct();
    fetchAllDataGroup();

    super.initState();
  }

  int tabIndex = 0;
  String title = "Home";

  _switchPage() {
    if (tabIndex == 0) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dashBoard(),
          _searchTextBox(),
          _popUpMenuFilter(),
          SizedBox(
            height: 15,
          ),
          Expanded(child: _bodyContent()),
        ],
      );
    } else if (tabIndex == 1) {
      return ProductPage();
    } else {
      return Container(
        child: Text('About'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (groups.isNotEmpty) {
      datas.clear();
      for (int i = 0; i < groups.length; i++) {
        datas.add(groups[i].l2groupname);

      }
    }
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
          return HomeMobile();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '$title',
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
            leading: Container(
              margin: EdgeInsets.only(
                left: 10,
              ),
              width: 45,
              height: 45,
              child: Center(
                child: Image(
                  image: AssetImage('assets/images/kst.png'),
                  width: 45,
                  height: 45,
                ),
              ),
            ),
            actions: [
              MaterialButton(
                child: Text(
                  'Home',
                  style: TextStyle(
                      color: tabIndex == 0 ? Colors.blue : Colors.black,fontSize: 20),
                ),
                onPressed: () {
                  setState(() {
                    tabIndex = 0;
                    title = "Home";
                  });
                },
              ),
              MaterialButton(
                child: Text(
                  'Products',
                  style: TextStyle(
                      color: tabIndex == 1 ? Colors.blue : Colors.black,fontSize: 20),
                ),
                onPressed: () {
                  setState(() {
                    tabIndex = 1;
                    title = "Products";
                  });
                },
              ),
              MaterialButton(
                child: Text(
                  'About',
                  style: TextStyle(
                      color: tabIndex == 2 ? Colors.blue : Colors.black,fontSize: 20),
                ),
                onPressed: () {
                  setState(() {
                    tabIndex = 2;
                    title = "About";
                  });
                },
              ),
              _popUpMenu(),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          body: Container(
            margin: EdgeInsets.only(bottom: 20),
            child: _switchPage(),
          ),
        );
      },
    );
  }

  _popUpMenu() {
    return PopupMenuButton(
      icon: CircleAvatar(
        radius: 45,
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Text('Sign out'),
        ),
      ],
    );
  }

  _bodyContent() {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(left: 100, right: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // _dashBoard(),
            Divider(),
            // _searchTextBox(),
            displayProduct.isEmpty
                ? Text('No Data ')
                : Container(
                    child: DataTable(
                      showCheckboxColumn: false,
                      dataTextStyle:
                          TextStyle(fontSize: 14, color: Colors.black),
                      // dataRowHeight: 150,
                      headingTextStyle: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      columns: [
                        DataColumn(
                          label: Text('No'),
                        ),
                        DataColumn(
                          label: Text('ID'),
                        ),
                        DataColumn(
                          label: Container(
                            width: 100,
                            child: Text('Product Name'),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: 100,
                            child: Text('Group'),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: 200,
                            child: Text('Category'),
                          ),
                        ),
                        DataColumn(
                          label: Container(
                            width: 200,
                            child: Text('Description'),
                          ),
                        ),
                      ],

                      rows: List.generate(
                        displayProduct.length,
                        (index) {
                          return DataRow(
                            onSelectChanged: (bool value) {
                              if (value) {
                                print('Value===$index');
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Detail(
                                    id: '${displayProduct[index].proid}}',
                                  ),
                                ));
                                print('Value===${displayProduct[index].proid}');
                              }
                            },
                            cells: [
                              DataCell(
                                Text('${index + 1}'),
                              ),
                              DataCell(
                                Text('${displayProduct[index].proid}'),
                              ),
                              DataCell(
                                Text('${displayProduct[index].proname}'),
                              ),
                              DataCell(
                                  Text('${displayProduct[index].l2groupname}')),
                              DataCell(
                                  Text('${displayProduct[index].l3groupname}')),
                              DataCell(
                                Text(
                                  '${displayProduct[index].descriptions}',
                                  maxLines: null,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  _searchTextBox() {
    return Container(
      padding: EdgeInsets.only(
          top: 25,
          left: 100,
          bottom: 30,
          right: MediaQuery.of(context).size.width / 2.5),
      child: TextField(
        decoration: InputDecoration(
          isDense: true,
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(), borderRadius: BorderRadius.circular(8)),
          focusColor: Colors.transparent,
          hintText: "What's would you like to find?",
          prefixIcon: Icon(Icons.search),
        ),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            displayProduct = listProduct.where((element) {
              var proname = element.proname.toLowerCase();
              var id = element.proid.toString();
              var group = element.l2groupname.toLowerCase();
              var cate = element.l3groupname.toLowerCase();
              var des = element.descriptions.toLowerCase();
              return proname.contains(text) ||
                  id.contains(text) ||
                  group.contains(text) ||
                  cate.contains(text) ||
                  des.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _dashBoard() {
    return Container(
      padding: EdgeInsets.only(left: 100, right: 50, top: 50, bottom: 20),
      child: Row(
        children: [
          Image(
            image: AssetImage('assets/images/doctors.png'),
            width: 150,
            height: 150,
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            textBaseline: TextBaseline.ideographic,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _labelText(
                text: 'Product Total: ',
                value: '${listProduct.length}',
              ),
              SizedBox(
                height: 10,
              ),
              _labelText(
                text: 'Group Category: ',
                value: '${datas.length}',
              ),
              SizedBox(
                height: 10,
              ),
              _labelText(
                text: 'Category: ',
                value: '${listProduct.length}',
              ),
            ],
          ),
          VerticalDivider(
            thickness: 1,
            color: Colors.blueAccent,
            width: 1,
          ),
        ],
      ),
    );
  }

  _labelText({String text, String value}) {
    return Row(
      children: [
        Text(
          '$text',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          '$value item',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ],
    );
  }

  _popUpMenuFilter() {
    return Container(
      margin: EdgeInsets.only(left: 100),
      child: Row(
        children: [
          PopupMenuButton(
              // child: Text('Short by'),
              icon: Icon(
                Icons.sort,
                size: 40,
              ),
              onSelected: (value){
                value=value.toString().toLowerCase();
                setState(() {
                  displayProduct=listProduct.where((data){
                    var group = data.l2groupname.toLowerCase();
                    return group.contains(value);
                  }).toList();
                });
              },
              itemBuilder: (context) => List.generate(datas.length, (index) {
                    return CheckedPopupMenuItem(
                      child: Text(
                        datas[index].toString(),
                      ),
                      value: datas[index],
                    );
                  })),
          SizedBox(width: 15,),
          Text('Sort by',style: TextStyle(fontSize: 18),),
        ],
      ),
    );
  }
}
