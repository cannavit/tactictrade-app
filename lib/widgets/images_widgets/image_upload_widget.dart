import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tactictrade/share_preferences/preferences.dart';

class ImageUploadWidget extends StatefulWidget {
  const ImageUploadWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Row(
          children: const [
            Text('Add Strategy Image ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w300)),
          ],
        ),
        
        const SizedBox(height: 10),

        _UploadImage(
            icon: Icons.add_a_photo,
            imagePath: Preferences.tempProfileImage,
            onClicked: () async {}),

        const SizedBox(height: 20),
      ],
    );
  }
}

class _UploadImage extends StatefulWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final IconData icon;

  const _UploadImage(
      {Key? key,
      required this.imagePath,
      required this.onClicked,
      this.icon = Icons.edit})
      : super(key: key);

  @override
  State<_UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<_UploadImage> {
  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context);

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            child: GestureDetector(
              child: buildEditImageIcon(themeColors.primaryColor, widget.icon),
              onTap: () async {
                print('TAP BOTTOM 2 Take Picture');

                final picker = await ImagePicker();

                final pickedFile =
                    await picker.pickImage(source: ImageSource.camera);

                if (pickedFile == null) return;

                Preferences.tempStrategyImage = pickedFile.path;

                setState(() {});
              },
            ),
            bottom: 0,
            right: 1,
          ),
          Positioned(
            child: GestureDetector(
              onTap: () async {
                final picker = await ImagePicker();


                final pickedFile =
                    await picker.pickImage(source: ImageSource.gallery);


                if (pickedFile == null) return;

                Preferences.tempStrategyImage = pickedFile.path;
                setState(() {});
              },
              child: buildEditImageIcon(themeColors.primaryColor,
                  Icons.photo_size_select_actual_rounded),
            ),
            bottom: 0,
            right: 50,
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = Preferences.tempStrategyImage == ''
        ? AssetImage('assets/no-image.png')
        : AssetImage(Preferences.tempStrategyImage);

    return Material(
      color: Colors.transparent,
      child: Ink.image(
        image: image as ImageProvider,
        fit: BoxFit.cover,
        // width: 148,
        height: 148,
        child: InkWell(onTap: widget.onClicked),
      ),
    );
  }

  Widget buildEditImageIcon(Color color, IconData icon) => ClipOval(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(3),
          child: ClipOval(
            child: Container(
                color: color,
                padding: const EdgeInsets.all(8),
                child: Icon(icon, size: 20, color: Colors.white)),
          ),
        ),
      );
}
