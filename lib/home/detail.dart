import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kstmis/models/products.dart';

class Detail extends StatefulWidget {
  final String id;

  const Detail({Key key, this.id}) : super(key: key);

  @override
  _DetailState createState() => _DetailState(id);
}

class _DetailState extends State<Detail> {
  final String id;

  _DetailState(this.id);

  List<Products> productDetail = [];

  @override
  void initState() {
    getProductData();
    super.initState();
  }

  getProductData() async {
    final url = Uri.https('api.kstmis.me', '/public/api/products/$id');
    final response = await http.get(url);
    final jsonString = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print('Connected');
      setState(() {
        jsonString.forEach((v) {
          final product = Products.fromJson(v);
          productDetail.add(product);
        });
      });
    } else {
      print('Error Status code====${response.statusCode}');
    }
    print('${productDetail.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Product Detail',
                style: TextStyle(fontSize: 40),
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: productDetail.isEmpty
                    ? Center(
                        child: Text('Loading...'),
                      )
                    : _detail(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _textDisplay({String label, String value}) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          '$value',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ],
    );
  }

  _detail() {
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Image(
              image: AssetImage('assets/images/pills.png'),
              height: 300,
              width: 300,
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Column(
            children: List.generate(productDetail.length, (index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _textDisplay(
                    label: 'ID',
                    value: '${productDetail[index].proid}',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _textDisplay(
                    label: 'Name',
                    value: '${productDetail[index].proname}',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _textDisplay(
                    label: 'Group',
                    value: '${productDetail[index].l2groupname}',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  _textDisplay(
                    label: 'Category',
                    value: '${productDetail[index].l3groupname}',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Description',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      '${productDetail[index].descriptions}',
                      style: TextStyle(fontSize: 18),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                    ),
                    height: 500,
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: EdgeInsets.all(15),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
