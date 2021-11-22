import 'package:flutter/material.dart';
import 'package:mandob_moshtarayat_dashboad/utils/components/progresive_image.dart';

class ProductCard extends StatelessWidget {
  final String productName;
  final String productImage;
  final Widget dialog;

  ProductCard(
      {required this.productName,
      required this.productImage,
      required this.dialog});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: () {
          //   Navigator.of(screenState.context).pushNamed(StoresRoutes.STORES,arguments: element.id.toString());
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: SizedBox(
                    height: 75,
                    width: 75,
                    child: CustomNetworkImage(
                      imageSource: productImage,
                      width: 75,
                      height: 75,
                    ),
                  ),
                ),
              ),
              Text(
                productName,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              InkWell(
                customBorder: CircleBorder(),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return dialog;
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).backgroundColor.withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
