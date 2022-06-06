import 'package:diadiemlongkhanh/resources/app_constant.dart';
import 'package:diadiemlongkhanh/resources/asset_constant.dart';
import 'package:diadiemlongkhanh/resources/color_constant.dart';
import 'package:diadiemlongkhanh/services/api_service/api_client.dart';
import 'package:diadiemlongkhanh/services/di/di.dart';
import 'package:diadiemlongkhanh/utils/app_utils.dart';
import 'package:diadiemlongkhanh/widgets/main_button.dart';
import 'package:diadiemlongkhanh/widgets/main_text_form_field.dart';
import 'package:diadiemlongkhanh/widgets/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _nameCtler = TextEditingController();
  final _emailCtler = TextEditingController();
  final _contentCtler = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _confirm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    AppUtils.showLoading();
    final data = {
      "name": _nameCtler.text,
      "email": _emailCtler.text,
      "content": _contentCtler.text,
    };
    final res = await injector.get<ApiClient>().sendContact(data);
    AppUtils.hideLoading();
    if (res != null) {
      if (res.error != null) {
        AppUtils.showOkDialog(context, res.error!);
        return;
      }
      AppUtils.showSuccessAlert(
        context,
        title: 'Gửi góp ý thành công!',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(title: 'Liên hệ'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                MainTextFormField(
                  hintText: 'Tên của bạn',
                  maxLines: 1,
                  controller: _nameCtler,
                  validator: (val) {
                    if (val == null || val == '') {
                      return 'Vui lòng nhập tên của bạn';
                    }
                    if (val.length < 3) {
                      return 'Tên của bạn phải tối thiểu 3 ký tự';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                MainTextFormField(
                  hintText: 'Email',
                  maxLines: 1,
                  controller: _emailCtler,
                  validator: (val) {
                    if (val == '') {
                      return 'Vui lòng nhập email của bạn';
                    }
                    if (val != '' && !AppUtils.isValidEmail(val ?? '')) {
                      return 'Email của bạn không hợp lệ';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  height: 94,
                  margin: const EdgeInsets.only(top: 8),
                  child: MainTextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 5,
                    controller: _contentCtler,
                    hintText: 'Nội dung (tối thiểu 10 ký tự)',
                    contentPadding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 16,
                    ),
                    validator: (val) {
                      if (val == '') {
                        return 'Vui lòng nhập nội dung';
                      }
                      if (val!.length < 10) {
                        return 'Vui lòng nhập nội dung tối thiệu 10 ký tự';
                      }
                      return null;
                    },
                  ),
                ),
                MainButton(
                  onPressed: _confirm,
                  title: 'Gửi',
                  margin: const EdgeInsets.only(top: 30),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
