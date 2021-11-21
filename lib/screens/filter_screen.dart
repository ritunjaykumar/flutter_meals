import 'package:flutter/material.dart';
import 'package:flutter_meals/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const Route = "/filter";
  final Function saveFilters;
  final Map<String, bool> _currentFilter;

  FiltersScreen(this._currentFilter, this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget._currentFilter['gluten'];
    _vegetarian = widget._currentFilter['vegetarian'];
    _vegan = widget._currentFilter['vegan'];
    _lactoseFree = widget._currentFilter['lactose'];
    super.initState();
  }

  Widget _builderSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Filters"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                };
                widget.saveFilters(selectedFilters);
              },
            )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Adjust your meal selection.",
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _builderSwitchListTile(
                    "Gluten-free",
                    "Only include gluten-free meals",
                    _glutenFree,
                    (newValue) {
                      setState(() {
                        _glutenFree = newValue;
                      });
                    },
                  ),
                  _builderSwitchListTile(
                    "Lactose-free",
                    "Only include lactose-free meals.",
                    _lactoseFree,
                    (newValue) {
                      setState(() {
                        _lactoseFree = newValue;
                      });
                    },
                  ),
                  _builderSwitchListTile(
                    "Vegetarian",
                    "Only include vegetarian meals.",
                    _vegetarian, //enable or disable switch
                    (newValue) {
                      setState(() {
                        _vegetarian = newValue;
                      });
                    },
                  ),
                  _builderSwitchListTile(
                    "Vegan",
                    "Only include vegan meals.",
                    _vegan, //enable or disable switch
                    (newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
