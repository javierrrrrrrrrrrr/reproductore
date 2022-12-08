import 'package:flutter/material.dart';

class MenuNavegacionIconos extends StatelessWidget {
  const MenuNavegacionIconos({
    Key? key,
    required this.icon1,
    required this.icon2,
    required this.icon3,
    required this.icon4,
  }) : super(key: key);

  final IconData icon1;
  final IconData icon2;
  final IconData icon3;
  final IconData icon4;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
          left: size.height * 0.049, right: size.height * 0.049),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon1,
            size: size.height * 0.038,
            color: Colors.white,
          ),
          Icon(
            icon2,
            size: size.height * 0.038,
            color: Colors.white,
          ),
          Icon(
            icon3,
            size: size.height * 0.038,
            color: Colors.white,
          ),
          Icon(
            icon4,
            size: size.height * 0.038,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
