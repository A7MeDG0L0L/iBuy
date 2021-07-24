import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/modules/shop_app/cubit/shop_cubit.dart';
import 'package:udemy_flutter/modules/shop_app/cubit/shop_states.dart';
import 'package:udemy_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/components/constants.dart';
import 'package:udemy_flutter/shared/network/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        nameController.text = ShopCubit.get(context).loginModel.data.name;
        emailController.text = ShopCubit.get(context).loginModel.data.email;
        phoneController.text = ShopCubit.get(context).loginModel.data.phone;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).loginModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is ProfileLoadingUpdateDataState)
                      LinearProgressIndicator(),
                    Text(
                      'Your Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Name Must be filled';
                          }
                        },
                        label: 'Name',
                        prefix: Icons.person),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'E-mail Must be filled';
                          }
                        },
                        label: 'E-mail Address',
                        prefix: Icons.email),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Mobile Number Must be filled';
                          }
                        },
                        label: 'Mobile Number',
                        prefix: Icons.phone),
                    SizedBox(
                      height: 15,
                    ),
                    defaultButton(
                        function: () {
                          if (formKey.currentState.validate()) {
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                            );
                          }
                        },
                        text: 'Update'),
                    SizedBox(
                      height: 15,
                    ),
                    defaultButton(
                        function: () {
                          signOut(context);
                        },
                        text: 'Logout'),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
