import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

void main() => runApp(FloatingSample());
List<String> _options = ['エステ', 'リラクゼーション', '整骨・整体', 'フィットネス'];
int _selectedIndex;

class FloatingSample extends StatelessWidget {
  FloatingSample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Floating App Bar';

    return MaterialApp(
      title: title,
      home: Scaffold(
        // No appbar provided to the Scaffold, only a body with a
        // CustomScrollView.
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
          centerTitle: true,
          title: Text(
            '近くのセラピスト＆お店',
            style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        body: LazyLoadScrollView(
          //isLoading: isLoading,
          onEndOfPage: () => _getMoreData(),
          child: CustomScrollView(
            slivers: <Widget>[
              // Add the app bar to the CustomScrollView.
              SliverAppBar(
                // Provide a standard title.
                elevation: 0.0,
                backgroundColor: Colors.white,
                // Allows the user to reveal the app bar if they begin scrolling
                // back up the list of items.
                floating: true,
                flexibleSpace: Container(
                  height: MediaQuery.of(context).size.height * 0.083,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black26,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  child: Center(child: MassageTypeChips()),
                ),
                // Display a placeholder widget to visualize the shrinking size.
                // Make the initial height of the SliverAppBar larger than normal.
                actions: <Widget>[],
              ),
              // Next, create a SliverList
              SliverList(
                // Use a delegate to build items as they're scrolled on screen.
                delegate: SliverChildBuilderDelegate(
                  // The builder function returns a ListTile with a title that
                  // displays the index of the current item.
                  (context, index) => ListTile(title: Text('Item #$index')),
                  // Builds 1000 ListTiles
                  childCount: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getMoreData() async {
    print('More data lazy load...!!!');
  }
}

class MassageTypeChips extends StatefulWidget {
  @override
  _MassageTypeChipsState createState() => _MassageTypeChipsState();
}

class _MassageTypeChipsState extends State<MassageTypeChips>
    with TickerProviderStateMixin {
  //TherapistTypeBloc therapistTypeBloc;
  var _pageNumber = 1;
  var _pageSize = 10;

  @override
  void initState() {
    super.initState();
    //therapistTypeBloc = BlocProvider.of<TherapistTypeBloc>(context);
  }

  Widget _buildChips() {
    List<Widget> chips = new List();

    for (int i = 0; i < _options.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        selected: _selectedIndex == i,
        label: Text(_options[i],
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
            )),
        backgroundColor: Colors.white70,
        selectedColor: Colors.lime,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedIndex = i;
            }
          });
        },
      );

      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 2), child: choiceChip));
    }

    return ListView(
      physics: BouncingScrollPhysics(),
      // This next line does the trick.

      scrollDirection: Axis.horizontal,

      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.04,
                child: _buildChips(),
              ),
            ],
          )),
    );
  }
}
