/**
 *
 * @file OmniFocusLibrary.js
 * @author Brandon Pittman
 */

/**
 * the OmniFocus application object
 *
 * @namespace
 * @property {boolean} includeStandardAdditions - if the app object can use the Standard Additions
 */
var app = Application('OmniFocus');
app.includeStandardAdditions = true;
var current = Application.currentApplication();
current.includeStandardAdditions = true;

/**
 * the default document
 *
 * @namespace
 */
var doc = app.defaultDocument;

/**
 * Returns selected tasks
 *
 *  @global
 *  @method selected
 *  @return {Array} Array of selected tasks
 */
function selected() {
	return app.windows[0].content.selectedTrees;
}

/**
 *
 * @method allTasks
 * @return {Array} Array of every task in the default document
 */
function allTasks() {
	return doc.flattenedTasks.whose({completed: false})();
}

/**
 *
 * @method allProjects
 * @return {Array} Array of every project in the default document
 */
function allProjects() {
	return doc.flattenedProjects.whose({completed: false})();
}

/**
 * @method tasksWithContext
 * @param {string} context Context name to search for
 * @param {array} [inputTasks=allTasks()] Array of tasks to search through
 * @return {array} Array of tasks that belong to contexts matching `context`
 */
function tasksWithContext(context, inputTasks) {
	var tasks = [];
	var tasksToProcess = inputTasks ? inputTasks : allTasks();
	tasksToProcess.forEach(function(task, index) {
		if (task.context() !== null) {
			if (searchString(context).test(task.context().name())) {
				tasks.push(task);
			}
		}
	});
	return tasks;
}

/**
*
* @method projectsWithName
* @param {string} name Name of projects to search
* @param {array} [inputProjects=allProjects()] Array of projects to search
* @return {array} Array of matching projects
*
*/
function projectsWithName(name, inputProjects) {
	var projects = [];
	var projectsToProcess = inputProjects ? inputProjects : allProjects();
	projectsToProcess.forEach(function(project, index) {
		if (project.container() !== null) {
			if (searchString(name).test(project.name())) {
				projects.push(project);
			}
		}
	});
	return projects;
}

/**
*
* @method tasksWithName
* @param {string} name name of tasks to search for
* @param {array} [inputTasks=allTasks()] tasks to search
* @return {array} Matched tasks
*
*/
function tasksWithName(name, inputTasks) {
	var tasks = [];
	var tasksToProcess = inputTasks ? inputTasks : allTasks();
	tasksToProcess.forEach(function(task, index) {
		if (searchString(name).test(task.name())) {
			tasks.push(task);
		}
	});
	return tasks;
}

/**
*
* @method allWithName
* @param {string} searchTerm Term to search for
* @return {array} Matching tasks
*
*/
function allWithName(searchTerm) {
	var tasks = tasksWithName(searchTerm).concat(tasksWithContext(searchTerm)).concat(projectsWithName(searchTerm));
	return tasks;
}

/**
*
* @method setDefer
* @param {array} tasks Tasks to defer
* @param {object} date Date to defer tasks to
*
*/
function setDefer(tasks, date) {
	tasks.forEach(function (task) {
		date.getHours() === 0 ? date.setHours(8) : date
		task.deferDate = date;
	});
}

/**
*
* @method setDue
* @param {array} tasks Tasks to make due
* @param {object} date Date to make tasks due on
*
*/
function setDue(tasks, date) {
	tasks.forEach(function (task) {
		date.getHours() === 0 ? date.setHours(4) : date
		task.dueDate = date;
	});
}

/**
*
* @method setContext
* @param {array} tasks Tasks to set context for
* @param {(string|function)} context Context to set tasks to
*   `context` can be a string of a context you know exists, provide your own context
*   or you can use the `getContext` function to grab a context
*
*/
function setContext(tasks, context) {
  var newContext = typeof context === 'string' ? getContext(context) : context;
	tasks.forEach(function(task) {
		task.context = newContext;
	});
}

/**
*
* @method getContext
* @param {string} context Context name to search for
* @return {function} Context object
*
*/
function getContext(context) {
	return doc.flattenedContexts.whose({name: context})[0];
}

