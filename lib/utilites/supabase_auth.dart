import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  //supabase instance
  final supabase = Supabase.instance.client;

  //Sinup phone User
  Future createNewPhoneUser(String phone, String username) async {
    final res = await supabase.auth.signUpWithPhone(phone, username);
    return res;
  }

  Future sendVerifyOTP({required String phone}) async {
    try {
      final res = await supabase.auth.signIn(
        phone: phone,
        options: AuthOptions(
          redirectTo: 'https://whpjzctadbbslbgnkttx.supabase.co',
        ),
      );
      return res;
    } catch (e) {
      print(e);
    }
  }

  Future verifyPhoneNumber(
      {required String phone, required String token}) async {
    try {
      final res = await supabase.auth.verifyOTP(
        phone,
        token,
      );
      return res;
    } catch (e) {
      print(e);
    }
  }
}
