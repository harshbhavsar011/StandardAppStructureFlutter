import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:standardappstructure/model/photos.dart';
import 'package:standardappstructure/service/apilistener.dart';
import 'package:standardappstructure/service/webservices.dart';
import 'package:standardappstructure/ui/full_image_view.dart';
import 'package:standardappstructure/utils/utils.dart';
import 'package:standardappstructure/widgets/progressview.dart';

class PhotosList extends StatefulWidget {
  @override
  _PhotosListState createState() => _PhotosListState();
}

class _PhotosListState extends State<PhotosList> implements ApiListener {
  bool isLoading = true;
  bool internetCheck = true;
  List<PhotoResponse> photoList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    photoList = new List();

    Utils.checkConnection().then((connectionResult) {
      if (connectionResult) {
        //Call Rest API for getting User list from server.
        WebServices(this).getListOfPhotos(context) as List<PhotoResponse>;
      } else {
        internetCheck = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Photos"),
        backgroundColor: Color.fromRGBO(78, 152, 254, 1.0),
      ),
      body: internetCheck
          ? ProgressWidget(
              isShow: isLoading,
              opacity: 0.5,
              child: staggeredBody(),
            )
          : Container(
              child: Center(
              child: Text("Internet is not connected please Try again.!"),
            )),
    );
  }

  Padding staggeredBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: photoList.length,
        itemBuilder: (BuildContext context, int index) => Container(
          child: GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FullImageView(photoList[index].user.name,photoList[index].urls.small)),
              );
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                        image: NetworkImage(photoList[index].urls.small),
                        fit: BoxFit.cover))),
            ),
          ),

        staggeredTileBuilder: (int index) =>
            StaggeredTile.count(2, index.isEven ? 2 : 3),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }

  @override
  void onApiFailure(Exception exception) {
    // TODO: implement onApiFailure
    setLoading(false);
    Utils.showAlert(context, "Photos", "Something went wrong.", () {
      Navigator.pop(context);
    }, true);
  }

  @override
  void onApiSuccess(Object mObject) {
    // TODO: implement onApiSuccess
    setLoading(false);
    //Get All Users
    if (mObject is List<PhotoResponse>) {
      photoList.addAll(mObject);
    }
  }

  @override
  void onNoInternetConnection() {
    // TODO: implement onNoInternetConnection
    setLoading(false);
  }

  //Progress Indicator On/Off
  void setLoading(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }
}
