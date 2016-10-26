I wrote another cool little tool using my AppleScript library. It's called [Considered](https://github.com/brandonpittman/OmniFocus). It also handles things having to do with colons and prefixes, but specifically the **Consider:** prefix. If you're unfamiliar with considered tasks, read all about them [here](http://www.usingomnifocus.com/2014/01/the-considered-task/). Instead of trying to set task names to something like "Consider reviewing" with the **ing**, I opted for Kourosh Dini's prefix-style considered tasks where you just add **Consider:** as a prefix. It's simpler and easier to script. Here's the code (using my OmniFocus library, of course.)

It's a pretty nifty script that will toggle consider prefixes on and off. It's set up to accept an argument with LaunchBar (either "set" or "clear") to flip the considered switch one way or the other no matter what the current state.

## Finished Considered Task

There’s one other script in here that will let you clearConsider(selectedItems()) and then setComplete(selectedItems(), true) in one go. Kinda handy when you finish a book, TV series or video game.