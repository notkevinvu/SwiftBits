import UIKit

/*
 1. Open XCode
 
 2. Create a new project
 
 3. Single View App
 
 4. Fill in the title, org name, language, user interface, core data, and tests
 as needed. (For me, I use Swift as the language and storyboard as the interface.
 I also enable core data and tests, no cloudkit though. We won't actually use
 storyboard but just keep it there for now.)
 
 -------- Setting up Git --------
 
 5. Open terminal and navigate to the folder for that project
 
 6. Type 'git init' followed by 'touch .gitignore'
 (This creates the git repo in the directory and creates a .gitignore file)
 
 7. We will set up the .gitignore by first typing 'vim .gitignore' into the terminal
 to open up the vim text editor. Find a good .gitignore template via the
 gitignore.io site. Copy the template and paste it into the terminal. After this,
 press escape and type :wq and hit enter to save the file.
 
 8. Create a new repository wherever you want (just use github for now - initialize
 repo with a readme as well)
 
 9. Get the HTTPS cloning link from github (usually the link to the repo with .git
 at the end) and go back to terminal to add the remote repo with the command:
 'git remote add origin <HTTPS clone link>'
 
 ** Probably better to initialize WITHOUT a readme - won't need to do the whole
 git pull --rebase thing. Instead, after adding the remote, we do 'git push -u
 origin master'
 
 10. Enter 'git fetch' and enter the username and password for your github account
 
 11. Enter 'git pull --rebase origin master' to pull the readme commit from
 the remote repo
 
 12. Git should be properly set up now. We can create branches for our tickets/work,
 add files via 'git add ...', commit the changes via 'git commit -m "Commit message
 here" ', then use 'git push origin <branch name>'
 
 -------- Converting from storyboard to programmatic UI --------
 
 13. Go to the Info.plist file in the xcode project, find the 'Main storyboard
 file base name' key, and delete it. We will keep Main.storyboard just in case
 we want to use it for prototyping (though you can delete it if you want).
 DON'T BUILD OR RUN THE PROJECT YET.
 
 14. We must now tell the compiler what UI to show now. Go to 'AppDelegate.swift'
 and add the following code to the application(_: didFinishLaunchingWithOptions:)
 function, before the return:
 
 window = UIWindow(frame: UIScreen.main.bounds)
 window?.makeKeyAndVisible()
 let navController = UINavigationController()
 let vc = ExampleViewController()
 navController.viewControllers = [vc]
 window?.rootViewController = navController
 
 ** If we want to use a tab bar controller, set the tab bar controller as the
 root view controller, then add the nav controller to the tab bar controller
 
 ** ExampleViewController() is the first view controller we want to show
 
 
 */
