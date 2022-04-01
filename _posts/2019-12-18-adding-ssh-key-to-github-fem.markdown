---
layout: post
title:  "Adding SSH key to GitHub"
date:   2019-12-18T15:28:52Z
categories: 
---

> <div class=card><div class=container><h4><b><a href="https://dev.to/brunodrugowick/adding-ssh-key-to-github-fem">You'll have a better experience reading in DEV...</a></b></h4><i><p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/adding-ssh-key-to-github-fem">read more</a>.</p><p>You can continue to read here too, it's up to you...</p></i></div></div>
<p>It's fairly easy to follow <a href="https://help.github.com/en/articles/adding-a-new-ssh-key-to-your-github-account">GitHub's official documentation</a> on how to add your SSH key to your account. This version is quickier and you can find all necessary commands below. Follow this if you use a Linux distribution.</p>

<p>You can follow this procedure with a few modifications for GitLab and Bitbucket.</p>

<h2>
 <a name="generating-a-ssh-key" href="#generating-a-ssh-key">
 </a>
 Generating a SSH key
</h2>

<h3>
 <a name="check-the-existence-of-a-key" href="#check-the-existence-of-a-key">
 </a>
 Check the existence of a key:
</h3>



<div class="highlight js-code-highlight">
<pre class="highlight plaintext"><code>ls -al ~/.ssh
</code></pre>
<div class="highlight__panel js-actions-panel">
<div class="highlight__panel-action js-fullscreen-code-action">
 <svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" viewbox="0 0 24 24" class="highlight-action crayons-icon highlight-action--fullscreen-on"><title>Enter fullscreen mode</title>
 <path d="M16 3h6v6h-2V5h-4V3zM2 3h6v2H4v4H2V3zm18 16v-4h2v6h-6v-2h4zM4 19h4v2H2v-6h2v4z"></path>
</svg>

 <svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" viewbox="0 0 24 24" class="highlight-action crayons-icon highlight-action--fullscreen-off"><title>Exit fullscreen mode</title>
 <path d="M18 7h4v2h-6V3h2v4zM8 9H2V7h4V3h2v6zm10 8v4h-2v-6h6v2h-4zM8 15v6H6v-4H2v-2h6z"></path>
</svg>

</div>
</div>
</div>



<p>The filenames of the public keys are one of the following:</p>

<ul>
<li>id_dsa.pub</li>
<li>id_ecdsa.pub</li>
<li>id_ed25519.pub</li>
<li>id_rsa.pub <em>&lt;-- that's mine</em>
</li>
</ul>

<h3>
 <a name="generate-a-new-ssh-key-if-necessary" href="#generate-a-new-ssh-key-if-necessary">
 </a>
 Generate a new SSH key if necessary
</h3>



<div class="highlight js-code-highlight">
<pre class="highlight plaintext"><code>ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
</code></pre>
<div class="highlight__panel js-actions-panel">
<div class="highlight__panel-action js-fullscreen-code-action">
 <svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" viewbox="0 0 24 24" class="highlight-action crayons-icon highlight-action--fullscreen-on"><title>Enter fullscreen mode</title>
 <path d="M16 3h6v6h-2V5h-4V3zM2 3h6v2H4v4H2V3zm18 16v-4h2v6h-6v-2h4zM4 19h4v2H2v-6h2v4z"></path>
</svg>

 <svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" viewbox="0 0 24 24" class="highlight-action crayons-icon highlight-action--fullscreen-off"><title>Exit fullscreen mode</title>
 <path d="M18 7h4v2h-6V3h2v4zM8 9H2V7h4V3h2v6zm10 8v4h-2v-6h6v2h-4zM8 15v6H6v-4H2v-2h6z"></path>
</svg>

</div>
</div>
</div>



<p>You'll see this:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight plaintext"><code>&gt; Enter a file in which to save the key (/home/you/.ssh/id_rsa): [Press enter]
</code></pre>
<div class="highlight__panel js-actions-panel">
<div class="highlight__panel-action js-fullscreen-code-action">
 <svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" viewbox="0 0 24 24" class="highlight-action crayons-icon highlight-action--fullscreen-on"><title>Enter fullscreen mode</title>
 <path d="M16 3h6v6h-2V5h-4V3zM2 3h6v2H4v4H2V3zm18 16v-4h2v6h-6v-2h4zM4 19h4v2H2v-6h2v4z"></path>
</svg>

 <svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" viewbox="0 0 24 24" class="highlight-action crayons-icon highlight-action--fullscreen-off"><title>Exit fullscreen mode</title>
 <path d="M18 7h4v2h-6V3h2v4zM8 9H2V7h4V3h2v6zm10 8v4h-2v-6h6v2h-4zM8 15v6H6v-4H2v-2h6z"></path>
</svg>

</div>
</div>
</div>



<p>Just [press enter] as instructed to use the default location or type one of your preference.</p>

<p>Then you'll be prompt to define a passphrase. Be creative.</p>

<h2>
 <a name="adding-an-ssh-key-to-github" href="#adding-an-ssh-key-to-github">
 </a>
 Adding an SSH key to GitHub
</h2>

<p>To get your ssh public key you can run <code>ls -al ~/ssh</code>, identify you public key and then <code>cat</code> its content to the console. For example:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight plaintext"><code>cat ~/.ssh/id_rsa.pub
</code></pre>
<div class="highlight__panel js-actions-panel">
<div class="highlight__panel-action js-fullscreen-code-action">
 <svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" viewbox="0 0 24 24" class="highlight-action crayons-icon highlight-action--fullscreen-on"><title>Enter fullscreen mode</title>
 <path d="M16 3h6v6h-2V5h-4V3zM2 3h6v2H4v4H2V3zm18 16v-4h2v6h-6v-2h4zM4 19h4v2H2v-6h2v4z"></path>
</svg>

 <svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" viewbox="0 0 24 24" class="highlight-action crayons-icon highlight-action--fullscreen-off"><title>Exit fullscreen mode</title>
 <path d="M18 7h4v2h-6V3h2v4zM8 9H2V7h4V3h2v6zm10 8v4h-2v-6h6v2h-4zM8 15v6H6v-4H2v-2h6z"></path>
</svg>

</div>
</div>
</div>



<p>Then:</p>

<ul>
<li>Go to your <a href="https://github.com/settings/keys">GitHub SSH and GPG keys settings page</a>. </li>
<li>Click <a href="https://github.com/settings/ssh/new">New SSH key</a>. </li>
<li>Choose a good title, like <code>Living Room Desktop SSH Key</code>.</li>
<li>Paste your SSH key on the <code>Key</code> text area.</li>
</ul>

<p>Now all operations to/from GitHub (<code>clone</code>, <code>pull</code>, <code>push</code> and others) can be performed safely without typing user and password every time.</p>


<hr>

<p>Imagem de <a href="https://pixabay.com/pt/users/mikex7-1209336/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=3678638">mikex7</a> por <a href="https://pixabay.com/pt/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=3678638">Pixabay</a></p>...