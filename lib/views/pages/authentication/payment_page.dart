import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_online/controllers/payment_controller.dart';
import 'package:quran_online/utils/custom_image_picker.dart';
import 'package:quran_online/views/widgets/background_widget.dart';
import 'package:quran_online/views/widgets/custom_button.dart';
import 'package:quran_online/views/widgets/custom_image_viewer.dart';
import 'package:quran_online/views/widgets/custom_text_form_field.dart';


class PaymentPage extends StatelessWidget {
  PaymentPage({Key? key}) : super(key: key);

  final PaymentController _paymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'التسجيل',
          style: TextStyle(fontFamily: 'cairo'),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const Center(
              child: BackgroundWidget(
            imagePath: 'assets/images/background_1.png',
            opacity: 0.5,
          )),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: GetBuilder<PaymentController>(
                    builder: (imageController) {
                      return Form(
                        key: _paymentController.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextFormField(
                                enabled: true,
                                controller: _paymentController.firstNameController,
                                maxLength: 15,
                                keyboardType: TextInputType.text,
                                obscureText: false,
                                labelText: 'اللقب',
                                color: Theme.of(context).primaryColor,
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return 'يرجى إضافة لقب صحيح';
                                  }
                                  return null;
                                }),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextFormField(
                                enabled: true,
                                controller: _paymentController.lastNameController,
                                maxLength: 15,
                                keyboardType: TextInputType.text,
                                obscureText: false,
                                labelText: 'الإسم',
                                color: Theme.of(context).primaryColor,
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return 'يرجى إضافة إسم صحيح';
                                  }
                                  return null;
                                }),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextFormField(
                                enabled: true,
                                controller: _paymentController.emailController,
                                maxLength: 30,
                                keyboardType: TextInputType.emailAddress,
                                obscureText: false,
                                labelText: 'البريد الإلكتروني',
                                color: Theme.of(context).primaryColor,
                                validator: (value) {
                                  if(value!.isEmpty){
                                    return 'يرجى إضافة بريد إلكتروني صحيح';
                                  }
                                  return null;
                                }),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomTextFormField(
                                enabled: true,
                                controller: _paymentController.mobileController,
                                maxLength: 10,
                                keyboardType: TextInputType.phone,
                                obscureText: false,
                                labelText: 'رقم الهاتف',
                                color: Theme.of(context).primaryColor,
                                validator: (value) {
                                  if(value!.isEmpty || value.length < 9 || !(value.startsWith(0.toString()))){
                                    return 'يرجى إضافة رقم هاتف صحيح';
                                  }
                                  return null;
                                }),
                            const SizedBox(
                              height: 8,
                            ),

                            Expanded(child: GetBuilder<PaymentController>(
                              builder: (paymentController) => GestureDetector(onTap: (){
                                Get.bottomSheet(
                                  Container(
                                    padding: const EdgeInsets.only(left: 8 , right: 8),
                                      height: 120,
                                      color: Colors.white,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          CustomButton(
                                              onPressed: () {
                                                Get.close(0);
                                                CustomImagePicker
                                                    .getImageFromCamera()
                                                    .then((result) =>
                                                paymentController.path = result.path);
                                              },
                                              text: 'صورة من الكاميرا',
                                              color:
                                              Theme.of(context).primaryColor),
                                          CustomButton(
                                              onPressed: () {
                                                Get.close(0);
                                                CustomImagePicker
                                                    .getImageFromDevice()
                                                    .then((result) =>
                                                paymentController.path = result.path);
                                              },
                                              text: 'صورة من الهاتف',
                                              color: Theme.of(context).primaryColor)
                                        ],
                                      )),
                                  barrierColor:
                                  Colors.grey.shade900.withOpacity(0.5),
                                  isDismissible: true,
                                );
                              },child: CustomImageViewer(imagePath: paymentController.path,),),
                            )),
                            const SizedBox(
                              height: 16,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                CustomButton(
                    onPressed: () {
                      _paymentController.makePayment(context);
                    },
                    text: 'التسجيل',
                    color: Theme.of(context).primaryColor)
              ],
            ),
          ),
        ],
      ),
    );
  }

}
