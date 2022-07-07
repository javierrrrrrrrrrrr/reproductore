import 'package:flutter/material.dart';
import 'package:reproductor/Constants/contants.dart';

class SimpleAppbar extends StatelessWidget {
  const SimpleAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: Icon(
            Icons.density_medium,
            color: kiconocolor,
            size: 40,
          ),
        ),
        GestureDetector(
          onTap: () {
            dialog(context);
          },
          child: Icon(
            Icons.settings,
            color: kiconocolor,
            size: 40,
          ),
        ),
      ],
    );
  }

  Future<dynamic> dialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        insetPadding: const EdgeInsets.only(left: 140, right: 30, bottom: 100),
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        content: Builder(builder: (context) {
          return SizedBox(
            height: 160,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    'Establecer como tono de llamada',
                    style: TextStyle(fontSize: 13, color: kprimarycolor),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    'Agregar a la lista de reproduccion',
                    style: TextStyle(fontSize: 13, color: kprimarycolor),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    'Recortar Cancion',
                    style: TextStyle(fontSize: 13, color: kprimarycolor),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    'Eliminar',
                    style: TextStyle(fontSize: 13, color: kprimarycolor),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  Text(
                    'Archivar',
                    style: TextStyle(fontSize: 13, color: kprimarycolor),
                  ),
                  const SizedBox(
                    height: 14,
                  )
                ],
              ),
            ),
          );
        }),
        alignment: const Alignment(1, -0.8),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
      ),
    );
  }
}
