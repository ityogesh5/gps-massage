import 'package:flutter/material.dart';

class SearchScreenUser extends StatefulWidget {
  @override
  _SearchScreenUserState createState() => _SearchScreenUserState();
}

class _SearchScreenUserState extends State<SearchScreenUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
          color: Colors.black,
        ),
        title: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          child: TextFormField(
            autofocus: false,
            textInputAction: TextInputAction.search,
            decoration: new InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'キーワードで検索',
                suffixIcon: IconButton(
                  icon:
                      Icon(Icons.search_rounded, color: Colors.grey, size: 30),
                  onPressed: () {},
                ),
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 2.0),
                  borderRadius: BorderRadius.circular(10),
                )),
          ),
        ),
      ),
    );
  }
}
