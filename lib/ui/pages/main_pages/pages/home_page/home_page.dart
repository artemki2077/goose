import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goose/data/models/product.dart';
import 'package:goose/data/repos/database_repo.dart';
import 'package:goose/ui/pages/main_pages/pages/home_page/widgets/product_widget.dart';
import 'package:http/http.dart' as http;
import 'package:goose/core/global.dart' as global;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textEditingController = TextEditingController();

  Future<List<Product>> loadProduct() async{
    http.Response response = await http.post(Uri.http('127.0.0.1:8000', '/data/search', {
      "search": textEditingController.text,
    }));
    List data = await jsonDecode(utf8.decode(response.bodyBytes)) as List;
    return data.map((e)=>Product.fromApi(e)).toList();
  }

  Future onRefresh()async{
    await loadProduct();
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Гусь", 
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 5
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO( 255, 163, 26, 1),
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Center(
                    child: Text(
                      'App',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700
                      ),
                    ),
                    
                  ),
                )
              ],
            )
          )
        ),
        Container(
          padding: const EdgeInsets.all(12),
          child: TextField(
            style: const TextStyle(
              color: Colors.white
            ),
            cursorColor: Colors.white,
            onTapOutside: (e){
              FocusScope.of(context).requestFocus(FocusNode());
            },
            controller: textEditingController,
            onEditingComplete: (){
              setState(() {});
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search,),
              suffixIcon: IconButton(
                icon: const Icon(Icons.filter_alt_rounded), 
                onPressed: (){
                  // TODO: make filter
                },
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.grey[900],
            ),
          ),
        ),
        FutureBuilder<List<Product>>(
          future: loadProduct(),
          builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot){
            
            if(snapshot.hasData && snapshot.data != null){
              return Flexible(
                child: RefreshIndicator(
                  backgroundColor: Colors.grey[700],
                  color: const Color.fromRGBO( 255, 163, 26, 1),
                  onRefresh: onRefresh,
                  child: ListView(
                    padding: const EdgeInsets.all(5),
                    children: snapshot.data!.map((Product product)=> ProductWidget(product: product, onLike: (BuildContext context){ 
                      global.getIt.get<DataBaseRepo>().add(product);
                    },)).toList(),
                  ),
                )
              );
            }else if(snapshot.hasError){
              return Flexible(
                child: RefreshIndicator(
                  backgroundColor: Colors.grey[700],
                  color: const Color.fromRGBO( 255, 163, 26, 1),
                  onRefresh: onRefresh,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.errorContainer,
                              borderRadius: BorderRadius.circular(12)
                            ),
                            child: Text(
                              "Произашла ошибка, кажеться у вас не включён интернет",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.error
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ); 
            }
            else{
              return const Flexible(
                child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            }
          },
        ),
        
      ],
    );
  }

  void _reload() {
    setState(() {});
  }
}