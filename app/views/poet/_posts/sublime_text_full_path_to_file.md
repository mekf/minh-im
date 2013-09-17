{{{
    "title"    : "Sublime Text Shows Full Path To File",
    "tags"     : [ "sublime text", "JSON", "OSX", "tips n' tricks" ],
    "category" : "development",
    "date"     : "9-18-2013"

}}}

Sublime Text is my editor of choice due to its snappiness and versatility. The Linux edition shows full path to a certain file on its menu bar automatically however the OSX version only shows the name of the current file. It was alright at first until I started working on a huge app that have similar files in different namespaces (eg: app/controllers/ and app/controllers/admin/). It's actually pretty simple to enable this feature in Sublime.

Go to **Preferences – Settings – User** and then add this line:

`"show_full_path": true`

Restart and you are done. The title bar is now showing the full path to a certain file. This trick works in both Sublime Text 2 and 3.

<!--more-->

#### References
* [http://treyconnell.com/2013/02/show-file-path-in-sublime-text-2/](http://treyconnell.com/2013/02/show-file-path-in-sublime-text-2/)