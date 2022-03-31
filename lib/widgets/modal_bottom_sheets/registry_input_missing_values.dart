import 'package:flutter/material.dart';

class ModalBottomRegistryInputMissingValues extends StatelessWidget {
  const ModalBottomRegistryInputMissingValues({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
        height: media.height * 0.2,
        padding: EdgeInsets.all(13),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Ops! Se non inserisci i tuoi dati non posso aiutarti!',
              style:
                  TextStyle(fontSize: media.width * 0.06, fontFamily: 'Bold'),
              textAlign: TextAlign.center,
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: media.width * 0.4,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Color(0xFF5C88C1),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: Center(
                  child: Text(
                    'Ho capito!',
                    style: TextStyle(
                        fontFamily: 'Gotham',
                        fontSize: media.width * 0.06,
                        color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      );
  }
}