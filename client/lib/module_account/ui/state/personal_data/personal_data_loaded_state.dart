import 'dart:io';
import 'dart:html' as html;
import 'package:image_picker/image_picker.dart';
import 'package:mandob_moshtarayat/consts/urls.dart';
import 'package:mandob_moshtarayat/di/di_config.dart';
import 'package:mandob_moshtarayat/generated/l10n.dart';
import 'package:mandob_moshtarayat/module_account/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat/module_account/request/profile_request.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/favourite_screen.dart';
import 'package:mandob_moshtarayat/module_account/ui/screen/presonal_data_screen.dart';
import 'package:mandob_moshtarayat/module_account/ui/state/personal_data/personal_data_state.dart';
import 'package:mandob_moshtarayat/module_account/ui/widget/update_button.dart';
import 'package:mandob_moshtarayat/utils/components/custom_feild.dart';
import 'package:mandob_moshtarayat/utils/images/images.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class PersonalDataLoadedState extends PersonalDataState {
  PersonalDataScreenState screenState;
  ProfileModel? profileModel;

  PersonalDataLoadedState(this.screenState, this.profileModel)
      : super(screenState) {
    nameController.text = profileModel?.name ?? '';
    locationController.text = profileModel?.location ?? '';
    image = profileModel?.image ?? ImageAsset.NETWORK;
    if (profileModel!.image.contains('http')) {
      image = profileModel!.image;
    } else {
      image = Urls.IMAGES_ROOT + profileModel!.image;
    }
  }

  final GlobalKey<FormState> _personal_data = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  late ProfileRequest request;
  String? genders = '';

  var gender;

  late String image;
  @override
  Widget getUI(BuildContext context) {
    return Stack(
      children: [
        ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 150,
              child: Center(
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(18),
                    onTap: () {
                      ImagePicker.platform
                          .pickImage(
                              source: ImageSource.gallery, imageQuality: 75)
                          .then((value) {
                        if (value != null) {
                          screenState.fileString = value.path;
                          screenState.uploadImage(
                              ProfileModel(
                                name: nameController.text.trim(),
                                location: locationController.text.trim(),
                                image: image,
                              ),
                              value.path);
                        }
                      });
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: FadeInImage(
                            placeholder:
                                Image.asset(ImageAsset.PLACEHOLDER).image,
                            placeholderErrorBuilder: (_, w, t) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).backgroundColor),
                                child: const Center(
                                    child: Icon(
                                  Icons.info,
                                  size: 50,
                                )),
                              );
                            },
                            imageErrorBuilder: (_, w, t) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).backgroundColor),
                                child: Flex(
                                  direction: Axis.vertical,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Text(
                                          S.current.errorDownloadingImage,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 16.0),
                                      child: Icon(
                                        Icons.info,
                                        size: 50,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            fit: BoxFit.cover,
                            image: screenState.fileString != null
                                ? (kIsWeb
                                    ? Image.network(Urls.IMAGES_ROOT + (profileModel?.image ?? ''))
                                        .image
                                    : Image.file(File(screenState.fileString!))
                                        .image)
                                : NetworkImage(image),
                            width: 150,
                            height: 150,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Opacity(
                              opacity: 0.9,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Theme.of(context).primaryColor),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.add_a_photo_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Form(
              key: _personal_data,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, left: 16),
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          S.of(context).name,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      subtitle: CustomFormField(
                        controller: nameController,
                        contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        preIcon: const Icon(Icons.person),
                        hintText: S.of(context).nameHint,
                      ),
                    ),
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          S.of(context).address,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      subtitle: CustomFormField(
                        controller: locationController,
                        contentPadding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
                        preIcon: const Icon(Icons.location_on_rounded),
                        hintText: S.of(context).myAddressHint,
                        last: true,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ListTile(
                          trailing: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          leading: const Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ),
                          title: Text(
                            S.current.favoriteCategories,
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return getIt<FavouritScreen>();
                                });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: UpdateButton(onPressed: () {
              if (_personal_data.currentState!.validate()) {
                request = ProfileRequest(
                    clientName: nameController.text.trim(),
                    location: locationController.text.trim(),
                    image: profileModel!.image);
                screenState.postClientProfile(request);
              }
            })),
      ],
    );
  }
}
