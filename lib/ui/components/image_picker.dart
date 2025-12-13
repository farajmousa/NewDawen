import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../helper/app_color.dart';
import '../../helper/app_util.dart';
// import 'package:image/image.dart' as Img;


class MyImagePicker extends StatefulWidget {
  final double size;
  File? imageFile;
  final Function(String) onImagePicked;

  MyImagePicker({required this.size, this.imageFile,  required this.onImagePicked});

  @override
  State<StatefulWidget> createState() {
    return StateScreen();
  }
}

typedef void OnPickImageCallback(
    double maxWidth, double maxHeight, int quality);

class StateScreen extends State<MyImagePicker> {
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size  ,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.size  / 2),
          child: Stack(
            children: [
              (null != widget.imageFile)
                  ? Image.file(
                File(widget.imageFile?.path ?? ""),
                fit: BoxFit.cover,
                width: widget.size ,
                height: widget.size ,
              )
                  : Center(),
              Positioned.fill(
                child:  OutlinedButton(

                  onPressed: () async {
                    final pickedFile =
                    await picker.pickImage(source: ImageSource.camera , maxHeight:  200 , maxWidth: 200 , imageQuality: 60);

                      if (pickedFile != null) {
                        var file = File(pickedFile.path);
                        var size = await file.length() ;
                        setState(()  {
                          // imageFile = File(pickedFile.path);
                          widget.onImagePicked(file.path);
                        });
                      } else {
                        appLog('No image selected.');
                      }
                  },
                  // shape: new CircleBorder(),
                  // borderSide: BorderSide(color: AppColor.primary, width: 2),
                  child: const Icon(
                    Icons.camera_alt,
                    color: AppColor.primary,
                    size: 28,
                  ),
                ),
              ),

            ],
          ),),

    );
  }

}
