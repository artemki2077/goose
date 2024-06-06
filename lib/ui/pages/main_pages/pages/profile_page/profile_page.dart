import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goose/core/global.dart' as global;
import 'package:goose/data/models/product.dart';
import 'package:goose/data/repos/database_repo.dart';
import 'package:goose/ui/pages/main_pages/pages/profile_page/widgets/product_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {

  List<Product> products = [];


  loadData(){
    products = global.getIt.get<DataBaseRepo>().getAll();
  }

  @override
  void initState() {
    loadData();
    super.initState();
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
                      'Сохранёное',
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
        Flexible(
          child: products.isNotEmpty ? ListView(
            padding: const EdgeInsets.all(0),
            children: products.map((product)=>ProductWidget(product: product, onDelete: (BuildContext context)async{
              await global.getIt.get<DataBaseRepo>().delete(product);
              loadData();
              setState(() {});
            })).toList(),
          ) : const Center(
            child: Text(
              "Тут пока пусто",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          )
        )
      ],
    );
  }
}