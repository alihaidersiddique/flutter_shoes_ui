import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shoes_ui_practice/pages/shoes.dart';

class ShoesCard extends StatelessWidget {
  const ShoesCard({
    Key? key,
    required this.shoes,
  }) : super(key: key);

  final Shoes shoes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Color(0xffF6F6F6)),
            child: Column(
              children: [
                SizedBox(height: 60.0),
                Image.asset(
                  shoes.image,
                  width: MediaQuery.of(context).size.width,
                ),
                Align(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Image.asset(
                        shoes.logo,
                        height: 60,
                        width: 40,
                        color: Color(0xffCBCBCB),
                      ),
                    ),
                    alignment: Alignment.bottomRight),
              ],
            )),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$${shoes.price.toString()}',
                textScaleFactor: 1.5,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              FavoriteButton(valueChanged: () {})
            ],
          ),
        ),
        Flexible(
            child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              shoes.name,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ))
      ],
    );
  }
}
