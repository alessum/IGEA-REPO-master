import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:igea_app/widgets/ui_components/close_line_top_modal.dart';

class ModalBottomRegistryCalcCfMissingValue extends StatelessWidget {
  const ModalBottomRegistryCalcCfMissingValue({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return Container(
      height: media.height * 0.27,
      padding: EdgeInsets.all(13),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CloseLineTopModal(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: media.width * 0.2,
                child: SvgPicture.asset('assets/avatars/arold_extended.svg',height: media.width * 0.3,),
              ),
              Container(
                width: media.width * 0.6,
                child: Text(
                  'Ops! Se non inserisci nome, cognome, data di nascita e sesso non posso aiutarti a calcolare il codice fiscale!',
                  style: TextStyle(
                      fontSize: media.width * 0.05, fontFamily: 'Book'),
                ),
              )
            ],
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
