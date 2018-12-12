import 'dart:io';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multiple_image_picker/flutter_multiple_image_picker.dart';


class GalleryPage extends StatefulWidget {
  @override
  _GalleryPageState createState() => _GalleryPageState();
}




class _GalleryPageState extends State<GalleryPage> {

  BuildContext context;
  String _platformMessage = 'No Error';
  List images;
  int maxImageNo = 10;
  bool selectSingleImage = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }


  initMultiPickUp() async {
    setState(() {
      images = null;
      _platformMessage = 'No Error';
    });
    List resultList;
    String error;
    try {
      resultList = await FlutterMultipleImagePicker.pickMultiImages(
          maxImageNo, selectSingleImage);
    } on PlatformException catch (e) {
      error = e.message;
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _platformMessage = 'No Error Dectected';
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 400.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    title: Text("Gallery",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    background: Image.network(
                      "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                      fit: BoxFit.cover,
                    )),
              ),

            ];
          },
          body: staggeredBody()
        ),
      ),
    );
  }

  Padding staggeredBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder(

        future: getAllImages(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return new Text('loading...');
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              else
                return internalImages(context, snapshot.data);
          }
        },

      ),
    );
  }

   internalImages(BuildContext context, List<String> data){

    SliverGrid(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        childAspectRatio: 4.0,
        maxCrossAxisExtent: 200.0,
      ),
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return Image.file(File(data[index]));
        },
        childCount: data.length,
      ),
    );
  }



  Future<List<String>> getAllImages() async {
    // Also when user close the app it will destroys the images
    List<String> fileImages = new List();
    final Directory extDir = await getExternalStorageDirectory();

    extDir.list(recursive: true, followLinks: false)
        .listen((FileSystemEntity entity) {
      print(entity.path);

      /* check for image types */
      if(entity.path.endsWith("jpg") || entity.path.endsWith("png")) {
        fileImages.add(entity.path);
      }
  });
        return fileImages;
  }

}