# Rules for using scratch

## Rules the author has set
1. **Use the scratch repo for hosting** test zips, handover packs, Documentation and SavedVariables.
2. **Easily human-readable folders**: plain words, dates as `YYYY-MM-DD-hh-mm`, versions in file names.
3. **Version everything hosted**: builds by addon version, packs by `<date>-vN`, saves by the version that wrote them.
4. **A SavedVariables Folder is created in the git repository suffixed -scratch** It is mandatory that a SavedVariables folder exists in the scratch repository
5. **A releases Folder is created in the git repository suffixed -scratch** It is mandatory that a releases folder exists in the scratch repository
6. **A docs Folder is created in the git repository suffixed -scratch** It is mandatory that a features folder exists in the scratch repository
7. **A summary Folder is created in the git repository suffixed -scratch** It is mandatory that a summary folder exists in the scratch repository
8. **A latest Folder is created in the git repository suffixed -scratch** It is mandatory that a latest folder exists in the scratch repository
9. **Addon test zips are stored in the releases folder**: everything we create before the release workflow occurs is stored in a zip in the releases folder.  The latest zip is stored in the latest folder, and at the same time a version and dated copy is stored in the root of the releases folder
10. **Addon project documentation zips is stored in the docs folder**: When we create project documentation as markdown, we store the latest version in the docs folder.  When identified as a project or feature release, we will name a child folder in latest and in the root of docs to store history.  The latest is stored in a folder in the folder named "latest" in the root of docs and every docs release is zipped and stored in the root of the docs folder.  Where possible we put the files in folders to organise them
11. **A description README** in each top folder the author may come back to "when confused".
12. **Bugfix builds are hosted** like any dev build: the stage's next fix build (`devNNN_01`, `devNNN_02`), zipped, on scratch, with a link.
13. **Real saves live here and in the project files, never in an addon repo.**  All saves can be checked in the savedvariables folder
14. **Always reply with links**, never only a path.
## Rules to add
<!-- The author adds further scratch rules here. -->
