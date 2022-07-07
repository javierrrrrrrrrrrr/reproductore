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
    return Padding(
      padding: const EdgeInsets.only(left: 37, right: 37),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon1,
            size: 35,
            color: Colors.white,
          ),
          Icon(
            icon2,
            size: 35,
            color: Colors.white,
          ),
          Icon(
            icon3,
            size: 35,
            color: Colors.white,
          ),
          Icon(
            icon4,
            size: 35,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
