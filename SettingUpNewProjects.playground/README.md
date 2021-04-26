# Setting up new projects in Xcode and connecting to a remote repository with git.

## Creating the base Xcode project
1) Open Xcode

2) Create a new project

3) Single View App

4) Fill in the title, org name, language, user interface, core data, and tests as needed.
    - These are my typical settings:
        - Team: [your own personal team - you will need to set this up 
        - Organization Identifier: com.KV (basically just have something unique that identifies you as an "org". This should result in a unique bundle identifier which is used with Apple's signing and profile stuff.)
        - Interface: Storyboard
        - Life cycle: UIKit App Delegate
        - Language: Swift
    - I don't include core data or tests at the start (I add them when necessary in development)

## Setting up Git
5) Open terminal and navigate to the folder for that project. You will know you're there when you run the `ls` command and see the project folder `My_Project` and the .xcodeproj folder `My_Project.xcodeproj`

6) In terminal, enter `git init` follower by `touch .gitignore`. This creates the git repository in your project folder and creates a .gitignore file.

7) To edit the .gitignore file, enter `vim .gitignore` into terminal to open up the vim text editor.
    - Find a good .gitignore template (or if you know what you're doing, just add the file directories/paths directly). I like to use https://gitignore.io/
    - Copy the template and paste it into the terminal.
    - Add any other files to ignore if the template did not have it.
    - After finishing, press escape (ESC), type in :wq, and hit enter/return to save the file.

8) Go to whatever git service you typically use (I will use github as the example here) and create a new repository without a readme.

9) Copy the HTTPS cloning link from github that is typically the link to your repo + .git at the end (example: https://github.com/notkevinvu/Github-Followers.git)

10) Go back to your terminal to add the remote repo with the command: `git remote add origin <HTTPS cloning link>` without the < > around your cloning link

11) Add all files from your project with `git add .`, commit them `git commit -m "Initial commit"`, and then push them `git push --set-upstream origin master` to the github repo. \*You may have to provide your credentials by logging into github via terminal or by providing the token.\*

* If you did decide to create a readme when creating the repo, I believe you need to perform `git pull --rebase origin master` to pull the readme commit from the remote repo and then you can add, commit, push.

12) Git should be properly set up now and we can create branches for our features/tickets `git checkout -b Branch-name`, do some work, add files via `git add [files]`, commit your changes `git commit -m "Commit mesage"`, then use `git push origin Branch-name`.

## Converting from storyboard to programmatic UI

13) Go to the `Info.plist` file in the xcode project, CMD+F to search for "storyboard", and delete these two keys: "Main storyboard file base name" and "Storyboard Name". At this point, you can delete the `Main.storyboard` file or keep it for prototyping. DON'T BUILD OR RUN THE PROJECT YET.

14) We must not tell the compiler what UI to show. Go to the `SceneDelegate.swift` file and add the following code to the `scene(_ scene:, willConnectTo session:)` function:

```swift
guard let windowScene = (scene as? UIWindowScene) else { return }

let window = UIWindow(windowScene: windowScene)

// replace ViewController() with your own custom view controller if needed
let vc = ViewController()
// omit the nav controller if you don't need one
let navController = UINavigationController(rootViewController: vc)

// replace navController with your custom view controller if you omitted nav controller earlier
window.rootViewController = navController 
self.window = window
window.makeKeyAndVisible()
```

* If you want to use a tab bar controller as well, here's how it would look:

```swift
...
let vc1 = FirstViewController()
vc1.title = "First VC"
vc1.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
let navCon1 = UINavigationController(rootViewController: vc1)

let vc2 = SecondViewController()
vc2.title = "Second VC"
vc2.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
let navCon2 = UINavigationController(rootViewController: vc2)

let tabBar = UITabBarController()
tabBar.viewControllers = [navCon1, navCon2]

window.rootViewController = tabBar
...
```

* We can also extract this code out of the `scene(_ scene:, willConnectTo session:)` function by putting each controller instantiation into its own function. See for example: https://github.com/notkevinvu/Github-Followers/blob/master/Github_Followers/Support/SceneDelegate.swift

 
