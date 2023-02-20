import 'package:flutter/material.dart';

import './details.dart';
import '../models/data.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _pageController = PageController(viewportFraction: 0.75);
  double _currentPage = 0.0;
  double indexPage = 0.0;

  void _listener() {
    setState(() {
      _currentPage = _pageController.page!;
      if (_currentPage >= 0 && _currentPage < 0.7) {
        indexPage = 0;
      } else if (_currentPage > 0.7 && _currentPage < 1.7) {
        indexPage = 1;
      } else if (_currentPage > 1.7 && _currentPage < 2.7) {
        indexPage = 2;
      }
    });
  }

  Color getColor() {
    late final Color color;
    if (_currentPage >= 0 && _currentPage < 0.7) {
      color = listShoes[0].listImage[0].color;
    } else if (_currentPage > 0.7 && _currentPage < 1.7) {
      color = listShoes[1].listImage[0].color;
    } else if (_currentPage > 1.7 && _currentPage < 2.7) {
      color = listShoes[2].listImage[0].color;
    }
    return color;
  }

  @override
  void initState() {
    _pageController.addListener(_listener);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(),
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Row(
                children: List.generate(
                  listCategory.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Text(
                      listCategory[index],
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20.0,
                        color: index == 0 ? getColor() : Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
                controller: _pageController,
                itemCount: listShoes.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final shoes = listShoes[index];
                  final listTitle = shoes.category.split(' ');
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(PageRouteBuilder(
                          pageBuilder: (context, animation, _) {
                        return DetailsScreen(
                          shoes: shoes,
                        );
                      }));
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: index == indexPage ? 30 : 60),
                      child: Transform.translate(
                        offset: Offset(index == indexPage ? 0 : 20, 0),
                        child: LayoutBuilder(builder: (context, constraints) {
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            margin: EdgeInsets.only(
                                top: index == indexPage ? 30 : 80, bottom: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(36),
                              color: Colors.white,
                            ),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0,
                                    vertical: 40.0,
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        // the title above
                                        Text(
                                          shoes.category,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        // subtitle
                                        Text(
                                          shoes.name,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 28,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        // price
                                        Text(
                                          shoes.price,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        // big title
                                        FittedBox(
                                            child: Text(
                                          '${listTitle[0]} \n ${listTitle[1]}',
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold),
                                        ))
                                      ]),
                                ),
                                // image
                                Positioned(
                                  left: constraints.maxWidth * 0.05,
                                  right: -constraints.maxWidth * 0.16,
                                  top: constraints.maxHeight * 0.2,
                                  bottom: constraints.maxHeight * 0.2,
                                  child: Hero(
                                    tag: shoes.name,
                                    child: Image(
                                      image: AssetImage(
                                        shoes.listImage[0].image,
                                      ),
                                    ),
                                  ),
                                ),
                                // card in the bottom
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Material(
                                    color: shoes.listImage[0].color,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(36),
                                      bottomRight: Radius.circular(36),
                                    ),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: InkWell(
                                      onTap: () {},
                                      child: const SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Icon(
                                          Icons.add,
                                          size: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  );
                }),
          ),
          Container(
            height: 120,
            padding: const EdgeInsets.all(20.0),
            child: CustomBottomBar(color: getColor()),
          )
        ],
      ),
    );
  }
}
