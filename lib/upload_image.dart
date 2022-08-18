import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async {
    try {
      final pickedFile = await _picker.pickImage(
          source: ImageSource.gallery, imageQuality: 80);

      if (pickedFile != null) {
        setState(() {
          image = File(pickedFile.path);
        });
      }
    } on PlatformException catch (e) {
      print("failde to pick $e");
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });
    String addimageUrl = 'http://likid-dev.seesay-consulting.com/api/enrollment';
    // String addimageUrl = 'https://fakestoreapi.com/products';
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };
    // request.fields['category'] = "CLIENT";
    // request.fields['firstname'] = "Static title";
    // request.fields['lastname'] = "Static title";
    // request.fields['email'] = "paf@gmail.com";
    // request.fields['mobile'] = "7775";
    // request.fields['passport'] = "755";
    // request.fields['adresse'] = "Dakar";
    // request.fields['enterprise'] = "Static title";
    // request.fields['contact_enterprise_mobile'] = "77555";
        Map<String, String> body = {
          'category':  "CLIENT",
          'firstname':  "Static title",
          'lastname':  "Static title",
          'email':  "paf102@gmail.com",
          'mobile':  "7775125",
          'passport':  "75545116",
          'adresse':  "Dakar1",
          'enterprise':  "Static title",
          'contact_enterprise_mobile':  "756451",

      };

    // Map<String, String> body = {
    //   'title':  "Static title"};
    var request = http.MultipartRequest('POST', Uri.parse(addimageUrl))
      ..fields.addAll(body)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('passport_img', image!.path));
    var response = await request.send();

    if (response.statusCode == 200) {
      var responseData =await response.stream.toBytes();
      var reslt = String.fromCharCodes(responseData);
      print(request.fields['image']);
      setState(() {
        showSpinner = false;
      });
      print('image uploaded');
    } else {
      var responseData =await response.stream.toBytes();
      var reslt = String.fromCharCodes(responseData);
      print(reslt);
      setState(() {
        showSpinner = false;
      });
    }




    // if (response.statusCode == 200) {

    // } else {

    // }

    // var stream = http.ByteStream(image!.openRead());
    // stream.cast();

    // var length = await image!.length();

    // var uri = Uri.parse('https://fakestoreapi.com/products');

    // var request = http.MultipartRequest('POST', uri);

    // request.fields['title'] = "Static title";
    // request.fields['price'] = "20";

    // var multiport = http.MultipartFile('image', stream, length);

    // request.files.add(multiport);

    // var response = await request.send();

    //print(response.stream.toString());

  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload Image'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: Container(
                child: image == null
                    ? const Center(
                        child: Text('Pick Image'),
                      )
                    : Center(
                        child: Image.file(
                          File(image!.path).absolute,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            const SizedBox(
              height: 150,
            ),
            GestureDetector(
              onTap: () {
                uploadImage();
              },
              child: Container(
                height: 50,
                width: 200,
                color: Colors.green,
                child: Center(child: Text('Upload')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
