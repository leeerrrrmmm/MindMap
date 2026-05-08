import 'package:flutter/material.dart';
import 'package:mind_map/features/account/presentation/personal_data_action_widget.dart';
import 'package:mind_map/features/account/widgets/first_last_name_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary,
        ),
        title: Image.asset('assets/images/red_logo.png'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
                children: [
                  Center(child: _AvatarWidget()),
                  FirstLastNameWidget(
                    controller: _firstNameController,
                    userFirstName: 'John',
                    userLastName: 'Doe',
                    title: 'First Name',
                  ),
                  FirstLastNameWidget(
                    controller: _lastNameController,
                    userFirstName: 'John',
                    userLastName: 'Doe',
                    title: 'Last Name',
                  ),
                  const SizedBox(height: 20),
                  _PersonalDataBloc(),
                ],
              ),
            ),
          ),

          _BottomCircle(),

          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: Column(
                spacing: 10,
                mainAxisSize: MainAxisSize.min,
                children: [
                  PersonalDataActionWidget(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    iconColor: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryColor,
                    icon: Icons.logout_rounded,
                    label: 'Log out of your account',
                    onTap: () {
                      //TODO: Implement navigation to change password screen
                    },
                  ),
                  PersonalDataActionWidget(
                    color: Theme.of(context).colorScheme.secondary,
                    iconColor: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryColor,
                    icon: Icons.delete_forever_rounded,
                    label: 'Delete your account',
                    titleCenter: true,
                    onTap: () {
                      //TODO: Implement navigation to change password screen
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PersonalDataBloc extends StatelessWidget {
  const _PersonalDataBloc();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          'Personal Data',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
        ),
        PersonalDataActionWidget(
          color: Color(0xFFD9D9D9),
          iconColor: Theme.of(context).colorScheme.secondary,
          textColor: Theme.of(context).colorScheme.secondary,
          icon: Icons.lock_rounded,
          label: 'Change the password',
          onTap: () {
            //TODO: Implement navigation to change password screen
          },
        ),
        PersonalDataActionWidget(
          color: Color(0xFFD9D9D9),
          iconColor: Theme.of(context).colorScheme.secondary,
          textColor: Theme.of(context).colorScheme.secondary,
          icon: Icons.email,
          label: 'Change the email',
          onTap: () {
            //TODO: Implement navigation to change password screen
          },
        ),
      ],
    );
  }
}

class _AvatarWidget extends StatelessWidget {
  const _AvatarWidget();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: Icon(
        Icons.person,
        color: Theme.of(context).primaryColor,
        size: 40,
      ),
    );
  }
}

class _BottomCircle extends StatelessWidget {
  const _BottomCircle();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF000000).withValues(alpha: 0.1),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(200),
            topLeft: Radius.circular(200),
          ),
        ),
      ),
    );
  }
}
