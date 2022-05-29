
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:tactictrade/services/auth_service.dart';
import 'package:tactictrade/services/profile_service.dart';
import 'package:tactictrade/share_preferences/preferences.dart';
import 'package:tactictrade/widgets/custom_profile_widget.dart';
import 'package:tactictrade/widgets/editfield_custom.dart';
// https://www.youtube.com/watch?v=gSl-MoykYYk

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final String username = 'Rivas Mora';

  late Preferences preferences;

  final usernameCtrl = TextEditingController(text: Preferences.username);

  final aboutCtrl = TextEditingController(text: Preferences.about);

  final pathGalleryImageCtrl =
      TextEditingController(text: Preferences.pathGalleryImage);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context);
    final username = Preferences.username;

    final profileService = Provider.of<ProfileService>(context, listen: false);
    final authService = Provider.of<AuthService>(context, listen: false);

    const String tempImage = '';

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness:
                Preferences.isDarkmode ? Brightness.dark : Brightness.light,
            statusBarBrightness:
                Preferences.isDarkmode ? Brightness.light : Brightness.dark,
          ),
          title: Text('Edit Profile',
              style: TextStyle(
                  color: themeColors.secondaryHeaderColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w300)),
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: themeColors.primaryColor,
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'navigation');
            },
          ),
          actions: const [],
          elevation: 0,
        ),
        // appBar: userAppBar(context),
        body: ListView(
          children: [
            CustomProfilImage(
                icon: Icons.add_a_photo,
                imagePath: Preferences.tempProfileImage,
                onClicked: () async {
                  final ImagePicker _picker = ImagePicker();

                  XFile? pickedFile;
                  try {
                    pickedFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                  } catch (e) {
                    print(e);
                  }

                  print(pickedFile);

                  if (pickedFile == null) return;

                  Preferences.tempProfileImage = pickedFile.path;

                  setState(() {});

                  // setState(() {});
                }),
            const SizedBox(height: 24),

            // InputEditWidgets(),
            EditTextField(
              themeColors: themeColors,
              usernameCtrl: usernameCtrl,
              nameEditField: 'User name',
            ),

            EditTextField(
                themeColors: themeColors,
                usernameCtrl: aboutCtrl,
                nameEditField: 'About',
                maxLines: 8),

            Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                height: 45,
                width: double.infinity,
                child: RaisedButton(
                  elevation: 1,
                  shape: const StadiumBorder(),
                  color: Colors.blue,
                  child: const Center(
                    child: Text('Save',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                  onPressed: () async {
                    //TODO get data and edit API Profil

                    Preferences.pathGalleryImage = Preferences.tempProfileImage;

                    await profileService.updateProfil(usernameCtrl.text,
                        aboutCtrl.text, Preferences.pathGalleryImage);

                    if (!Preferences.pathGalleryImage.contains('http')) {
                      Preferences.profileImage = Preferences.tempProfileImage;
                    }

                    final token =
                        await const FlutterSecureStorage().read(key: 'token_access');

                    if (token != '') {
                      final profileData =
                          await authService.readProfileData(token!);

                      Preferences.about = profileData['about'];
                      Preferences.username = profileData['username'];
                      Preferences.profileImage = profileData['profile_image'];
                      Preferences.tempProfileImage =
                          profileData['profile_image'];

                      Navigator.pushReplacementNamed(context, 'profile');
                    }

                    Preferences.tempProfileImage = Preferences.profileImage;
                  },
                ))
          ],
        ));
  }
}

class InputEditWidgets extends StatelessWidget {
  const InputEditWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('User name',
              style: TextStyle(
                  color: themeColors.hintColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600)),
          Container(
            padding:
                const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: TextFormField(
              // controller: textController,
              autocorrect: false,
              // keyboardType: keyboardType,
              // obscureText: isPassword,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(30.0, 14.0, 20.0, 10.0),
                prefixIcon: Icon(Icons.account_circle),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: 'Lane Moss',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _infoUserWidget extends StatelessWidget {
  final String value;
  final String text;

  const _infoUserWidget({
    Key? key,
    required this.value,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.black87,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        Text(text,
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w700)),
      ],
    );
  }
}

class _Username extends StatelessWidget {
  const _Username({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Rollins Fletcher',
          style: TextStyle(
              color: Colors.black87,
              fontSize: 24,
              fontWeight: FontWeight.bold)),
    );
  }
}

class _upgradeButton extends StatelessWidget {
  const _upgradeButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialButton(
        color: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        onPressed: () {},
        child: const Text('Upgrade to Pro',
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600)),
      ),
    );
  }
}
