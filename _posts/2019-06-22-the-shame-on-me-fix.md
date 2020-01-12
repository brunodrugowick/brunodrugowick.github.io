---
layout: default
title: The SHAME ON ME fix
showOnHome: true
excerpt_separator: <!--more-->
comments: true
devToUrl: https://dev.to/brunodrugowick/the-shame-on-me-fix-2aij
---

# The SHAME ON ME fix

I had a problem. On my 2-week journey into Javascript inspired by the Omnistack Week (a week where you implement a full application with NodeJS, React and React Native), I built [this application](https://omnistack-quick-start-frontend.herokuapp.com/) but something was bothering me. I'll explain...

The function that uploads the post to the server, after doing so, redirects the user to the app's feed. Here's the code:

<!--more-->

<a href="https://dev.to/brunodrugowick/the-shame-on-me-fix-2aij" target="_blank">Continue reading at dev.to...</a>

```javascript
handleSubmit = async e => {
    // Prevents the browser from doing whatever after submiting a form
    e.preventDefault();
    // This disables the submit button while the post is being created.
    this.setState({ loading: true });

    // Creates the form to be submitted to the backend (from the app's state).
    const data = new FormData();
    data.append('image', this.state.image);
    data.append('author', this.state.author);
    data.append('place', this.state.place);
    data.append('description', this.state.description);
    data.append('hashtags', this.state.hashtags);
    
    // Posts to the backend.
    await api.post('posts', data).then(() => {
        // Not necessary because I redirect, but re-enables the button.
        this.setState({ loading: false });
    });

    // Redirects to the feed.
    this.props.history.push('/');
}
```

But, when redirected, the user would see this:

![the bug](/assets/img/post_2019-06-22/bug.png)

On the first version of the app, in which the image was uploaded to the server, I didn't have this problem. But then I changed to upload the image to Amazon S3, which makes more sense than storing on the application's server (and solved the problem of hosting on the free tier of Heroku, that turns everything off after a while and back on when someone hits the server). 

I guess that that problem had something to do with the time it takes Amazon S3 to provision everything... but I really don't know. So, I thought I could test the link before redirecting the user, while a loading layer or something like that would have the user waiting. I thought about a progress bar within the 'Share' button or a cool loading layer above everything...

BUT, here's what I did. A function:

```javascript
sleep(milliseconds) {
    var start = new Date().getTime();
    for (var i = 0; i < 1e7; i++) {
        if ((new Date().getTime() - start) > milliseconds){
            break;
        }
    }
}
```

And right before redirecting the user, I added this (with the comment and everything):

```javascript
/**
* SHAME ON ME.
* 
* The first request to S3 after redirecting to the feed fails.
* This is my fix to it. The correct fix would be to test the URL and once it
* is working, redirect to the Feed.
* 
* For now, sit tight for about one second and hope for the best.
*/
this.sleep(1000);
```

You can actually see the code on [this commit](https://github.com/brunodrugowick/omnistack-quick-start-frontend/commit/c1e92b1834afb63299adb33265f9ef6164eb9b98) and, of course, contribute, since it's an open source project.

Shame on me, I know. `=|`
