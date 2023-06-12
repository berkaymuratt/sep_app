import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sep_app/app/pages/fqa_page/faq_page_view_model.dart';
import 'package:sep_app/app/shared/sep_app_scaffold/sep_app_scaffold.dart';
import 'package:sep_app/models/faq_question_model.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({Key? key}) : super(key: key);

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  void initState() {
    super.initState();
    context.read<FaqPageViewModel>().loadFaqQuestions();
  }

  @override
  Widget build(BuildContext context) {
    final questions = context.watch<FaqPageViewModel>().questions;

    return SepAppScaffold(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: ExpansionPanelList(
              elevation: 1,
              expandedHeaderPadding: EdgeInsets.all(0),
              dividerColor: Colors.grey,
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  questions[index].isExpanded = !isExpanded;
                });
              },
              children: questions.map<ExpansionPanel>((FaqQuestionModel faqQuestion) {
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(
                        faqQuestion.question,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                      ),
                    );
                  },
                  body: ListTile(
                    title: Text(
                      faqQuestion.answer,
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                  isExpanded: faqQuestion.isExpanded,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
