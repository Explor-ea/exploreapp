import 'package:flutter/material.dart';

pushReplaceToNextPage(BuildContext context, Widget nextPage) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => nextPage));
}

goToNextPage(BuildContext context, Widget nextPage) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => nextPage));
}

goBack(BuildContext context) {
  Navigator.pop(context);
}
