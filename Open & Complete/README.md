# Open & Complete

This script is old and has changed greatly. It was once a very specialized script for just myself, but I've made it a general opener and exteneded it after seeing "Go to Link" from somewhere.

You can use a URL, `Script: {sh,ruby,pl} /path/to/some/script`, a rich text link, a file attachment, `App: App Name`, `Command: some arbitrary shell command`  `Alert: Some alert text`, and `Notify: Some Notification`.

Be advised, you must have tasks selected and you'll have to make sure spaces and the like are escaped like so for the `Command:` directive: `cat /some/file/with/spaces in the name.txt`

## Examples

```
App: Terminal
Notify: This is a notification.
Alert: I'm alerting you about something.
Script: osascript ~/Library/Scripts/Applications/OmniFocus/Verify Next Actions Exist.scpt
Script: ruby ~/Library/Scripts/open_torrent_urls.rb
Command: echo $(date) > ~/Desktop/this\ is\ the\ date.txt
http://google.com
omnifocus:///task/ljalksdfjoiaj
```
