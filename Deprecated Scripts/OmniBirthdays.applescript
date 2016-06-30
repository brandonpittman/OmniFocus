property bd_list : {}
property birth_date : missing value
property the_date : missing value
property existing_list : {}
property bd_project : "Birthdays"
property bd_context : "Communications"

--Script Flow

birthday_list()

create_birthday_project()

check_existing()

--return existing_list()

make_task()


--Handlers

on birthday_list()
  
	tell application "Contacts"
		set person_list to every person whose birth date is not missing value
		repeat with new_person in person_list
			set end of bd_list to {name:name of new_person, birth_date:birth date of new_person}
		end repeat
	end tell
	
end birthday_list

on create_birthday_project()
	
	tell application "OmniFocus"
		
		tell default document
			if not (exists (flattened project bd_project)) then
				set homeContext to first flattened context whose name is bd_context
				make new project with properties {name:bd_project, flagged:true, singleton action holder:true, context:homeContext}
			end if
			
		end tell
	end tell
end create_birthday_project

on make_task()
	
	tell application "OmniFocus"
		
		tell default document
			set the_project to first flattened project whose name is bd_project
			repeat with n in bd_list
				--return bd_list
				set task_title to "Wish " & name of n & " a happy birthday!"
				if not (task_title is in existing_list) then
					set the_date to birth_date of n
					tell application "System Events"
						set year of the_date to 2013
						if the_date < (current date) then set year of the the_date to 2014
					end tell
					tell the_project to make new task with properties {name:task_title, start date:the_date, repetition rule:{recurrence:"FREQ=YEARLY", repetition method:fixed repetition}}
				end if
			end repeat
		end tell
		
	end tell
	
end make_task


on check_existing()
	
	tell application "OmniFocus"
		
		tell default document
			set existing_list to {}
			set new_tasks to tasks of flattened project bd_project
			repeat with new_task in new_tasks
				set end of existing_list to name of new_task
			end repeat
		end tell
		
	end tell
	
end check_existing
