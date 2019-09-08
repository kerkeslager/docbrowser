# docbrowser

Docbrowser is a browser for a user-focused semantic web made up of documents.

General principle:
The browser serves the user only.

Rules:
1. The browser only runs the user's code.
2. The browser only displays content the user requests.
3. The browser only displays content styled and formatted to the user's
preferences.
4. The browser only shares data the user shares.
5. The browser only agrees to what the user agrees to.

Rules, explained:
1. No Javascript. A user requesting a file doesn't imply consent to a site
running programs on that user's machine.
2. No third-party content, no ads, no linked content automatically loaded, no
pop-ups/overs/unders/anythings. A user requesting a file doesn't imply consent
to a site loading a bunch of other files onto that user's machine, or trying
to control the user's attention.
3. No CSS. A user requesting a file doesn't imply consent to allow the site to
control how that file is displayed.
4. No tracking or data sharing. A user requesting a file doesn't imply consent
to give the site the user's data.
5. This is intended to be a catch-all that proscribes the user-hostile
behaviors that sites self-servingly assume users consent to because their
browsers support it, including ones we haven't thought of yet. No pre-checked
checkboxes, no automatic subscriptions, etc. The browser serves the user *only*!
