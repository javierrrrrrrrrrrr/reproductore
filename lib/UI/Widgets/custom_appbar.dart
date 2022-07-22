import 'package:flutter/material.dart';
import 'package:reproductor/Constants/contants.dart';

class CustomAppBar extends StatelessWidget {
  final double height;

  const CustomAppBar({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.022),
      child: SizedBox(
        height: height * 0.096,
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: height * 0.024),
              child: GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Icon(
                  Icons.density_medium,
                  color: kiconocolor,
                  size: height * 0.050,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: height * 0.048),
              child: Stack(
                children: [
                  Container(
                    height: height * 0.048,
                    width: height * 0.312,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(height * 0.096),
                    ),
                  ),
                  Positioned(
                      right: height * 0.012,
                      bottom: height * 0.006,
                      child: Icon(
                        Icons.search,
                        size: height * 0.04,
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
