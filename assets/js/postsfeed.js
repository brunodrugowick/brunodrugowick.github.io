const api = 'https://dev.to/api';

/** 
 * Creates a feed of DEV posts.
 * 
 * This code was copied from https://github.com/healeycodes/embed-DEV-posts (thanks!)
 * 
 * @param {Element} elem - Place list of posts inside this element.
 * @param {string} username - DEV username, e.g. 'ben'.
 * @param {number} numberOfPosts - Number of posts to list. 
 */
function createFeed(elem, username, numberOfPosts = 10) {
    const feed = document.createElement('div');
    feed.classList.add('dev-feed-list');
    feed.appendChild(document.createElement('ul'))
    getPosts(username)
        .then(function (posts) {
            posts.length = numberOfPosts;
            posts.forEach(function (post) {
                //Adding wrapper
                const post_wrapper = document.createElement('li');
                post_wrapper.id = post.published_at;

                // Adding date
                post_wrapper.textContent += post.readable_publish_date + ' ・ ';

                // Adding title
                
                post_wrapper.textContent += post.title + ' ・ [';

                // Adding tags
                post_wrapper.textContent += post.tags + '] ・ ';

                // Adding link to dev.to
                const link = document.createElement('a');
                link.classList.add('dev-feed-item-link');
                link.href = post.url;
                link.target = '_blank';
                link.innerText = 'Continue reading...';

                // Connects everything
                post_wrapper.appendChild(link);
                feed.appendChild(post_wrapper);
            });
            elem.appendChild(feed);
        });
}

/**
 * Get a DEV user's post objects.
 * Only fetches previously 30 posts. Using `&page=X` is too slow.
 * @param {string} username - DEV username, e.g. 'ben'.
 * @returns {array} User's post objects.
 */
function getPosts(username) {
    return fetch(`${api}/articles?username=${username}`)
        .then(function (response) {
            return response.json();
        })
        .then(function (posts) {
            return posts.sort((a, b) => b.positive_reactions_count - a.positive_reactions_count);
        });
}