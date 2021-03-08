import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProviderTermsAndConditions extends StatefulWidget {
  @override
  _ProviderTermsAndConditionsState createState() =>
      _ProviderTermsAndConditionsState();
}

class _ProviderTermsAndConditionsState
    extends State<ProviderTermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          '利用規約とプライバシーポリシー',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          padding:
              EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0, right: 0.0),
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        child: FutureBuilder(
            future: rootBundle
                .loadString("assets/privacy_policy/service_provider.md"),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Markdown(
                    data: snapshot.data,
                    styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                        .copyWith(
                            p: Theme.of(context).textTheme.bodyText1.copyWith(
                                fontSize: 14.0, fontFamily: 'NotoSansJP')));
              }
              return Center(
                child: SpinKitDoubleBounce(color: Colors.limeAccent),
              );
            }),
      ),
    );
  }
}
