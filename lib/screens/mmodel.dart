class Movie {
  final String brand;
  final String name;
  final String price;
  final String image_link;
  final String description;
  
  

  Movie({
    required this.brand,
    required this.name,
    required this.price,
    required this.image_link,
    required this.description,
  
 
  });

  
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      brand: json['brand'] ?? 'N/A',
      name: json['name'] ?? 'N/A',
      price: json['price'] ?? '',
     image_link: json['image_link'] ?? '',
     description: json['description'] ?? 'N/A',
     
     
    );
  }
}
