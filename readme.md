# R-umblr (Ruby Tumblr)

## Sample Login:
Username: *blogger123*

Password: *password*

## Features:

* Public v. private nav menu
![public nav](/public/img/nav-public.png =400x "Public Nav - not logged in")

![private nav](/public/img/nav-login.png "Private Nav - logged in")

* Password mismatch warning
![password mismatch](/public/img/pw-miss.png "Password Mismatch Warning")

* Facebook login
* Deactivate submit buttons on password mismatch
* Animate password input on button click while passwords mismatched
![login screenshot](/public/img/pw-miss-anim.png "Password Mismatch")

* See all user posts and most recent update times, if any
![all posts](/public/img/posts-all.png "All Posts")

* My Posts view includes edit and delete options
![my posts](/public/img/posts-self.png "My Posts")

* My Account view includes account info, edit, and delete options well as log in/out of Facebook
![my account](/public/img/profile-self.png "My Account")


## Goal:

To create a fullstack simple blog website that enables someone to sign up for an account and create relevant posts on a topic of their choosing.

## Learning Objectives:  

Upon successful completion of this project, the student will demonstrate an understanding of Sinatra, ActiveRecord, Cookies and deploying to Heroku.
 
## Instructions:

A blog, or weblog, is a platform where you can share information about a particular topic usually displayed much like diary entries in reverse chronological order. Some popular blogging platforms include Wordpress (Links to an external site.)Links to an external site., Tumblr (Links to an external site.)Links to an external site. and Medium (Links to an external site.)Links to an external site.. If you are not familiar, we recommend you spend some time looking at some of the blogging platforms listed to familiarize yourself with how they work. During this initial research phase it will be helpful for identify how these applications work on a fundamental level and note them.

When researching, ask yourself the following questions:

* What is the procedure for posting a new entry?
* How does the design influence the user experience when using the application?
  * How are colors used?
  * How do they hook you into using their product?
  * What fonts are used and how does this contribute to the user experience?
* How do you sign up for an account?
* What does their login page look like?
* What nomenclature is used for their urls and routing?
* Can I see other people’s posts?
  * How do I go about doing that?

For this project, your task is to create a basic blog for people who enjoy ________ . Where the blank is filled in by you. You can create a blogging platform for people who enjoy dogs, music, cars or food. However, do not feel limited by these examples, the choice is up to you. The only limitation is that the blank must be filled by one word. This is designed purposefully to prevent too large of a scope. Keep it simple. Finally, in order to make it official, this project will be deployed to the heroku platform, so please familiarize yourself with heroku beforehand.

## Challenge:

Another thing that is useful within a blogging platform is to have the ability to tag a post so that you can group similar topics together. All three platforms mentioned above have this feature built in so please take a moment to see how tagging works in a real world setting. Now try building a tagging feature into your blogging platform.

You will need at least the following:

* A process for tagging a post
* A process for displaying all similarly tagged posts
* A database table to relate the same tags to multiple posts
 
## Completion Requirements:

The completed assignment should:

* have a way to create an account (sign up) with at least
  * first name
  * last name
  * email
  * birthday
* have a way to login to an account
* have a way to logout of their account
* show login and signup links only when logged out
* show logout links only when logged in
* have a way to cancel their account
* have a way to create a new post only when logged in
* have a page that lists out the 20 most recent posts made by the * currently logged in user
* have a page that lists the currently logged in user’s profile information
* have the ability to see other user’s last 20 posts
* be deployed to Heroku
* use Activerecord to make all database transactions
* use Sinatra as the web microframework backend