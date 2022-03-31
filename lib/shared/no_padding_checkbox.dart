import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoPaddingCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool newValue) onChanged;
  final double size;

  NoPaddingCheckbox({
    @required this.value,
    @required this.onChanged,
    this.size = 23,
  });

  @override
  Widget build(BuildContext context) {
    Size media = MediaQuery.of(context).size;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: size, maxWidth: size),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: (value)
            ? SvgPicture.asset('assets/icons/CheckedBox.svg',
                width: media.width * size * 0.0018)
            : SvgPicture.asset('assets/icons/toCheckBox.svg',
                width: media.width * size * 0.0018),
        onPressed: () => onChanged(!value),
      ),
    );
  }
}
