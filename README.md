Rizzoma Query Language Implementation und Tests

For getting acceptance tests to work, some hardcoded file paths will have to be changed :(
Direct command (execute in root directory of this project):
```
find . -regex '\(.*\.sh\)\|\(.*.coffee\)\|\(.*.testXML\)' | xargs sed -i s#\/home\/robintibor\/work\/rizzoma-query-language#YOURPATHTOPROJECT#g
```
Manual way:
In the root directory of the project run
```
grep -r 'home/' *
```
and change all paths to your project paths..

Um mit git repository zu arbeiten:

Falls bisher keine eigenen dateien vorhanden:
```
git clone https://github.com/robintibor/rizzoma-query-language.git
```
Falls andere Dateien bereits vorhanden:
```
cd <bisherigesVerzeichnis>
git init
git add <bisherigeDateien>
git commit -m 'commit bisherige dateien simon'
git remote add origin https://github.com/robintibor/rizzoma-query-language.git
git pull origin master
```
