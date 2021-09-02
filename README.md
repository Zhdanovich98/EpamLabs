### Task 4: "Gradle" ###
#### This build.gradle: ####
-   has version, ex: 1.0.1 (specified in gradle.properties)
-   has increment version task *"up_version"*
-   has the task to populate greetings.txt file with version
-   has the task of sorting the array *"sort"*
---
#### For start: ####
1.   clone the project from git:
```sh
git clone https://github.com/Zhdanovich98/EpamLabs.git
```
2.   go to the project directory
```sh
cd ./EpamLabs
```
3.    go to the "task4" branch
```sh
git checkout task4
```
4.   build project:
```sh
gradle build
```
5.   checking war file
```sh
cd ./build/libs/
```
---
#### For up version: ####
```sh
gradle up_version
```
---
#### For starting sorting an array: ####
```sh
gradle sort
```
