import 'package:flutter/material.dart';
import 'package:ftp_app/api_service.dart';
import 'package:ftp_app/global.dart';
import 'package:ftp_app/model/data_model.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatelessWidget {
  final String endPoint = "9443/api/Home/DemoApi/GetCustomer/";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: Container(),
        elevation: 0.0,
        title: Text("Profile"),
      ),
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: FutureBuilder<DataModel>(
            future: ApiService.getMethod(endPoint),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                print("Data get");
                return mainData(snapshot.data);
              }
              return mainData(null);
            },
          ),
        ),
      ),
    );
  }

  Widget mainData(DataModel dataModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        field(
            "Name",
            dataModel == null
                ? null
                : dataModel.firstName + dataModel.lastName),
        field("Mobile NO", dataModel == null? null:dataModel?.phone??""),
        field("Email", dataModel?.emailAddress),
        field("Address", dataModel?.address),
        field("City", dataModel?.city),
        field("Country", dataModel?.country),
        field("Postal Code",
            dataModel == null ? null : dataModel?.postCode.toString()),
        field("Date Of Birth", dataModel?.dateOfBirth),
        field("Gender", dataModel?.gender),
        button(dataModel),
      ],
    );
  }

  Widget field(String title, String data) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              child: Text(title)),
          data == null
              ? Shimmer.fromColors(
                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  enabled: data == null,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        color: Color(0xfffcfcfd),
                        borderRadius: BorderRadius.circular(5),
                        border:
                            Border.all(color: Color(0xffeef1f5), width: 1.5)),
                  ),
                )
              : Container(
                  height: 50,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Color(0xfffcfcfd),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(0xffeef1f5), width: 1.5)),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(data ?? ""),
                      )),
                ),
        ],
      ),
    );
  }

  Widget button(DataModel data) {
    return data == null
        ? Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: data == null,
            child: Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
              width: double.infinity,
              height: 50,
            ),
          )
        : Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),
            width: double.infinity,
            height: 50,
            child: RaisedButton(
              onPressed: data == null
                  ? null
                  : () {
                      launch(
                          "tsr://tsr.com/?address=${data.address}&city=${data.city}&country=${data.country}&postalCode=${data.postCode}&id=${endPoint.split('/').first}");
                    },
              color: primaryColor,
              child: Center(
                child: Text(
                  "Direction",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          );
  }
}
