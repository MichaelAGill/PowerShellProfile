# PowerShellProfile
I'm storing my PowerShell Profile script here for convenience of access. It's a bunch of flavoured to taste aliases for the CLI that just makes life a little easier. Anyone is welcome to it also. There's no sensitive data in there.

# How to use
If you open windows terminal (or any CLI you like) and type `$PROFILE` it will print a filename and its directory.
This file will differ depending on where you've opened it from (VSCodes integrated terminal has it's own profile script for example)

If you replace the contents of that file with the profile script in this repo and restart your CLI. It will allow you to use these commands

`setwork` - updates the directory location the `work` command takes you to.
`getwork` - gets the working directory location. Added for reminding purposes.
`work` - changes directory to your typical day to day working directory. Much quicker than starting from root.
`project - -name [project-name]` using your working directory, it will recursively looks for an .sln file with the passed in name.
`newproject` - Will simply run `dotnet new` for you, but will do it in your work repository instead of where you currently are.

## NOTE: Work directory defaults to 'C:\workspace' if not set by user