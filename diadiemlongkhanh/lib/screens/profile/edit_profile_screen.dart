import 'dart:io';

import 'package:diadiemlongkhanh/models/remote/user/user_response.dart';
import 'package:diadiemlongkhanh/resources/app_constant.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/utils/global_value.dart';
import 'package:diadiemlongkhanh/widgets/cliprrect_image.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _fbCtler = TextEditingController();
  final _insCtler = TextEditingController();
  final _phoneCtler = TextEditingController();
  final _userNameCtler = TextEditingController();
  final _fullNameCtler = TextEditingController();
  final _emailCtler = TextEditingController();
  final _birthDayCtler = TextEditingController();
  final _genderCtler = TextEditingController();
  bool? _isMale;
  UserModel? _user;
  XFile? _imageFile;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _getInfoUser();
    });
  }

  _getInfoUser() async {
    AppUtils.showLoading();
    final res = await injector.get<ApiClient>().getProfile();
    AppUtils.hideLoading();
    if (res != null && res.info != null) {
      final user = res.info!;
      setState(() {
        _user = user;
        _isMale = user.gender;
        _phoneCtler.text = user.phone ?? '';
        _fullNameCtler.text = user.name ?? '';
        _userNameCtler.text = user.username ?? '';
        _birthDayCtler.text = user.birth ?? '';
        _genderCtler.text = user.gender == null
            ? ''
            : user.gender!
                ? 'Nam'
                : 'Nữ';
        _fbCtler.text = user.social?.facebook ?? '';
        _insCtler.text = user.social?.instagram ?? '';
      });
    }
  }

  _updateProfile() async {
    if (_phoneCtler.text == '') {
      AppUtils.showOkDialog(context, 'Vui lòng nhập số điện thoại của bạn');
      return;
    }
    if (_fullNameCtler.text == '') {
      AppUtils.showOkDialog(context, 'Vui lòng nhập họ tên của bạn');
      return;
    }
    if (_userNameCtler.text == '') {
      AppUtils.showOkDialog(context, 'Vui lòng nhập tên người dùng');
      return;
    }
    AppUtils.showLoading();
    final data = {
      "name": _fullNameCtler.text,
      "username": _userNameCtler.text,
      "phone": _phoneCtler.text,
      "email": _emailCtler.text,
      "gender": _isMale,
      "birth": _birthDayCtler.text,
      "facebook": _fbCtler.text,
      "instagram": _insCtler.text,
    };
    if (_imageFile != null) {
      await _uploadAvatar();
    }
    final res = await injector.get<ApiClient>().updateProfile(data);
    AppUtils.hideLoading();
    if (res != null) {
      if (res.error != null) {
        AppUtils.showOkDialog(context, res.error!);
        return;
      }
      GlobalValue.name = _fullNameCtler.text;
      AppUtils.showSuccessAlert(
        context,
        title: 'Cập nhật thông tin cá nhân thành công!',
        okTitle: 'Xác nhận',
        okAction: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      );
      return;
    }
    AppUtils.showOkDialog(
      context,
      ConstantTitle.please_try_again,
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      locale: Locale("vi", "VN"),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary:
                  Theme.of(context).primaryColor, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (selected != null) {
      _birthDayCtler.text = AppUtils.convertDateToString(selected);
    }
  }

  _pickImages() async {
    final ImagePicker _picker = ImagePicker();

    final image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = image;
      });
    }
  }

  _uploadAvatar() async {
    final data = FormData.fromMap({
      'files': MultipartFile.fromFileSync(
        _imageFile!.path,
        contentType: MediaType.parse(lookupMimeType(_imageFile!.path) ?? ''),
      )
    });
    final res = await injector.get<ApiClient>().updateAvatar(data);
    if (res != null && res.avatar != null) {
      GlobalValue.avatar = res.avatar;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.grey_F2F4F8,
      appBar: MyAppBar(
        title: 'Cập nhật thông tin',
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            bottom: 100,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildAvtView(),
                    _buildInfoView(context),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.white,
              child: SafeArea(
                child: Container(
                  height: 80,
                  color: Colors.white,
                  child: Center(
                    child: MainButton(
                      onPressed: _updateProfile,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      title: 'Cập nhật tài khoản',
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container _buildInfoView(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 15),
            blurRadius: 40,
            color: ColorConstant.grey_shadow.withOpacity(0.12),
          )
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Thông tin cá nhân',
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 40,
              child: MainTextFormField(
                hintText: 'Nhập số điện thoại',
                keyboardType: TextInputType.phone,
                readOnly: _user?.phone != '',
                controller: _phoneCtler,
                validator: (val) {
                  if (val == '') {
                    return 'Vui lòng nhập số điện thoại';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 40,
              child: MainTextFormField(
                hintText: 'Nhập họ và tên',
                controller: _fullNameCtler,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 40,
              child: MainTextFormField(
                hintText: 'Tên người dùng',
                controller: _userNameCtler,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 40,
              child: MainTextFormField(
                hintText: 'Nhập email',
                controller: _emailCtler,
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () => _selectDate(context),
              child: SizedBox(
                height: 40,
                child: IgnorePointer(
                  child: MainTextFormField(
                    hintText: 'Ngày sinh',
                    suffixIcon: SvgPicture.asset(
                      ConstantIcons.ic_calendar,
                    ),
                    controller: _birthDayCtler,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () => _showBottomSheetGender(),
              child: SizedBox(
                height: 40,
                child: IgnorePointer(
                  child: MainTextFormField(
                    hintText: 'Giới tính',
                    suffixIcon: SvgPicture.asset(
                      ConstantIcons.ic_expand_more,
                    ),
                    controller: _genderCtler,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            _buildListSocialLink(context)
          ],
        ),
      ),
    );
  }

  _showBottomSheetGender() async {
    final action = CupertinoActionSheet(
      message: Text(
        'Chọn giới tính của bạn',
        style: TextStyle(fontSize: 18),
      ),
      actions: [
        CupertinoActionSheetAction(
          child: Text('Nam'),
          onPressed: () {
            Navigator.pop(context);
            _isMale = true;
            _genderCtler.text = 'Nam';
          },
        ),
        CupertinoActionSheetAction(
          child: Text('Nữ'),
          onPressed: () {
            Navigator.pop(context);
            _isMale = false;
            _genderCtler.text = 'Nữ';
          },
        )
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

  Container _buildListSocialLink(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: ColorConstant.neutral_gray_lightest,
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            padding: const EdgeInsets.only(
              left: 16,
              right: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: ColorConstant.border_gray,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Thêm liên kết mạng xã hội',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                // SvgPicture.asset(
                //   ConstantIcons.ic_expand_more,
                // )
              ],
            ),
          ),
          _buildSocialItemView(
            icon: ConstantIcons.ic_fb,
            controller: _fbCtler,
            hintText: 'Nhập đường dẫn Facebook',
          ),
          _buildSocialItemView(
            icon: ConstantIcons.ic_instagram,
            controller: _insCtler,
            isLast: true,
            hintText: 'Nhập đường dẫn Instagram',
          ),
        ],
      ),
    );
  }

  Container _buildSocialItemView({
    bool isLast = false,
    required String icon,
    String? hintText,
    TextEditingController? controller,
  }) {
    return Container(
      height: 76,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: isLast ? 39 : 0,
            child: Container(
              width: 1,
              height: double.infinity,
              margin: const EdgeInsets.only(left: 16),
              color: ColorConstant.neutral_gray_lighter,
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 1,
                  color: ColorConstant.neutral_gray_lighter,
                ),
                Expanded(
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: ColorConstant.border_gray,
                      ),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          icon,
                        ),
                        Container(
                          width: 1,
                          color: ColorConstant.neutral_gray_lightest,
                          margin: const EdgeInsets.only(
                            left: 4,
                            top: 6,
                            bottom: 6,
                          ),
                        ),
                        Expanded(
                          child: MainTextFormField(
                            hintText: hintText,
                            controller: controller,
                            contentPadding: const EdgeInsets.only(
                              left: 12,
                              bottom: 10,
                            ),
                            hideBorder: true,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvtView() {
    return InkWell(
      onTap: _pickImages,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 15),
              blurRadius: 40,
              color: ColorConstant.grey_shadow.withOpacity(0.12),
            )
          ],
        ),
        child: Center(
          child: Container(
            child: Stack(
              children: [
                _imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(39),
                        child: Image.file(
                          File(_imageFile!.path),
                          width: 78,
                          height: 78,
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRectImage(
                        height: 78,
                        width: 78,
                        radius: 39,
                        url: AppUtils.getUrlImage(
                          _user?.avatar ?? '',
                          width: 78,
                          height: 78,
                        ),
                      ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white.withOpacity(
                        0.8,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        ConstantIcons.ic_camera,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
