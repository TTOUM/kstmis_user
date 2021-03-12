import 'package:flutter/material.dart';

class HomeMobile extends StatefulWidget {
  @override
  _HomeMobileState createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          Container(
            margin: EdgeInsets.all(2),
            child: CircleAvatar(
              radius: 35,
              child: Icon(
                Icons.account_circle,
                size: 50,
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
            child: Container(
              padding: EdgeInsets.all(40),
              child: Image(
                image: AssetImage('assets/images/kst.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              'Dashboard',
              style: TextStyle(fontSize: 18),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.card_giftcard),
            title: Text(
              'Products',
              style: TextStyle(fontSize: 18),
            ),
          ),
          ListTile(
            leading: Icon(Icons.category),
            title: Text(
              'Category',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      )),
      body: Container(
        child: Column(
          children: [
            _searchText(),
            _fillterWidget(),
            Expanded(
              child: _bordyContent(),
            ),
          ],
        ),
      ),
    );
  }

  _fillterWidget() {
    return Container(
      margin: EdgeInsets.only(right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            child: Icon(
              Icons.sort,
              size: 40,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  _searchText() {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: TextField(
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          isDense: true,
          filled: true,
          suffixIcon: Icon(
            Icons.search,
            size: 20,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: 'Search',
        ),
      ),
    );
  }

  _bordyContent() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            child: ListTile(
              hoverColor: Colors.grey,
              leading: CircleAvatar(
                radius: 30,
              ),
              title: Text('${index + 1}'),
              subtitle: Text('Name'),
              contentPadding: EdgeInsets.all(8),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
