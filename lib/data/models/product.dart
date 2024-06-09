


class Product{
  final DateTime lastUpdate;
  final String name;
  final double price;
  final String? imgUrl;
  final String originalLink;
  final Map addData;

  const Product({
    required this.lastUpdate,
    required this.name,
    required this.price,
    this.imgUrl,
    required this.originalLink,
    required this.addData,

  });

  factory Product.fromApi(Map json){
    return Product(
      lastUpdate: DateTime.parse(json['last_update']) ,
      name: json['name'],
      price: json['price'].toDouble(),
      imgUrl: json['img_url'],
      originalLink: json['original_link'],
      addData: json['add_data']
    );
  }

  factory Product.fromJson(Map json){
    return Product(
      lastUpdate: json['lastUpdate'],
      name: json['name'],
      price: json['price'],
      imgUrl: json['imgUrl'],
      originalLink: json['originalLink'],
      addData: json['addData'],
    );
  } 


  toJson(){
    return {
      "lastUpdate": lastUpdate,
      "name": name,
      "price": price,
      "imgUrl": imgUrl,
      "originalLink": originalLink,
      "addData": addData,
    };
  }
  
}