
import 'package:url_launcher/url_launcher.dart';
class GoogleView{
Future<void> openMap (
double longitude,
double latitude,

  )async{
    String googlerMapurl = "https://www.google.com/maps/search/?api=1&query=$longitude,$latitude";
    if(await canLaunch(googlerMapurl)){
     await launch(googlerMapurl);
    }
    else{
      throw 'could not found the map';
    }
  }
}