import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/screens/mmodel.dart';

class ViewPage extends StatelessWidget {
  final Movie makeup;

  ViewPage({required this.makeup});

  @override
  Widget build(BuildContext context) {
    String imageUrl = '${makeup.image_link}';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(makeup.name.toString()), 
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
              ),
              SizedBox(height: 16),
              Text(
                makeup.name.toString(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Release Date: ${makeup.price}',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 16),
              Text(
                'Overview:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '${makeup.description}'  ,
               
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),

              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.5, 
                        width: double.infinity,
                        child: AnyLinkPreview(
                          link: 'https://well.ca/products/maybelline-face-studio-master_88837.html', 
                          previewHeight: 200, 
                          showMultimedia: true,
                          
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade600,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 50,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Makup Link",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
