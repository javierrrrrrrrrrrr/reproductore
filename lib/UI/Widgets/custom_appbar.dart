import 'package:flutter/material.dart';
import 'package:reproductor/Constants/contants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: SizedBox(
        height: 80,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Icon(
                  Icons.density_medium,
                  color: kiconocolor,
                  size: 40,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40),
              child: Stack(
                children: [
                  Container(
                    height: 40,
                    width: 270,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  const Positioned(
                      right: 10,
                      bottom: 5,
                      child: Icon(
                        Icons.search,
                        size: 30,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
