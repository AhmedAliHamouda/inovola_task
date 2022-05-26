import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inovola_task/ui/widgets/custom_slider.dart';
import 'package:inovola_task/ui/widgets/custom_text.dart';
import 'package:inovola_task/utils/colors_utils.dart';
import 'package:inovola_task/viewModels/data_riverpod.dart';
import 'package:inovola_task/viewModels/global_riverpod_container.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () async {
      await providerContainer.read(dataRiverPod).getData();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, ref, child) {
            final dataProv = ref.watch(dataRiverPod);
            return dataProv.loading
                ? SizedBox(
              height: MediaQuery.of(context).size.height,
                  child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                )
                : dataProv.responseModel == null
                    ? const Center(
                        child: Text('يوجد خطا ما'),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           CustomImagesSlider(images: dataProv.responseModel!.img!),
                          const SizedBox(
                            height: 5.0,
                          ),

                          /// info
                           Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: CustomText(
                              text: '# ${dataProv.responseModel?.interest}',
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              color: ColorsUtils.lightTextColor,
                            ),
                          ),
                           Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: CustomText(
                              text: dataProv.responseModel?.title??'',
                              fontSize: 21.0,
                              fontWeight: FontWeight.w700,
                              color: ColorsUtils.darkTextColor,
                            ),
                          ),
                          _customRow('assets/images/Date Icon.png',_getConvertDateTime( dataProv.responseModel?.date!)),
                          _customRow('assets/images/Address Icon.png', dataProv.responseModel?.address??''),
                          const Divider(
                            color: ColorsUtils.lineColor,
                            thickness: 2.0,
                          ),

                          /// trainer data
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 50.0,
                                  width: 50.0,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(42),
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/images/place_holder_image.png',
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                      image:dataProv.responseModel?.trainerImg??'',
                                      imageErrorBuilder: (c, o, s) => Image.asset(
                                          'assets/images/place_holder_image.png',
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                 CustomText(
                                  text: dataProv.responseModel!.trainerName!,
                                  fontSize: 21.0,
                                  fontWeight: FontWeight.w700,
                                  color: ColorsUtils.lightTextColor,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          ),
                           Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: CustomText(
                              text:
                              dataProv.responseModel!.trainerInfo!,
                              fontSize: 21.0,
                              fontWeight: FontWeight.w600,
                              color: ColorsUtils.darkTextColor,
                            ),
                          ),
                          const Divider(
                            color: ColorsUtils.lineColor,
                            thickness: 2.0,
                          ),

                          /// about
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: CustomText(
                              text: 'عن الدوره',
                              fontSize: 21.0,
                              fontWeight: FontWeight.w700,
                              color: ColorsUtils.lightTextColor,
                            ),
                          ),
                           Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: CustomText(
                              text:
                              dataProv.responseModel!.occasionDetail!,
                              fontSize: 21.0,
                              fontWeight: FontWeight.w600,
                              color: ColorsUtils.darkTextColor,
                            ),
                          ),
                          const Divider(
                            color: ColorsUtils.lineColor,
                            thickness: 2.0,
                          ),

                          /// price
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            child: CustomText(
                              text: 'تكلفة الدورة',
                              fontSize: 21.0,
                              fontWeight: FontWeight.w700,
                              color: ColorsUtils.lightTextColor,
                            ),
                          ),
                          _customRowText('العادى', dataProv.responseModel!.price.toString()),
                          _customRowText('المميز', dataProv.responseModel!.price.toString()),
                          _customRowText('السريع', dataProv.responseModel!.price.toString()),
                          const SizedBox(
                            height: 10.0,
                          ),
                        ],
                      );
          },
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: Consumer(
          builder: (context, ref, child) {
            final dataProv=ref.watch(dataRiverPod);
            return dataProv.loading?Container(): Container(
              color: ColorsUtils.buttonColor,
              height: 60,
              child: const Center(
                child: CustomText(
                  text: 'قم بالحجز الان',
                  fontSize: 21.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            );
          },

        ),
      ),
    );
  }

  Widget _customRow(String iconName, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: [
          Image.asset(
            iconName,
            width: 20.0,
            height: 20.0,
          ),
          const SizedBox(
            width: 15,
          ),
          CustomText(
            text: text,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: ColorsUtils.lightTextColor,
          ),
        ],
      ),
    );
  }

  Widget _customRowText(String textName, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: textName,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: ColorsUtils.lightTextColor,
          ),
          CustomText(
            text: price + ' SAR',
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: ColorsUtils.lightTextColor,
          ),
        ],
      ),
    );
  }

  String _getConvertDateTime(String? dateTime){
    DateTime parseDate =
    DateFormat("yyyy-MM-dd'T'HH:mm:ss",'en').parse(dateTime!);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('yyyy/dd/MM  hh:mm a');
    //var outputFormat = DateFormat('a hh:mm yyyy/dd/MM');
    var outputDate = outputFormat.format(inputDate);
    return outputDate;
  }
}
