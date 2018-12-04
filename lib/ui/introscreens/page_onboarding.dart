import 'package:standardappstructure/ui/introscreens/page_intro1.dart';
import 'package:standardappstructure/ui/page_login.dart';
import 'package:standardappstructure/utils/sharedprefutils.dart';
import 'package:standardappstructure/utils/utils.dart';
import 'package:standardappstructure/widgets/dots_indicator.dart';
import 'package:flutter/material.dart';

class OnboardingMainPage extends StatefulWidget {
  OnboardingMainPage({Key key}) : super(key: key);

  @override
  _OnboardingMainPageState createState() => _OnboardingMainPageState();
}

class _OnboardingMainPageState extends State<OnboardingMainPage> {
  final _controller = PageController();
  bool leadingVisibility = false;
  final List<Widget> _pages = [
    Page1(Color.fromRGBO(115, 84, 57, 1.0), "Page 1"),
    Page1(Color.fromRGBO(102, 102, 153, 1.0), "Page 2"),
    Page1(Color.fromRGBO(0, 121, 107, 1.0), "Page 3"),
  ];
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isLastPage = currentPageIndex == _pages.length - 1;
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          top: true,
          bottom: true,
          child: Stack(
            children: <Widget>[
              pageViewFillWidget(),
              appBarWithButton(isLastPage, context),
              bottonDotsWidget()
            ],
          ),
        ));
  }

  Positioned bottonDotsWidget() {
    return Positioned(
        bottom: 20.0,
        left: 0.0,
        right: 0.0,
        child: DotsIndicator(
          controller: _controller,
          itemCount: _pages.length,
          onPageSelected: (int page) {
            _controller.animateToPage(
              page,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          },
        ));
  }

  Positioned appBarWithButton(bool isLastPage, BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: new SafeArea(
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          primary: false,
          centerTitle: true,
          leading: Visibility(
              visible: leadingVisibility,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _controller.animateToPage(currentPageIndex - 1,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeOut);
                },
              )),
          actions: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, right: 16.0, bottom: 8.0),
              child: RaisedButton(
                child: Text(
                  isLastPage ? 'DONE' : 'NEXT',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: isLastPage
                    ? () {
                        // Last Page Done Click
                        SharedPreferencesUtils.setOnBoardScreen(false);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );

                      }
                    : () {
                        _controller.animateToPage(currentPageIndex + 1,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Positioned pageViewFillWidget() {
    return Positioned.fill(
        child: PageView.builder(
      controller: _controller,
      itemCount: _pages.length,
      itemBuilder: (BuildContext context, int index) {
        return _pages[index % _pages.length];
      },
      onPageChanged: (int p) {
        setState(() {
          currentPageIndex = p;
          if (currentPageIndex == 0) {
            leadingVisibility = false;
          } else {
            leadingVisibility = true;
          }
        });
      },
    ));
  }
}
