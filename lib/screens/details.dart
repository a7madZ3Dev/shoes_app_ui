import 'package:flutter/material.dart';

import '../models/data.dart';
import '../models/shoes.dart';
import '../widgets/transition.dart';
import '../widgets/custom_button.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({required this.shoes, Key? key}) : super(key: key);
  final Shoes shoes;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int valueIndexColor = 0;
  int valueIndexSize = 0;
  double sizeShoes(int index, Size size) {
    switch (index) {
      case 0:
        return (size.height * 0.09);
      case 1:
        return (size.height * 0.07);
      case 2:
        return (size.height * 0.05);
      case 3:
        return (size.height * 0.04);

      default:
        return (size.height * 0.05);
    }
  }

  bool favColor = false;
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -_size.height * 0.15,
            right: -_size.height * 0.20,
            child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 400),
                tween: Tween(begin: 0, end: 1),
                builder: (context, value, _) {
                  return AnimatedContainer(
                    duration: const Duration(
                      microseconds: 400,
                    ),
                    height: value * (_size.height * 0.5),
                    width: value * (_size.height * 0.5),
                    decoration: BoxDecoration(
                        color: widget.shoes.listImage[valueIndexColor].color,
                        shape: BoxShape.circle),
                  );
                }),
          ),
          Positioned(
            top: kToolbarHeight,
            left: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    favColor != favColor;
                    setState(() {
                      favColor ? color = Colors.red : color = Colors.white;
                    });
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: _size.height * 0.20,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: FittedBox(
                child: Text(
                  widget.shoes.category,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[100],
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            top: _size.height * 0.22,
            left: sizeShoes(valueIndexSize, _size),
            right: sizeShoes(valueIndexSize, _size),
            child: Hero(
              tag: widget.shoes.name,
              child: Image(
                image: AssetImage(
                  widget.shoes.listImage[valueIndexColor].image,
                ),
              ),
            ),
          ),
          Positioned(
            top: _size.height * 0.6,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ShakeTransition(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.shoes.category,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            widget.shoes.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ShakeTransition(
                      left: false,
                      child: Text(
                        widget.shoes.price,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                ShakeTransition(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            color: widget.shoes.punctuation > index
                                ? widget.shoes.listImage[valueIndexColor].color
                                : Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'SIZE',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: List.generate(
                          4,
                          (index) => Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: CustomButton(
                              color: index == valueIndexSize
                                  ? widget
                                      .shoes.listImage[valueIndexColor].color
                                  : Colors.white,
                              onTap: () {
                                setState(() {
                                  valueIndexSize = index;
                                });
                              },
                              child: Text(
                                '${index + 7}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                    color: index == valueIndexSize
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: _size.height * 0.84,
            left: 16,
            right: 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShakeTransition(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'COLOR',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: List.generate(
                            widget.shoes.listImage.length,
                            (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      valueIndexColor = index;
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color:
                                          widget.shoes.listImage[index].color,
                                      shape: BoxShape.circle,
                                      border: index == valueIndexColor
                                          ? Border.all(
                                              color: Colors.white, width: 2)
                                          : null,
                                    ),
                                  ),
                                )),
                      )
                    ],
                  ),
                ),
                ShakeTransition(
                  left: false,
                  child: CustomButton(
                      width: 100,
                      color: widget.shoes.listImage[valueIndexColor].color,
                      onTap: () {},
                      child: const Text(
                        'BUY',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
