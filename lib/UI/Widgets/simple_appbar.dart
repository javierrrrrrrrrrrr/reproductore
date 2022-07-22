import 'package:flutter/material.dart';
import 'package:reproductor/Constants/contants.dart';

class SimpleAppbar extends StatelessWidget {
  final double height;
  const SimpleAppbar({
    Key? key,
    required this.height,
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
            size: height * 0.05,
          ),
        ),
        GestureDetector(
          onTap: () {
            dialog(context);
          },
          child: Icon(
            Icons.settings,
            color: kiconocolor,
            size: height * 0.05,
          ),
        ),
      ],
    );
  }

  Future<dynamic> dialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        insetPadding: EdgeInsets.only(
            left: height * 0.18, right: height * 0.036, bottom: height * 0.12),
        contentPadding: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        content: Builder(builder: (context) {
          return SizedBox(
            height: height * 0.199,
            child: Padding(
              padding: EdgeInsets.only(left: height * 0.016),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.016,
                  ),
                  GestureDetector(
                    onTap: () {
                      //      final playerProvider = context.read<MediaProvider>();
                      //     final File ringtoneFile =
                      //           File('content://media/external/audio/media/83315');

                      //     RingtoneSet.setRingtoneFromFile(ringtoneFile);

                      //       print(
                      //           "Esssssssssss ${playerProvider.}");

                      // RingtoneSet.setRingtone();
                    },
                    child: Text(
                      'Establecer como tono de llamada',
                      style: TextStyle(
                          fontSize: height * 0.016, color: kprimarycolor),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.016,
                  ),
                  Text(
                    'Agregar a la lista de reproduccion',
                    style: TextStyle(
                        fontSize: height * 0.016, color: kprimarycolor),
                  ),
                  SizedBox(
                    height: height * 0.016,
                  ),
                  Text(
                    'Recortar Cancion',
                    style: TextStyle(
                        fontSize: height * 0.016, color: kprimarycolor),
                  ),
                  SizedBox(
                    height: height * 0.016,
                  ),
                  Text(
                    'Eliminar',
                    style: TextStyle(
                        fontSize: height * 0.016, color: kprimarycolor),
                  ),
                  SizedBox(
                    height: height * 0.016,
                  ),
                  Text(
                    'Archivar',
                    style: TextStyle(
                        fontSize: height * 0.016, color: kprimarycolor),
                  ),
                  SizedBox(
                    height: height * 0.016,
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
