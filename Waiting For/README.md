# Waiting For…

These scripts help you deal with Waiting For tasks. Convert to Waiting.scpt will convert tasks that look like "Call Bob" or "Email Bob" and when you pass a number of days (from now) or the English name of a weekday and turn "Call Bob" into "(2016-11-14 → CALL) Waiting for response from Bob" (if today was 2016-11-11 and you passed "3" to the script.) Process Waiting Scripts.scpt will look through all your `^Wait.*` context tasks and change the name and context back to their original form. If it's 2016-11-11 and you have a task named "(2016-11-11 → EMAIL) Waiting for response from Sally", the script will change the name back to "Email Sally" and change the context to "Emails". This script is best run automatically in the wee hours of the morning so that your waiting tasks automatically become actionable again.

**You will need my datetime and utils AppleScript libraries.**

## Usage

If you're using LaunchBar, there's a handle_string handler to use, or if not, there's a display dialog that pops up when executed.

## Contribute

PRs accepted.

## License

MIT © Richard McRichface
