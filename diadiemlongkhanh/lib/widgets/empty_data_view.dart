import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:flutter/material.dart';

class EmptyDataView extends StatelessWidget {
  const EmptyDataView({
    Key? key,
    this.title,
  }) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 30),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Image.asset(
            ConstantImages.no_data,
            height: 188,
            width: 287,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            title ?? '',
            style: Theme.of(context).textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
