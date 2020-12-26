
import 'package:flutter/material.dart';
import 'package:health_body_checking/src/constants/app_colors.dart';
import 'package:health_body_checking/src/core/routes/routes.dart';
import 'package:health_body_checking/src/models/user_model.dart';
import 'package:health_body_checking/src/providers/auth_provider.dart';
import 'package:health_body_checking/src/ui/profile/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreemState createState() => _ProfileScreemState();
}

class _ProfileScreemState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    print(CurrentUserModel.instance.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          _profilePhoto(),
          Expanded(child: Container()),
          _profileCard()
        ],
      ),
    );
  }

  Widget _profilePhoto() {
    return Center(
        child: Image.asset(
      'assets/images/no-image.jpg',
      width: 60,
      height: 60,
      fit: BoxFit.cover,
    ));
  }

  Widget _profileCard() {
    final authProvider = Provider.of<AuthProvider>(context);
    return Container(
      padding: EdgeInsets.only(right: 40, left: 40, top: 10),
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: AppColors.WHITE),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(CurrentUserModel.instance?.name ?? ''),
          Text(CurrentUserModel.instance?.country ?? ''),
          _userInfo('Peso', '${CurrentUserModel.instance?.weight ?? ''}'),
          _userInfo('Altura', '${CurrentUserModel.instance?.height ?? ''}'),
          _userInfo('Edad', '${CurrentUserModel.instance?.age ?? ''}'),
          Divider(),
          CustomButton(
              inputFunction: () {
                Navigator.of(context).pushNamed(Routes.profile_edit);
              },
              text: 'Editar perfil'),
          SizedBox(
            height: 10,
          ),
          CustomButton(
              inputFunction: () {
                Navigator.of(context).pushNamed(Routes.profile_settings);
              },
              text: 'Ajustes'),
          SizedBox(
            height: 10,
          ),
          CustomButton(
              inputFunction: () {
                authProvider.signOut();
              },
              text: 'Salir',
              filled: true),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  Widget _userInfo(String name, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
