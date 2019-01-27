# nwhacks2019

Blackmail yourself

Person and their accountability buddy make an agreement
If the person does not complete the agreed task by the deadline, their secret
gets send to their buddy.

Encrypt the data we store so it's not visible
Out of band key exchange between the accountability buddies for the password.
When time expires, either send a link to the buddy (email sounds hard??) or
unlock the ability for them to download it. They then use the password

Homepage: sign up/login

View your tasks:
list tasks and deadlines
See dirt you can download from other people
- To download, enter the password, check hash against the encryption key, then decrypt and send the file.

Create task:
upload your secret
- we encrypt with password, store the hash and the encrypted data
specify the buddy your dirt will be sent to (by user ID?)

how to handle cookies in ruby?
how do we persist our data?


tasks:
Following this tutorial
https://guides.rubyonrails.org/getting_started.html

-Setup basic server

-Build login/sessions

-Build upload

-Run TTL checks on the deadlines

-Unlock/allow download of dirt

-Fancy UI stuff



Data schema:
task:
 name, date, person, buddy, blob, passhash

login sessions:
 userid, sessionID
