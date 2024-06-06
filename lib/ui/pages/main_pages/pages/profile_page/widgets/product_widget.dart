import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:goose/data/models/product.dart';
import 'package:goose/core/global.dart' as global;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductWidget extends StatelessWidget {
  final Product product;
  final Function(BuildContext context) onDelete;
  const ProductWidget({super.key, required this.product, required this.onDelete});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle styleTextProduct = const TextStyle(color: Colors.white);
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
              foregroundColor: const Color.fromRGBO(242, 72, 61, 1),
              onPressed: onDelete,
              label: "Удалить",
              padding: const EdgeInsets.all(0),
              icon: Icons.delete,
              backgroundColor: const Color.fromRGBO(254, 235, 238, 1),
        ),
        ],
      ),
      child: GestureDetector(
        onTap: (){
          _launchUrl(product.originalLink);
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.symmetric(vertical: 5),
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                padding: const EdgeInsets.symmetric(vertical: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: product.imgUrl != null ? 
                Image.network(product.imgUrl!) : 
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[700],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.no_photography,
                      color: Colors.white,
                    ),
                  ),
                  
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(product.name, 
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text("Цена: ${global.formatCurrency.format(product.price)}", 
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: Colors.white
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    ...product.addData.entries.map((e)=>Flexible(child: Text('${e.key}: ${e.value}', style: styleTextProduct, overflow: TextOverflow.ellipsis,))).toList(),
                  ],
                ),
              )
                
            ],
          ),
        ),
      ),
    );
  }
}