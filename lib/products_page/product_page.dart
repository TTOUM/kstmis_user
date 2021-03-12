import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kstmis/home/detail.dart';
import 'package:kstmis/models/products.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<Products> products = [];
  List<Products> displayProduct = [];

  @override
  void initState() {
    fetchProduct();
    super.initState();
  }

  fetchProduct() async {
    final endpoint = Uri.https('api.kstmis.me', '/public/api/products');
    final response = await http.get(endpoint);
    final jsonString = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        jsonString.forEach((v) {
          final product = Products.fromJson(v);
          products.add(product);
        });
        displayProduct = products;
      });
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: _searchText(),
          ),
          Expanded(
            child: displayProduct.isEmpty
                ? Center(
                    child: Text('Loading...'),
                  )
                : SingleChildScrollView(
                    child: _bodyContent(),
                  ),
          ),
        ],
      ),
    );
  }

  _searchText() {
    final border = const OutlineInputBorder(
      borderSide: BorderSide(),
    );
    return Container(
      margin: EdgeInsets.all(20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        child: TextField(
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
            border: border,
            focusedBorder: border,
            isDense: true,
            hintText: 'Search..',
            prefixIcon: Icon(
              Icons.search,
              size: 40,
            ),
          ),
          onChanged: (text) {
            text = text.toLowerCase();
            setState(() {
              displayProduct = products.where((element) {
                var name = element.proname.toLowerCase();
                var id = element.proid.toString();
                var cateGroup = element.l2groupname.toLowerCase();
                var cate = element.l3groupname.toLowerCase();
                var description = element.descriptions.toLowerCase();
                return name.contains(text) ||
                    id.contains(text) ||
                    cateGroup.contains(text) ||
                    cate.contains(text) ||
                    description.contains(text);
              }).toList();
            });
          },
        ),
      ),
    );
  }

  _bodyContent() {
    return Container(
      margin: EdgeInsets.only(left: 100, right: 100, bottom: 15),
      child: Container(
        child: DataTable(
          showCheckboxColumn: false,
          dataRowHeight: 100,
          dataTextStyle: TextStyle(fontSize: 18, color: Colors.black),
          headingTextStyle: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          columns: [
            DataColumn(
              label: Text('No'),
            ),
            DataColumn(
              label: Text('ID'),
            ),
            DataColumn(
              label: Text('Name'),
            ),
            DataColumn(
              label: Container(
                width: 150,
                child: Text('Group'),
              ),
            ),
            DataColumn(
              label: Text('Category'),
            ),
            DataColumn(
              label: Text('Description'),
            ),
          ],
          rows: List.generate(displayProduct.length, (index) {
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
                  DataCell(Text('${index + 1}')),
                  DataCell(Text('${displayProduct[index].proid}')),
                  DataCell(Text('${displayProduct[index].proname}')),
                  DataCell(Text('${displayProduct[index].l2groupname}')),
                  DataCell(Text('${displayProduct[index].l3groupname}')),
                  DataCell(Text('${displayProduct[index].descriptions}')),
                ]);
          }),
        ),
      ),
    );
  }

  _filterProduct() {
    return Container(
      child: PopupMenuButton(
        itemBuilder: (context) => [
          CheckedPopupMenuItem(
            child: Text('Halo'),
          ),
        ],
      ),
    );
  }
}
