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

-Setup basic server --done--

-Build login/sessions --done--
Registration: /blackmail/register
   endpoint for making account at /blackmail/create_account
For displaying errors and failing saves on form content:
https://guides.rubyonrails.org/active_record_validations.html

-Build upload --done--
  just use simple text field for things like secrets, passwords, etc.

  encrypting:
  https://stackoverflow.com/questions/4128939/simple-encryption-in-ruby-without-external-gems
  to fit the AES256, we will use SHA256 hash of the password as the encryption key.
  Then, to not store the password, we will HASH THIS A SECOND TIME

  decryption works as well

-Dashboard page
  - view your bounties
    - name, debt collector name, date/time due --done--
    - operation to mark completed
      - pop up confirmation
      - on confirm, destroy the record --done--

  - create new bounties --done--
    - make picking due date neater

  - view what people may owe you --done--
    - download button grayed if day not past, otherwise available
    - password field appear as well

-Run TTL checks on the deadlines --done--


-Unlock/allow download of dirt -- not gated by user, but uses the passphrase to work --done--
  - check user is the right collector for this --done--
  - check the date is valid --done--
  - check password matches before decrypting or we bust the cipher --done--

-Fancy UI stuff
https://medium.freecodecamp.org/add-bootstrap-to-your-ruby-on-rails-project-8d76d70d0e3b

-Display username + sign out butten when logged in

-Validations on creating new contracts

User Schema:


Data schema:
task:
 name, date, person, buddy, blob, passhash
 ownerUID: owner of the task
 receiverUID: witness who will get the collateral
 content: encrypted text of the secret collateral
 pwhash: hash (2nd hash of the encryption password) to verify when decrypting
 crypto_iv: the iv used in the encryption cypher
 expiration: time (seconds epoch time) to unlock the secret
 task: name/description of the task

login sessions:
 userid, sessionID
