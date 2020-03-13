import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:links_landing_page/models/links.dart';
import 'package:links_landing_page/settings/add_button.dart';
import 'package:links_landing_page/settings/delete_button.dart';
import 'package:links_landing_page/settings/edit_button.dart';
import 'package:provider/provider.dart';

class ButtonSettings extends StatelessWidget {
  const ButtonSettings({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userLinks = Provider.of<List<Link>>(context);

    return ChangeNotifierProxyProvider<List<Link>, LinksList>(
      create: (_) => LinksList(),
      update: (_, __, linksListNotifier) =>
          linksListNotifier..update(userLinks),
      child: Expanded(
        flex: 3,
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            color: Colors.blueGrey.shade50,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0, bottom: 100),
                  child: Text(
                    'Your Links',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                AddButton(width: constraints.maxWidth * 0.6),
                SizedBox(height: 30),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: constraints.maxHeight * 0.4,
                    maxWidth: constraints.maxWidth * 0.6,
                  ),
                  child: Consumer<LinksList>(
                    builder: (_, linkListNotifier, ___) => ReorderableListView(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      onReorder: linkListNotifier.onReorder,
                      children: [
                        for (var data in linkListNotifier.currentLinkList)
                          ListTile(
                            key: Key(data.title),
                            title: Text(data.title),
                            leading: Icon(Icons.drag_handle),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                EditButton(data: data),
                                DeleteButton(data: data),
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LinksList extends ChangeNotifier {
  List<Link> _workingList;

  update(List<Link> _userLinks) => _workingList = _userLinks;

  List<Link> get currentLinkList => _workingList;

  void onReorder(int oldIndex, int newIndex) {
    debugPrint(_workingList.elementAt(oldIndex).title);
    debugPrint('oldIndex $oldIndex');
    if (newIndex > oldIndex) newIndex -= 1;
    debugPrint('newIndex $newIndex');
    final pickedLink = _workingList.removeAt(oldIndex);
    _workingList.insert(newIndex, pickedLink);
    notifyListeners();

    final batch = Firestore.instance.batch();

    for (var index = 0; index < _workingList.length; index++) {
      final currentLink = _workingList[index];
      batch.updateData(currentLink.documentReference, {'position': index});
    }

    batch.commit();
  }
}
