import 'package:flutter/material.dart';
import 'package:reproductor/Constants/contants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.022),
      child: SizedBox(
        height: size.height * 0.096,
        width: size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: size.height * 0.024),
              child: GestureDetector(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: Icon(
                  Icons.density_medium,
                  color: kiconocolor,
                  size: size.height * 0.050,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: size.height * 0.048),
              child: Stack(
                children: [
                  Container(
                    height: size.height * 0.048,
                    width: size.width * 0.65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(size.height * 0.096),
                    ),
                  ),
                  Positioned(
                      right: size.height * 0.012,
                      bottom: size.height * 0.006,
                      child: Icon(
                        Icons.search,
                        size: size.height * 0.04,
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
