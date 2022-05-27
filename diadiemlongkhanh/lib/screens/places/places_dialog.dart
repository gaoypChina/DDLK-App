import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/screens/places/widgets/places_grid_view.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/search_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlacesDialog extends StatefulWidget {
  const PlacesDialog({Key? key}) : super(key: key);

  @override
  _PlacesDialogState createState() => _PlacesDialogState();
}

class _PlacesDialogState extends State<PlacesDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.6),
      body: Container(
        margin: const EdgeInsets.only(top: 50),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 14,
                left: 16,
                right: 11,
                bottom: 14,
              ),
              child: Container(
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        'Chọn địa điểm',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: SvgPicture.asset(
                            ConstantIcons.ic_close,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        // Text(
                        //   'Thêm mới',
                        //   style: Theme.of(context).textTheme.headline4?.apply(
                        //         color: Theme.of(context).primaryColor,
                        //       ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 1,
              color: ColorConstant.neutral_gray_lightest,
            ),
            SearchFormField(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Đã xem gần đây',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Expanded(
              child: PlacesGridView(),
            )
          ],
        ),
      ),
    );
  }
}
