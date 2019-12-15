---
layout: default
title: Adding SSH key to GitHub
showOnHome: false
excerpt_separator: <!--more-->
comments: true
---

# Adding SSH key to GitHub

It's fairly easy to follow [GitHub's official documentation](https://help.github.com/en/articles/adding-a-new-ssh-key-to-your-github-account) on how to add your SSH key to your account. This version is quickier and you can find all necessary commands below. Follow this if you use a Linux distribution.

You can follow this procedure with a few modifications for GitLab and Bitbucket.

<!--more-->

## Generating a SSH key

### Check the existence of a key:
```
ls -al ~/.ssh
```
The filenames of the public keys are one of the following:

- id_dsa.pub
- id_ecdsa.pub
- id_ed25519.pub
- id_rsa.pub  _<-- that's mine_

### Generate a new SSH key if necessary
```
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

You'll see this:
```
> Enter a file in which to save the key (/home/you/.ssh/id_rsa): [Press enter]
```
Just [press enter] as instructed to use the default location or type one of your preference.

Then you'll be prompt to define a passphrase. Be creative.

## Adding an SSH key to GitHub

To get your ssh public key you can run `ls -al ~/ssh`, identify you public key and then `cat` its content to the console. For example: 
```
cat ~/.ssh/id_rsa.pub
```
 Then:

- Go to your [GitHub SSH and GPG keys settings page](https://github.com/settings/keys). 
- Click [New SSH key](https://github.com/settings/ssh/new). 
- Choose a good title, like `Living Room Desktop SSH Key`.
- Paste your SSH key on the `Key` text area.

Now all operations to/from GitHub (`clone`, `pull`, `push` and others) can be performed safely without typing user and password every time.

# Comments

{% if page.comments %} 
<div id="disqus_thread"></div>
<script>

var disqus_config = function () {
this.page.url = 'https://drugowick.dev' + '{{ page.url }}';  // Replace PAGE_URL with your page's canonical URL variable
this.page.identifier = '{{ page.id }}'; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
};

(function() { // DON'T EDIT BELOW THIS LINE
var d = document, s = d.createElement('script');
s.src = 'https://drugowick.disqus.com/embed.js';
s.setAttribute('data-timestamp', +new Date());
(d.head || d.body).appendChild(s);
})();
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
{% endif %}
