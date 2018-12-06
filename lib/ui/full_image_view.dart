import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:standardappstructure/utils/utils.dart';

class FullImageView extends StatefulWidget {
  String imageURL;
  String name;


  FullImageView(this.name,this.imageURL);

  @override
  FullImageViewState createState() {
    return new FullImageViewState();
  }
}

class FullImageViewState extends State<FullImageView> {
  static const platform = const MethodChannel('com.example.standardappstructure/wallpaper');
  bool downloading = false;
  var progressString = "";
  String _setWallpaper = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: (){
                Utils.showAlert(context, "Set Wallpaper", "Do you want to set this Image as Wallpaper ?", () {
                  Navigator.pop(context);
                  setWallpaper();
                }, true);
              },
              child: Icon(
                Icons.save_alt,
                color: Colors.black87,
              ),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.black38,
        child: Image.network(widget.imageURL,
          fit: BoxFit.contain,
          height:
          double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),

    );
  }

  Future<Null> setWallpaper() async {
    Dio dio = Dio();
    try {
      var dir = await getTemporaryDirectory();

      await dio.download(widget.imageURL, "${dir.path}/myimage.jpeg",
          onProgress: (rec, total) {
            setState(() {
              downloading = true;
              progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
              print(progressString);
              if (progressString == "100%") {
                _setWallpaer();
              }
            });
          });
    } catch (e) {}

    setState(() {
      downloading = false;
      progressString = "Completed";
    });}

  Future<Null> _setWallpaer() async {
    String setWallpaper;
    try {
      final int result =
      await platform.invokeMethod('setWallpaper', 'myimage.jpeg');
      setWallpaper = 'Wallpaer Updated....';
    } on PlatformException catch (e) {
      setWallpaper = "Failed to Set Wallpaer: '${e.message}'.";
    }
    setState(() {
      _setWallpaper = setWallpaper;
    });}
}
