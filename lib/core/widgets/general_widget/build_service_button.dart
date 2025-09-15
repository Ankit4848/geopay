import 'package:bounce/bounce.dart';
import 'package:fintech/core/core.dart';
import 'package:fintech/features/home/model/home_model.dart';
import 'package:flutter/material.dart';

class BuildServiceButton extends StatelessWidget {
  final List<ServiceModel> serviceModel;
  const BuildServiceButton({super.key, required this.serviceModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        serviceModel.length,
        (index) {
          return Expanded(
            child: Bounce(
              onTap: serviceModel[index].onTap,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(
                        serviceModel[index].title == "Add Money" ? 0 : 12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == 0 ? const Color(0xFF27435B) : null,
                      border: index == 0
                          ? null
                          : Border.all(
                              color: const Color(0xFF27435B),
                            ),
                    ),
                    child: Center(
                      child: Image.asset(
                        serviceModel[index].gifPath,
                        height:
                            serviceModel[index].title == "Add Money" ? 55 : 30,
                        width:
                            serviceModel[index].title == "Add Money" ? 55 : 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    serviceModel[index].title,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    style: FontUtilities.style(
                        fontSize: 14,
                        fontFamily: FontFamily.dmSans,
                        fontColor: VariableUtilities.theme.whiteColor,
                        fontWeight: FWT.bold),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
