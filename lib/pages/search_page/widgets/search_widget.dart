import 'package:flutter/material.dart';

import '../../../constant/theme.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16,),
      child: TextField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white12,
          prefixIcon: Icon(Icons.search,color: Colors.white,),
          suffixIcon: Icon(Icons.close,color: Colors.white,),
          labelText: "Search",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide(color: Colors.yellowAccent),
          ),
        ),
      ),
    );
  }
}
