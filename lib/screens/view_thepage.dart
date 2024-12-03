import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/screens/mmodel.dart';

class ViewPage extends StatelessWidget {
  final Movie movie_name;

  ViewPage({required this.movie_name});

  @override
  Widget build(BuildContext context) {
    String imageUrl = '${movie_name.poster}';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(movie_name.title.toString()), 
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
                movie_name.title.toString(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Release Date: ${movie_name.year}',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 16),
              Text(
                'Overview:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '${movie_name.title} are a form of visual storytelling that combines elements like acting, direction, cinematography, sound, and editing to create an immersive experience. They span across various genres, including drama, action, comedy, horror, and science fiction, catering to diverse tastes. Over the years, movies have evolved with technological advancements, from silent films to modern CGI spectacles. They serve as both entertainment and a medium for exploring cultural, social, and political themes. From independent productions to blockbuster franchises, movies have a profound impact on popular culture, influencing trends, shaping public opinion, and providing a platform for creative expression.',
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
                          link: 'https://www.imdb.com/', 
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
                      "Movie Link",
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
