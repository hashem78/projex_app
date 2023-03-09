import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:projex_app/models/profile_picture_model/profile_picture_model.dart';
import 'package:projex_app/models/user_model/user_model.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 0.5.sw,
                height: 0.15.sh,
                alignment: Alignment.center,
                child: Text(
                  'Welcome to Projex!',
                  style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              32.verticalSpace,
              ElevatedButton.icon(
                icon: Icon(
                  Icons.admin_panel_settings,
                  size: 30.sp,
                ),
                label: Text(
                  'Sign in as a Recruiter/HR/Intrested Party',
                  style: TextStyle(fontSize: 30.sp),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
                onPressed: () async {
                  const adminUser = PUser(
                    id: 'admin',
                    email: 'admin@admin.com',
                    name: 'Admin Admin',
                    profilePicture: PProfilePicture(link: 'https://picsum.photos/200/200'),
                    phoneNumber: '0798609212',
                  );
                  try {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: adminUser.email!,
                      password: '123456',
                    );
                  } on FirebaseException catch (e) {
                    if (e.code == 'user-not-found') {
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: adminUser.email!,
                        password: '123456',
                      );
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: adminUser.email!,
                        password: '123456',
                      );
                    }
                  }
                },
              ),
              32.verticalSpace,
              ElevatedButton.icon(
                icon: Icon(
                  Icons.person,
                  size: 30.sp,
                ),
                label: Text(
                  'Sign in Anonymously',
                  style: TextStyle(fontSize: 30.sp),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signInAnonymously();
                },
              ),
              32.verticalSpace,
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SignInScreen()),
                  );
                },
                icon: Icon(
                  Icons.email,
                  size: 30.sp,
                ),
                label: Text(
                  'Sign in With Email and Password',
                  style: TextStyle(fontSize: 30.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
