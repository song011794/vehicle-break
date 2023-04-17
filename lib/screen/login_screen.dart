import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../util/string_extension.dart';

import '../controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  /// 텍스트 입력(ID, Password)받는 위젯 </br>
  /// Param </br>
  /// ValueNotifier<String> listenableValue : 데이터 저장 변수 </br>
  /// bool isPassword : 패스워드 여부 </br>
  Widget textInputFiled(ValueNotifier<String> listenableValue,
      {bool isPassword = false}) {
    return ValueListenableBuilder(
        valueListenable: listenableValue,
        builder: (context, value, child) {
          return Container(
            padding: EdgeInsets.only(left: 100.w, right: 100.w),
            child: TextFormField(
                autovalidateMode: AutovalidateMode.always,
                keyboardType: isPassword ? null : TextInputType.emailAddress,
                initialValue: value,
                onChanged: (value) => listenableValue.value = value,
                obscureText: isPassword,
                validator: (value) => isPassword
                    ? value.validatePassword()
                    : value.validateEmail(),
                decoration: InputDecoration(
                  prefixIcon: isPassword
                      ? const Icon(Icons.lock)
                      : const Icon(Icons.person),
                  hintText: isPassword ? 'password'.tr : 'id'.tr,
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.5),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      borderSide: BorderSide(color: Colors.blue)),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      borderSide: BorderSide(color: Colors.black)),
                  focusedErrorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      borderSide: BorderSide(color: Colors.blue)),
                  errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      borderSide: BorderSide(color: Colors.red)),
                )),
          );
        });
  }

  Widget socialLoginButton(VoidCallback onLogin) {
    return SizedBox(
      width: 550.w,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.85)),
          onPressed: onLogin,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/images/google_logo.png',
                width: 50.w,
                height: 50.h,
              ),
              SizedBox(
                width: 30.w,
              ),
              const Text('Sign in with Google',
                  style: TextStyle(color: Colors.black))
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'lib/images/login_bg.png',
                  ),
                  fit: BoxFit.cover)),
          child: Form(
            key: _formKey,
            child: Column(children: [
              SizedBox(
                height: 500.h,
              ),
              textInputFiled(controller.idValue),
              SizedBox(
                height: 50.h,
              ),
              textInputFiled(controller.passwordValue, isPassword: true),
              SizedBox(
                height: 50.h,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.onSignIn(_formKey);
                  },
                  child: Text('로그인')),
              SizedBox(
                height: 50.h,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.onSignUp();
                  },
                  child: Text('회원가입')),
              SizedBox(
                height: 50.h,
              ),
              socialLoginButton(controller.signInWithGoogle)
            ]),
          ),
        ));
  }
}