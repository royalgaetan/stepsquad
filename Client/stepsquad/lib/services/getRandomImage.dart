import 'package:dio/dio.dart';
import 'package:stepsquad/utils/utils.dart';

Future<String> fetchRandomImage({int? photoIndex}) async {
  try {
    Dio dio = createDioInstance();

    // Make a GET request to the Pexels API
    Response response = await dio.get(
      'https://api.pexels.com/v1/curated?per_page=100&page=1',
      options: Options(headers: {
        'Authorization': pexelAPIKey,
      }),
    );

    // Parse the response and extract the image URL
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      List<dynamic> photos = data['photos'];

      if (photos.isNotEmpty) {
        String imageUrl = photos[photoIndex ?? 0]['src']['original'];
        print('Random Image URL: $imageUrl');
        return imageUrl;
      }
      //
      else {
        throw 'No photos found';
      }
    } else {
      throw 'Failed to fetch image';
    }
  } catch (error) {
    throw 'An error occurred: $error';
  }
}
