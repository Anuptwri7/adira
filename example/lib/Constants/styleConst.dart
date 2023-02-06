import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:readmore/readmore.dart';

var dropDownDecoration = BoxDecoration(
    color: Colors.indigo.shade50,
    // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
        spreadRadius: 1,
        blurRadius: 2,
        offset: Offset(4, 4),
      )
    ]);
var dropDownsDecoration = BoxDecoration(
    color: Colors.white,
    // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
        spreadRadius: 1,
        blurRadius: 2,
        offset: Offset(4, 4),
      )
    ]);

var appBarColor = Colors.indigo.shade300;
var buttonColor = Colors.indigo.shade300;
double containerHeight= 110;
double dialogcontainerHeight= 50;

var homePageContainerDecoration = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Color(0x155665df),
      spreadRadius: 5,
      blurRadius: 17,
      offset: Offset(0, 3),
    )
  ],
  borderRadius: BorderRadius.all(
    Radius.circular(18.0),
  ),
  color: Colors.white,
);

var assetContainerDecoration = BoxDecoration(
    color: Colors.white,
    // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.grey,
        spreadRadius: 1,
        blurRadius: 2,
        offset: Offset(4, 4),
      )
    ]);
const kHeightVeryBig = SizedBox(
  height: 15,
);
const kTextStyleWhite = TextStyle(fontSize: 19.0, color: Colors.white);
const kTextStyleBlack = TextStyle(fontSize: 16.0, color: Colors.black);
const kTextStyleSmall = TextStyle(fontSize: 16.0, color: Colors.white);
const kTextBlackSmall = TextStyle(fontSize: 16.0, color: Colors.black);
const kHintTextStyle = TextStyle(color: Colors.black54, fontSize: 19.0);
const kMarginPaddMedium = EdgeInsets.all(16.0);
const kMarginPaddSmall = EdgeInsets.all(8.0);
const kCardElevation = 8.0;
const kHeightSmall = SizedBox(
  height: 8,
);

const kHeightBig = SizedBox(
  height: 24,
);
const kHeightMedium = SizedBox(
  height: 16,
);
var kCardRoundedShape =
RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0));

const kHeightVerySmall = SizedBox(
  height: 4,
);

goToPage(BuildContext context, dynamic myPage) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => myPage));
}
void displayToast({String msg}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xff2c51a4),
      fontSize: 16.0);
}
smallShowMorePickUpLocations(String textToDisplay) {
  return ReadMoreText(
    textToDisplay,
    trimLines: 3,
    colorClickableText: Colors.pink,
    trimMode: TrimMode.Line,
    trimCollapsedText: 'Show more',
    delimiterStyle: kTextBlackSmall.copyWith(
      fontWeight: FontWeight.bold,
    ),
    trimExpandedText: 'Show less',
    style: kTextBlackSmall,
    moreStyle:
    kTextBlackSmall.copyWith(fontWeight: FontWeight.bold, fontSize: 10.0),
    lessStyle:
    kTextBlackSmall.copyWith(fontWeight: FontWeight.bold, fontSize: 10.0),
  );
}
showMorePickUpLocations(String textToDisplay) {
  return ReadMoreText(
    textToDisplay,
    trimLines: 2,
    colorClickableText: Colors.pink,
    trimMode: TrimMode.Line,
    trimCollapsedText: 'Show more',
    textDirection: TextDirection.ltr,
    trimExpandedText: 'Show less',
    style: kTextBlackSmall,
    moreStyle: kTextBlackSmall.copyWith(fontWeight: FontWeight.bold),
    lessStyle: kTextBlackSmall.copyWith(fontWeight: FontWeight.bold),
  );
}
void displayToastSuccess({String msg}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(0xff2c51a4),
      fontSize: 16.0);
}

var kSerialFormDecoration = BoxDecoration(
  border: Border.all(
    color: Colors.black,
  ),
  shape: BoxShape.rectangle,
  borderRadius: BorderRadius.all(Radius.circular(8.0)),
);
const kLabelStyle = TextStyle(color: Colors.white, fontSize: 16.0);
const kopenScannerDecoration = InputDecoration(
  // labelStyle: kHintTextStyle,
  hintStyle: kHintTextStyle,
  contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
  border: const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(8.0)),
  ),
);