/**
*
* @method getProject
* @param {string} project Project name to search for
* @return {function} Project object
*
*/
function getProject(project) {
	return doc.flattenedProjects.whose({name: project})[0];
}

/**
*
* @method setProject
* @param {array} tasks Tasks to set project for
* @param {(string|function)} project Project to set tasks to
*   `project` can be a string of a context you know exists, provide your own project
*   or you can use the `getProject` function to grab a project
*
*/
function setProject(tasks, project) {
  var newProject = typeof project === 'string' ? getProject(project) : project;
    tasks.forEach(function(task) {
        task.assignedContainer = newProject;
    });
}

/**
*
* @method inboxTasks
* @return {array} All inbox tasks
*
*/
function inboxTasks() {
	return doc.inboxTasks();
}

/**
*
* @method makeTask
* @param {string} name Name of new task
* @param {string|function} context Context of new task
* @param {object} [deferDate] Defer date of new task
* @param {object} [dueDate] Due date of new task
* @param {string|function} [project] Project to add task to
*
*/
function makeTask(text, context, deferDate, dueDate, project) {
  var taskProject = typeof project === 'string' ? getProject(project) : project;
	var taskObject = app.Task({name: text, context: context || null, deferDate: deferDate || null, dueDate: dueDate || null});
	if (project)  {
    taskProject.tasks.push(taskObject);
  } else {
    doc.inboxTasks.push(taskObject);
  }
}

/**
*
* @method updateInboxTasks
* @param {string} context Context of new task
* @param {string} project Name of project for new task
* @param {object} [deferDate] Defer date of new task
* @param {object} [dueDate] Due date of new task
* @return {object} New task object
*
*/
function updateInboxTasks(context, project, deferDate, dueDate) {
	var newContext = getContext(context);
	var newProject = getProject(project);
	inboxTasks().forEach(function(task) {
		task.context = newContext;
		task.deferDate = deferDate || null;
		task.dueDate = dueDate || null;
		pushTask(task, newProject);
	});
}

/**
*
* @method prefixTasksWith
* @param {array} tasks Tasks to modify
* @param {string} text Text to prefix with
*
*/
function prefixTasksWith(tasks,text) {
	tasks.forEach(function(task) {
		task.name = text + ' ' + task.name();
	});
}

/**
 * the term to be searched for
 *
 * @method searchString
 * @param {String} term
 * @return {RegExp} RexExp object
 */
function searchString(term) {
	return new RegExp(term, 'i');
}

/**
* The parse will create a new task but unlike the newTask() method, parse()
* immediately creates the task in the default document.
*
* @method parse
* @param {string} string - String to parse as task
* @return {object} OmniFocus task object
* @example
* of.parse('Do something! @home ::misc #4pm #tomorrow')
*/
function parse(string) {
	app.parseTasksInto(doc, {withTransportText: string});
}

/**
*
* Log names of tasks to the console
*
* @method logName
* @param {array} tasks - An array of OmniFocus tasks
*
*/
function logName(tasks) {
  tasks.forEach(function(task) {
    console.log(task.name());
  });
}

/**
*
* Log contexts of tasks to the console
*
* @method logContext
* @param {array} tasks - An array of OmniFocus tasks
*
*/
function logContext(tasks) {
  tasks.forEach(function(task) {
    console.log(task.context());
  });
}

/**
*
* Log projects of tasks to the console
*
* @method logProject
* @param {array} tasks - An array of OmniFocus tasks
*
*/
function logProject(tasks) {
  tasks.forEach(function(task) {
    console.log(task.project());
  });
}

/**
*
* @method makeProject
* @param {string} projectName Name of new task
* @param {string|function} [context] Context of new task
* @param {object} [deferDate] Defer date of new task
* @param {object} [dueDate] Due date of new task
* @param {object|function} [folder] Folder to add project to
*
*/
function makeProject(projectName, context, deferDate, dueDate, folder) {
	var projectFolder = typeof folder === 'string' ? getFolder(folder) : folder;
	var projectContext = typeof context === 'string' ? getContext(context) : context;
	var projectObject = app.Project({name: projectName, context: projectContext || null, deferDate: deferDate || null, dueDate: dueDate || null});
	if (folder) {
    projectFolder.projects.push(projectObject);
  } else {
    doc.projects.push(projectObject);
  }
}

