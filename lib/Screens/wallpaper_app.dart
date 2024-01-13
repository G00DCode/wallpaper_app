import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/Screens/detail_screen.dart';
import '../Modals/wallpaper_modals.dart';

class WallpaperApp extends StatefulWidget {
  const WallpaperApp({super.key});

  @override
  State<WallpaperApp> createState() => _WallpaperAppState();
}

class _WallpaperAppState extends State<WallpaperApp> {
  TextEditingController searchController=TextEditingController();
  var mykey="mbolHql5cbem5lzmNQ1JCb1mTZnqAehYSjuzRITod2uBtIsprvMpSaKr";
  late Future<WallpaperModal>wallpaper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wallpaper=getWallpapers("Computer");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallpaper App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search Wallpaper",
                suffixIcon: IconButton(onPressed: (){
                  wallpaper=getWallpapers(searchController.text.toString());
                  setState(() {

                  });
                },icon: Icon(Icons.search),),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),

              ),

                  ),
          ),
          SizedBox(height: 30,),
          FutureBuilder(future: wallpaper, builder: (context,snapshot){
            if(snapshot.hasData){
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                    snapshot.data!.photos!.map((pics) => Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(image: pics.src!.portrait!)));
                        },
                        child: Container(
                          clipBehavior: Clip.antiAlias,

                          height: 200,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),

                          ),
                          child: Image.network("${pics.src!.portrait}",fit: BoxFit.cover,),
                        ),
                      ),
                    )).toList(),



                ),
              );

            }
            else if(snapshot.hasError){
              return Center(child: Text("${snapshot.hasError}"),);
            }
            else{
              return Center(child: CircularProgressIndicator());
            }


    }),
        ],
      ),

    );
  }
  Future<WallpaperModal>getWallpapers(String search)async{
    var url='https://api.pexels.com/v1/search?query=$search';
    var response=await http.get(Uri.parse(url),headers: {"Authorization":mykey});
    if(response.statusCode==200){
      var photos=jsonDecode(response.body);
      return WallpaperModal.fromJson(photos);
    }
    else{
      return WallpaperModal();
    }


  }

}
