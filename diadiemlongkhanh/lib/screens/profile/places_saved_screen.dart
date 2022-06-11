import 'package:diadiemlongkhanh/models/remote/place_response/place_response.dart';
import 'package:diadiemlongkhanh/resources/app_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/routes/router_manager.dart';
import 'package:diadiemlongkhanh/screens/profile/bloc/account_cubit.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/utils/global_value.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/empty_data_view.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:diadiemlongkhanh/widgets/my_rating_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacesSavedScreen extends StatefulWidget {
  const PlacesSavedScreen({Key? key}) : super(key: key);

  @override
  State<PlacesSavedScreen> createState() => _PlacesSavedScreenState();
}

class _PlacesSavedScreenState extends State<PlacesSavedScreen> {
  AccountCubit get _cubit => BlocProvider.of(context);
  List<PlaceModel> places = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getPlacesSaved();
    });
  }

  _getPlacesSaved() async {
    AppUtils.showLoading();
    final res =
        await injector.get<ApiClient>().getPlacesSaved(GlobalValue.id ?? '');
    AppUtils.hideLoading();
    if (res != null) {
      setState(() {
        places = res;
      });
    }
  }

  _unsavePlace(int index) async {
    AppUtils.showLoading();
    final res =
        await injector.get<ApiClient>().unsavePlace(places[index].id ?? '');
    AppUtils.hideLoading();
    if (res != null) {
      if (res.error != null) {
        AppUtils.showOkDialog(context, res.error!);
        return;
      }
      setState(() {
        places.removeAt(index);
      });
      return;
    }
    AppUtils.showOkDialog(context, ConstantTitle.please_try_again);
  }

  _showBottomSheet(int index) async {
    final action = CupertinoActionSheet(
      message: Text(
        'Tùy chọn',
        style: TextStyle(fontSize: 18),
      ),
      actions: [
        CupertinoActionSheetAction(
          child: Text('Bỏ lưu'),
          onPressed: () {
            _unsavePlace(index);
            Navigator.pop(context);
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text('Hủy bỏ'),
        isDestructiveAction: true,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );

    showCupertinoModalPopup(
      context: context,
      builder: (context) => action,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(title: 'Địa điểm đã lưu'),
      body: places.isEmpty
          ? EmptyDataView(
              title: 'Bạn chưa lưu địa điểm nào!',
            )
          : ListView.builder(
              itemCount: places.length,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, index) {
                final item = places[index];
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      RouterName.detail_place,
                      arguments: item.id,
                    );
                  },
                  child: Container(
                    height: 112,
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstant.green_shadow.withOpacity(0.12),
                          offset: Offset(0, 15),
                          blurRadius: 40,
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        ClipRRectImage(
                          width: 96,
                          height: double.infinity,
                          radius: 8,
                          url: AppUtils.getUrlImage(
                            item.avatar?.path ?? '',
                            width: 96,
                            height: 96,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                item.address?.specific ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorConstant.neutral_gray,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppUtils.roundedRating(item.avgRate ?? 0)
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.neutral_gray_lighter,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  MyRatingBar(
                                    rating: item.avgRate ?? 0,
                                    onRatingUpdate: (rate, isEmpty) {},
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  Text(
                                    AppUtils.getOpeningTitle(
                                        item.openingStatus ?? ''),
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () => _showBottomSheet(index),
                          child: Icon(
                            Icons.more_horiz,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
