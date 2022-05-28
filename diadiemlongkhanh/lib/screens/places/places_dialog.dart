import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/screens/places/widgets/places_grid_view.dart';
import 'package:diadiemlongkhanh/screens/search/search_screen.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/services/storage/storage_service.dart';
import 'package:diadiemlongkhanh/widgets/search_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PlacesDialog extends StatefulWidget {
  final Function(PlaceModel)? onSelect;
  PlacesDialog({this.onSelect});

  @override
  _PlacesDialogState createState() => _PlacesDialogState();
}

class _PlacesDialogState extends State<PlacesDialog> {
  List<PlaceModel> _places = [];
  final _debouncer = Debouncer(milliseconds: 500);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getPlacesSeen();
    });
  }

  _getPlacesSeen() async {
    final ids = await injector.get<StorageService>().getPlaceIds() ?? [];
    if (ids.isEmpty) {
      _getPlaceHot();
      return;
    }
    final res = await injector.get<ApiClient>().getPlacesSeen(
          ids
              .toString()
              .replaceAll('[', '')
              .replaceAll(']', '')
              .replaceAll(' ', ''),
        );
    if (res != null) {
      setState(() {
        _places = res;
      });
    }
  }

  _getPlaceHot() async {
    final res = await injector.get<ApiClient>().getPlacesHot(limit: 10);
    if (res != null) {
      setState(() {
        _places = res;
      });
    }
  }

  _searchKeyWord(String val) async {
    final res = await injector.get<ApiClient>().getPlacesSuggest(val);
    if (res != null) {
      setState(() {
        _places = res;
      });
    }
  }

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
            SearchFormField(
              onChanged: (val) {
                _debouncer.run(() {
                  print(val);
                  _searchKeyWord(val);
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Đã xem gần đây',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Expanded(
              child: PlacesGridView(
                places: _places,
                topPadding: 10,
                onSelect: (item) {
                  if (widget.onSelect != null) {
                    widget.onSelect!(item);
                  }
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
