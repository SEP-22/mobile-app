import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileDetails extends StatefulWidget {
  late String _id;
  late String name;
  late String phone;
  late String email;
  late String password;

  ProfileDetails(this._id, this.name, this.phone, this.email, this.password);

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
