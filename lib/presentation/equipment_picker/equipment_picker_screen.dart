import 'package:equipment_picker/presentation/components/custom_widgets.dart';
import 'package:equipment_picker/constants/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'equipment_picker_cubit.dart';

class EquipmentPickerScreen extends StatefulWidget {
  const EquipmentPickerScreen({super.key});

  @override
  State<EquipmentPickerScreen> createState() => _EquipmentPickerScreenState();
}

class _EquipmentPickerScreenState extends State<EquipmentPickerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    context.read<EquipmentPickerCubit>().getData();
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: bgColor,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<EquipmentPickerCubit, EquipmentPickerState>(
                builder: (context, state) {
              return state.when(
                initial: () => Container(
                  color: darkColor,
                  child: CircularProgressIndicator(color: lightColor),
                ),
                loading: () => Container(
                  color: darkColor,
                  child: CircularProgressIndicator(color: lightColor),
                ),
                success: (equipmentList, isCircularProgressIndicator) {
                  if (context.read<EquipmentPickerCubit>().isCircularProgressIndicator == true) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CircularProgressIndicator(color: lightColor),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomButton(title: "Hide Loading Indicator", onTap: ()=>context.read<EquipmentPickerCubit>().showCircularProgressIndicator(),),
                        const SizedBox(height: 10),
                        CustomButton(title: 'Show Snack Bar', onTap: () => context.read<EquipmentPickerCubit>().showSnackBar(context),),
                      ],
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Wrap(
                            children: context.read<EquipmentPickerCubit>().equipmentList.map((equipment) {
                              return CustomCards(
                                title: equipment.equipmentName,
                                isPicked: equipment.isPicked,
                                imageUrl: equipment.imageUrl,
                                onTap: () {
                                  context.read<EquipmentPickerCubit>().pickEquipment(context,equipment.id);
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 20),
                          CustomButton(title: "Show Loading Indicator", onTap: ()=>context.read<EquipmentPickerCubit>().showCircularProgressIndicator(),),
                          const SizedBox(height: 10),
                          CustomButton(title: 'Show Snack Bar', onTap: () => context.read<EquipmentPickerCubit>().showSnackBar(context),),
                        ],
                      ),
                    );
                  }
                },
                failure: (error){
                  if (kDebugMode) print(error);
                  return Container(
                  color: darkColor,
                  child: CircularProgressIndicator(color:redColor),
                );},
              );
            }),
          ],
        ),
      ),
      ),
    );
  }
}
