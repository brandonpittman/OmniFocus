// Here are some examples of using Javascript for Automation with OmniFocus
 
// Create an inbox task
//
// Here, we call inboxTasks without parens because we want it as a function to call later
of = Application('OmniFocus')
inbox = of.defaultDocument.inboxTasks
task = of.InboxTask({name: "testing"})
inbox.push(task)
 
// Delete every inbox task
//
// Here, we call inboxTasks() with parens so that it returns an array
inbox = of.defaultDocument.inboxTasks()
// Since `delete` is an AppleScript method, not a standard JavaScript method
// we need to call `of.delete`.
inbox.forEach(of.delete)
 
/*
The important thing to remember about working with objects when using
JavaScript for Automation is to remember that AppleScript objects need
to be prefaced with the application object first.
*/
