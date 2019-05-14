---
layout: default
title: GitHub Pages and Google Domains together
showOnHome: true
excerpt_separator: <!--more-->
---

# GitHub Pages and Google Domains together

Oh, that annoyed me more than it should. Yes, it's quite easy to make your custom domain point to your GitHub Pages project, but from the confusing GitHub documentation (too much freaking information) to the annoying first-page Google results, took me a while for everything to work properly.

Now I have my GitHub Pages project working fine over HTTPS with my custom domain on [https://drugowick.dev](https://drugowick.dev) or [https://www.drugowick.dev](https://www.drugowick.dev).

So... assuming: 

- you already have a custom domain (mine is drugowick.dev)
- you already have a GitHub Pages project ([if you don't...]({{ site.baseurl }}{% post_url 2019-04-24-github-pages-how-to %}))

... here are the 3 simple steps to use your GitHub Pages project with your domain:

<!--more-->

1. On your GitHub Pages repository settings (`https://github.com/<your-username>/<your-username>.github.io/settings`) in the `Custom domain` field, put your custom domain including the **www** in the beginning, like so:
    ![GitHub Settings Custom Domain](/assets/img/post_2019-05-13/github-settings-customdomain.png)

2. Check the box `Enforce HTTPS` (you may have to wait a little for this option to be available).

3. Add the following `Custom resource records` to your Google Domains DNS configuration:
    ![Google Domains DNS Config](/assets/img/post_2019-05-13/google-domains-dnsconfig.png)

    - A set of `A` records pointing to GitHub's IPs. [Here](https://help.github.com/en/articles/setting-up-an-apex-domain#configuring-a-records-with-your-dns-provider) you can find the updated IP addresses that should be used.
    - A `CNAME` record pointing to `<your-username>.github.io` and with `www` on the Name field.
    
Wait a little bit again for everything to work. It will work! 

Well... it works for me! =)

Thanks to:

- [https://woliveiras.com.br/posts/jamstack-dom%C3%ADnio-personalizado-com-google-domains-e-github-pages/](https://woliveiras.com.br/posts/jamstack-dom%C3%ADnio-personalizado-com-google-domains-e-github-pages/)
- [https://medium.com/@monarchwadia/github-pages-setting-up-www-subdomain-with-ssl-https-aca9eca371d6](https://medium.com/@monarchwadia/github-pages-setting-up-www-subdomain-with-ssl-https-aca9eca371d6)