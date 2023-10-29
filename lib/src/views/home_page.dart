import 'package:flutter/material.dart';
import 'package:flutter_commerce/core/model/product_model.dart';
import 'package:flutter_commerce/core/service/api_service.dart';
import 'package:flutter_commerce/src/utility/theme_color.dart';
import 'package:flutter_commerce/src/utility/theme_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static TextEditingController _searchController = TextEditingController();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<ProductModel>? _productModel = [];
  late List<ProductModel>? _filteredProductModel = [];
  late List<String>? _categoriesModel = [];
  String selectedCategories = '';
  @override
  void initState() {
    super.initState();
    _getData();
    _getCategories();
  }

  void _getData([String? query]) async {
    if (query?.isNotEmpty == true) {
      _filteredProductModel = (await ApiService().searchProducts(query!));
    } else {
      _filteredProductModel = (await ApiService().getProducts());
    }

    Future.delayed(const Duration(seconds: 1)).then(
      (value) => setState(() {
        _productModel = _filteredProductModel;
      }),
    );
  }

  void _getCategories() async {
    _categoriesModel = (await ApiService().getCategories());

    Future.delayed(const Duration(seconds: 1)).then(
      (value) => setState(() {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _productModel == null || _productModel!.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
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
                        onSubmitted: (value) => _getData(value),
                        controller: HomePage._searchController,
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: List<Widget>.generate(
                          _categoriesModel!.length,
                          (int index) {
                            return FilterChip(
                              label: Text(_categoriesModel![index]),
                              selected: selectedCategories ==
                                  _categoriesModel![index],
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    selectedCategories =
                                        _categoriesModel![index];
                                  } else {
                                    selectedCategories = '';
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      itemCount: _productModel!.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: .8,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    child: Image.network(
                                      _productModel![index].thumbnail,
                                      // width: 100,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Flexible(
                                    child: Text(
                                      _productModel![index].title,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: true,
                                      style: textTitle,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.yellow),
                                      Text(
                                        _productModel![index].rating.toString(),
                                        style: textTitle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    '\$${_productModel![index].price}',
                                    style: textHeading,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: Text('End of result.'),
                    ),
                  ),
                ],
              ),
            ),
    ));
  }
}
