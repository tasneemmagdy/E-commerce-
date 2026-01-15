
import 'package:shop_app/component/components.dart';
import 'package:shop_app/modules/shop_app/login/login_screen.dart';
import 'package:shop_app/shared/network/local/cahse_helper.dart';

void SignOut(context){
  CasheHelper.removeData(key: 'accessToken')
      .then((value){
    token = '';
    navigateAndFinish(
        context,
        LoginScreen()
    );
  });
}

void printFullText(String text)
{
final pattern = RegExp('.{1,800}');
pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
