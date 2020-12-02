import 'dart:typed_data';

import 'package:face_detection/app/providers/register.provider.dart';
import 'package:face_detection/widgets/custom_button.dart';
import 'package:face_detection/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Registration",
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => RegisterProvider(),
        child: Consumer<RegisterProvider>(builder: (context, value, child) {
          return ListView(
            padding: EdgeInsets.all(8),
            children: [
              Wrap(
                direction: Axis.horizontal,
                children: [
                  ...value.images.map((e) => InkWell(
                        onLongPress: () => value.removeImageFromList(e),
                        child: Container(
                          width: 120,
                          height: 150,
                          margin: EdgeInsets.all(4),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(
                                  e,
                                )),
                            border: Border.all(
                                color: Theme.of(context).accentColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: value.notAcceptedImages
                                  .contains(e.path.split("/").last)
                              ? Center(
                                  child: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                )
                              : Container(),
                        ),
                      )),
                  value.images.length >= 5
                      ? Container()
                      : Container(
                          width: 120,
                          height: 150,
                          margin: EdgeInsets.all(4),
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).accentColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: GestureDetector(
                              onTap: () {
                                value.getImage();
                              },
                              child: Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 40,
                                ),
                              )),
                        ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                text: 'Email',
                isLable: true,
                isPassword: false,
                maxLines: 1,
                type: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.email),
                onChange: (text) {
                  value.email = text;
                },
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                text: 'Name',
                isLable: true,
                isPassword: false,
                maxLines: 1,
                type: TextInputType.name,
                prefixIcon: Icon(Icons.create),
                onChange: (text) {
                  value.firstname = text;
                },
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextField(
                text: 'LastName',
                isLable: true,
                isPassword: false,
                maxLines: 1,
                type: TextInputType.name,
                prefixIcon: Icon(Icons.create),
                onChange: (text) {
                  value.lastname = text;
                },
              ),
              SizedBox(
                height: 15,
              ),
              CustomButton(
                  text: value.isLoading ? "Processing.." : "Submit",
                  isPrimary: true,
                  onPressed: () {
                    value.isLoading ? null : value.register();
                  })
            ],
          );
        }),
      ),
    );
  }
}
