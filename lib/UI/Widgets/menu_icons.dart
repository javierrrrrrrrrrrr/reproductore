import 'package:flutter/material.dart';

class MenuNavegacionIconos extends StatelessWidget {
  final double height;
  const MenuNavegacionIconos({
    Key? key,
    required this.icon1,
    required this.icon2,
    required this.icon3,
    required this.icon4,
    required this.height,
  }) : super(key: key);

  final IconData icon1;
  final IconData icon2;
  final IconData icon3;
  final IconData icon4;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: height * 0.045, right: height * 0.045),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon1,
            size: height * 0.045,
            color: Colors.white,
          ),
          Icon(
            icon2,
            size: height * 0.045,
            color: Colors.white,
          ),
          Icon(
            icon3,
            size: height * 0.045,
            color: Colors.white,
          ),
          Icon(
            icon4,
            size: height * 0.045,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
