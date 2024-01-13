import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wallpaper_app/Widgets/uihelper.dart';

class DetailScreen extends StatefulWidget {
  String image;

  DetailScreen({super.key,required this.image});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[ Container(
          height: double.infinity,
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
        
            ),
            child: Image.network("${widget.image}",fit: BoxFit.cover,)),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      String path=widget.image;
                      GallerySaver.saveImage(path).then((value){
                        return UiHelper.CustomAlertDialog(context, "Image Downloaded Successfully");
                      });
                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.4),
                      ),
                      child: Icon(Icons.download),
                    ),
                  ),
                  SizedBox(width: 25,),
                  GestureDetector(
                    onTap: ()async{
                      String result;
                      try{
                        result=await AsyncWallpaper.setWallpaper(url: widget.image,
                        wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,toastDetails: ToastDetails.success(),
                        errorToastDetails: ToastDetails.error()
                        )
                            ?"Wallpaper Successfully added"
                            :"Failed to get Wallpaper";


                      }on PlatformException {
                        result="Failed To get wallapaper";
                      }

                    },
                    child: Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.4),
                      ),
                      child: Icon(Icons.settings),
                    ),
                  ),

                ],
              ),
            ],
          ),
      ]),

    );
  }
}