/**
*
* @method makeFolder
* @param {string} folderName Name of new folder
* @param {object|function} [folderToNestIn] Folder to add folder to
*
*/
function makeFolder(folderName, folderToNestIn) {
	var containingFolder = typeof folderToNestIn === 'string' ? getFolder(folderToNestIn) : folderToNestIn;
	var folderObject = app.Folder({name: folderName});
	if (folderToNestIn) {
    containingFolder.folders.push(folderObject);
  } else {
    doc.folders.push(folderObject);
  }
}

/**
*
* @method getFolder
* @param {string} folderName - Name of folder to get
* @return {function} First folder whose name matches `folderName`
*
*/
function getFolder(folderName) {
	return doc.flattenedFolders.whose({name: folderName})[0];
}

/**
*
* @method listTitles
* @param {array} list - List of tasks to pull titles from
* @return {string} Concatenated list of titles
*
*/
function listTitles(list) {
  var text = '';
  list.forEach(function(task) {
    text += task.name() + '\n';
  });
  return text;
}

/**
*
* @method copy
* @param {string} text - Text to copy to clipboard
* @return {null}
*
*/
function copy(text) {
  app.setTheClipboardTo(text);
}

/**
*
* @method complete
* @param {array} list - List of tasks to complete
* @return {null}
*
*/
function complete(list) {
  list.forEach(function(task) {
    task.completed = true;
  });
}

/**
*
* @method toggleSequential
* @param {array} list - List of projects and actions to toggle
* @return {null}
*
*/
function toggleSequential(list) {
  list.forEach(function(task) {
    try {
      if (task.sequential() === true) {
        task.sequential = false;
      } else {
        task.sequential = true;
      }
    }
    catch (e) {
      console.log(e);
    }
  });
}

/**
*
* @method alert
* @param {string} text - Text to display as alert dialog
* @return {null}
*
*/
function alert(text) {
  app.displayAlert(text);
}

/**
*
* @method openPerspective
* @param {string} perName - Name of perspective to open
*
*/
function openPerspective(perName) {
	app.launch();
	var window = app.windows[0];
	if (window.visible()) {
		window.perspectiveName = perName;
	}
}

/**
*
* @method inboxCount
* @return {number} Number of inbox tasks
*
*/
function inboxCount() {
 return doc.inboxTasks.length;
}

/**
*
* @method errandCount
* @return {number} Number of errands
*
*/
function errandCount() {
 return getContext("Errands").availableTaskCount();
}
/**
*
* @method firstCount
* @return {number} Number of "@First Thing" tasks
*
*/
function firstCount() {
  return getContext('First Thing').availableTaskCount();
}

/**
*
* @method flaggedCount
* @return {number} Number of flagged tasks
*
*/
function flaggedCount() {
  return doc.flattenedTasks.whose({completed: false, flagged: true, blocked: false}).length;
}

/**
*
* @method routineCount
* @return {number} Number of tasks in a folder titled "Routine"
*
*/
function routineCount() {
  var folder = getFolder('Routine');
  var tasks = 0;
  folder.projects().forEach(function(project) {
    tasks += project.numberOfAvailableTasks();
  });
  return tasks;
}

/**
*
* @method landAndSeaCount
* @return {number} Number of tasks in a project titled "Land & Sea"
*
*/
function landAndSeaCount() {
  var project = getProject('Land & Sea');
  return project.numberOfAvailableTasks();
}

/**
*
* @method prependText
* @param {array} list - The tasks to be acted on
* @param {string} text - The text to be prepended
*
*/
function prependText(list, text) {
  list.forEach(function(task) {
    var oldTitle = task.name();
    task.name = text + ' ' + oldTitle;
  });
}

/**
*
* @method appendText
* @param {array} list - The tasks to be acted on
* @param {string} text - The text to be appended
*
*/
function appendText(list, text) {
  list.forEach(function(task) {
    var oldTitle = task.name();
    task.name = oldTitle + ' ' + text;
  });
}

/**
*
* @method computerName
* @return {string} Name of local computer
*
*/
function computerName() {
  return current.doShellScript("scutil --get ComputerName");
}
