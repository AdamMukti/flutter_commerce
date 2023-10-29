import 'package:flutter/material.dart';
import 'package:flutter_commerce/src/utility/theme_color.dart';
import 'package:flutter_commerce/src/utility/theme_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Halo, Adam Mukti',
              style: textHeading,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF000000).withOpacity(0.1),
                    blurRadius: 15,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: TextField(
                // onChanged: (value) => _runFilter(value),
                // controller: ListMahasiswa.searchBar,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: textMuted.copyWith(fontSize: 14),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIconColor: primary,
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: textHeading,
                ),
                Text('See All'),
              ],
            ),
          ),
          // ProductCard(),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    ));
  }
}
