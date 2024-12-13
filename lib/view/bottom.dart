import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sourcecad_app/utils/extensions/space.dart';
import 'package:sourcecad_app/utils/extensions/theme_extension.dart';
import '../constant/my_theme.dart';
import '../view_models/bottom_vm.dart';
import '../widgets/base_widgets.dart';


class BottomScreen extends BaseWidget<BottomVM> {
  const BottomScreen({super.key});

  @override
  Widget buildUI(BuildContext context, BottomVM viewModel) {
    return Container(
      decoration: BoxDecoration(
          gradient:LinearGradient(
              colors: [
                context.theme.primary,
                context.theme.onPrimary,
                MyColor.onSubPrimary,
              ]
          )
      ),
      child: Scaffold(
        backgroundColor:Colors.transparent,
        // drawer:const CustomDrawer(),
        appBar:
        PreferredSize(
          preferredSize:viewModel.tabIndex==0||viewModel.tabIndex==3? const Size.fromHeight(120.0):Size.fromHeight(60.0),
          child: AppBar(
            bottom:viewModel.tabIndex==0||viewModel.tabIndex==3?PreferredSize(
              preferredSize: const Size.fromHeight(10.0),
              child:viewModel.tabIndex==0? Padding(
                padding: const EdgeInsets.only(left:15,right:15,bottom:20),
                child: InkWell(
                  onTap:(){
                  },
                  child: Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      color:MyColor.white,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(10.0)),
                    ),
                    padding: const EdgeInsets.only(right: 5),
                    child: Row(
                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: SvgPicture.asset(
                                "assets/svg/search.svg",
                              ),
                              onPressed: () {},
                            ),
                            spaceX(),
                            Text("Search ",style:TextStyle(color:MyColor.subTextGrey,
                                fontSize: 14.0),),
                          ],
                        ),
                        IconButton(
                          icon: SvgPicture.asset(
                            "assets/svg/mic.svg",
                          ),
                          onPressed: () {
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ):
              Padding(
                padding: const EdgeInsets.only(left:15,right:15,bottom:20),
                child: Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    color:MyColor.white,
                    border:Border.all(color:MyColor.grey),
                    borderRadius: const BorderRadius.all(
                        Radius.circular(10.0)),
                  ),
                  padding: const EdgeInsets.only(right: 5),
                  child: TextFormField(
                    onTap: () {
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabled: true,
                      contentPadding: EdgeInsets.zero,
                      hintText: "Search",
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset(
                          "assets/svg/mic.svg",
                        ),
                        onPressed: () {},
                      ),
                      prefixIcon: IconButton(
                        icon: SvgPicture.asset(
                          "assets/svg/search.svg",
                        ),
                        onPressed: () {},
                      ),
                      hintStyle: TextStyle(color:MyColor.grey,
                          fontSize: 13.0),
                    ),
                  ),
                ),
              )
            ):PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Container()
            ),
            // leadingWidth:100,
            iconTheme: IconThemeData(color: context.theme.background),
            centerTitle:false,
            title:Image.asset("assets/png/anuda.png",height:40,),
            // Column(
            //   mainAxisAlignment:MainAxisAlignment.center,
            //   crossAxisAlignment:CrossAxisAlignment.center,
            //   children: [
            //     SvgPicture.asset("assets/svg/anuda.svg"),
            //     // Text("Welcome To,",style:TextStyle(fontSize:12,color:MyColor.background,fontWeight:FontWeight.w300),),
            //     // Text("    Dinesh sharma.",style:TextStyle(fontSize:12,color:MyColor.background,fontWeight:FontWeight.w400),),
            //
            //   ],
            // ),
            backgroundColor:Colors.transparent,
            elevation:0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient:LinearGradient(
                    // begin: Alignment.bottomLeft,
                    // end: Alignment.topRight,
                      colors: [
                        context.theme.primary,
                        context.theme.onPrimary,
                        MyColor.onSubPrimary,

                      ]
                  )
              ),
            ),
            actions: [
              InkWell(
                  onTap:(){
                  },
                  child: SvgPicture.asset("assets/svg/favorite.svg")),
              spaceX(extra:15),
              InkWell(
                onTap:(){
                },
                  child: SvgPicture.asset("assets/svg/notification.svg")),
              spaceX(extra:15),
              // InkWell(
              //     onTap:(){
                    // Scaffold.of(context).openEndDrawer();
              //
              //     },
              //     child: SvgPicture.asset("assets/svg/drawer.svg")),
              // spaceX(extra:15),

            ],
          ),
        ),
        bottomNavigationBar: Material(
          elevation:5,
          borderRadius: const BorderRadius.only(topLeft:Radius.circular(8),topRight:Radius.circular(8)),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft:Radius.circular(8),topRight:Radius.circular(8)),
              color:MyColor.white,
            ),
            child: BottomNavigationBar(
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: context.theme.primary,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              backgroundColor: Colors.transparent,
              unselectedLabelStyle: TextStyle(fontSize: 10,color:MyColor.subTextGrey),
              selectedLabelStyle:  TextStyle(fontSize: 10,color:context.theme.primary),
              onTap: (value) {
                viewModel.tabIndex = value;
                viewModel.pageController.jumpToPage(value);
              },
              currentIndex: viewModel.tabIndex,
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/svg/home.svg",height:22,
                        colorFilter:viewModel.tabIndex == 0 ? ColorFilter.mode(context.theme.primary, BlendMode.srcIn): ColorFilter.mode(MyColor.subTextGrey, BlendMode.srcIn)),
                    backgroundColor: Colors.transparent,
                    label: 'Home',),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/svg/course.svg",height:25,
                        colorFilter:viewModel.tabIndex == 1 ? ColorFilter.mode(context.theme.primary, BlendMode.srcIn): ColorFilter.mode(MyColor.subTextGrey, BlendMode.srcIn)),
                    backgroundColor: Colors.transparent,
                    label: 'Course'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/svg/professer.svg",height:22,
                        colorFilter:viewModel.tabIndex == 2 ? ColorFilter.mode(context.theme.primary, BlendMode.srcIn): ColorFilter.mode(MyColor.subTextGrey, BlendMode.srcIn)
                    ),
                    backgroundColor: Colors.transparent,
                    label: 'Professer'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/svg/webinars.svg",height:25,
                        colorFilter:viewModel.tabIndex == 3 ? ColorFilter.mode(context.theme.primary, BlendMode.srcIn): ColorFilter.mode(MyColor.subTextGrey, BlendMode.srcIn)),
                    backgroundColor: Colors.transparent,
                    label: 'Webinars'),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset("assets/svg/profile.svg",height:22,
                        colorFilter:viewModel.tabIndex == 4 ? ColorFilter.mode(context.theme.primary, BlendMode.srcIn):ColorFilter.mode(MyColor.subTextGrey, BlendMode.srcIn)),
                    backgroundColor: Colors.transparent,
                    label: 'Profile'),
              ],
            ),
          ),
        ),
        body: WillPopScope(
          onWillPop: (){
            return onexit(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color:
              // MyColor.colorgrey,
              Colors.grey.shade300,
              borderRadius:const BorderRadius.only(topLeft:Radius.circular(30),topRight: Radius.circular(30),),
            ),
            child: PageView(
              onPageChanged: (page){
                viewModel.tabIndex = page;
              },
              controller:viewModel.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children:  [
                Container(),
                Container(),
                Container(),
                Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<bool> onexit(BuildContext context) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Container(
            margin: const EdgeInsets.only(top: 25, left: 15, right: 15),
            height: 100,
            child: Column(
              children: <Widget>[
                const Text("Are you sure you want to exit?"),
                Container(
                  margin: const EdgeInsets.only(top: 22),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  offset: const Offset(0.0, 1.0),
                                  blurRadius: 1.0,
                                  spreadRadius: 0.0)
                            ],
                            color:MyColor.primary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            "No",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop');
                        },
                        child: Container(
                          width: 100,
                          height: 40,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.blue.withOpacity(0.1),
                                  offset: const Offset(0.0, 1.0),
                                  blurRadius: 1.0,
                                  spreadRadius: 0.0)
                            ],
                            color:MyColor.primary,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text("Yes",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
