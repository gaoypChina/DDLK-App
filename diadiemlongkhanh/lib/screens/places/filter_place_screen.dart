import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FilterPlaceScreen extends StatefulWidget {
  const FilterPlaceScreen({Key? key}) : super(key: key);

  @override
  _FilterPlaceScreenState createState() => _FilterPlaceScreenState();
}

class _FilterPlaceScreenState extends State<FilterPlaceScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.5),
      body: Container(
        margin: EdgeInsets.only(top: width / 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(ConstantIcons.ic_close),
                Text(
                  'Bộ lọc',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  'Đặt lại',
                  style: Theme.of(context).textTheme.headline4?.apply(
                        color: Theme.of(context).primaryColor,
                      ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
