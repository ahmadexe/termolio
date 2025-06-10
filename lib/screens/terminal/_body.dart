part of 'terminal.dart';

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final screenState = _ScreenState.s(context, true);
    final history = screenState.history;
    return Screen(
      padding: Space.sym(2.un(), 2.un()),
      child: ListView.builder(
        controller: screenState.scrollController,
        itemCount: history.length + 1,
        itemBuilder: (context, index) {
          if (index < history.length) {
            final command = history[index];
            return Text(
              command,
              style: AppText.s1.copyWith(fontWeight: FontWeight.bold),
            );
          } else {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'termolio@ahmad ',
                  style: AppText.s1.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${screenState.currentPath} % ',
                  style: AppText.s1.copyWith(fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: TextField(
                    controller: screenState.controller,
                    autofocus: true,
                    style: AppText.s1.copyWith(fontWeight: FontWeight.bold),
                    cursorColor: AppTheme.primary,
                    textInputAction: TextInputAction.done,
                    onSubmitted: screenState.processCommand,
                    decoration: InputDecoration.collapsed(hintText: ''),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
