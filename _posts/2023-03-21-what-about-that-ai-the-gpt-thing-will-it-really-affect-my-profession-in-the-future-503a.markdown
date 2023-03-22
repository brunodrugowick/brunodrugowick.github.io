---
layout: post
title:  "What about that AI, the GPT thing? Will it really affect my profession in the future?"
date:   2023-03-21T03:02:22Z
---

<style type="text/css" media="screen">
  .card {
    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
    transition: 0.3s;
    width: 100%;
  }
  .card:hover {
    box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
  }
  .container {
    padding: 2px 16px;
  }
</style>

<code>[chatgpt, go, algorithms, career]</code>
<div class=card>
	  <div class=container>
	    <h4><b><br>You'll have a better experience reading in DEV</b></h4>
	    <p><a href="https://dev.to/brunodrugowick/what-about-that-ai-the-gpt-thing-will-it-really-affect-my-profession-in-the-future-503a" target="_blank">Click here to continue reading this post there >></a></p>
	    <p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/what-about-that-ai-the-gpt-thing-will-it-really-affect-my-profession-in-the-future-503a" target="_blank">read more</a>.</p>
	    <p>You can continue to read here too, it's up to you... =]</p>
	  </div>
	</div><br>
<h2>
  <a name="id-never-used-gpt-until-today" href="#id-never-used-gpt-until-today">
  </a>
  I'd never used GPT... until today!
</h2>

<p>When all the hype about AI in programming started with GitHub Copilot I was not using VSCode plus the company I work for told us not to use it with any code from our clients. When ChatGPT came, a similar message also was sent to everybody. Put that together with my own recent career choice - to dedicate my time exclusively to code-related activities - and what happened is that I didn't care too much about all the hype until now.</p>

<p>Well, I've been reading, understanding, and discussing AI and how it relates to coding. I just haven't tried anything AI-related to help with my coding. And somehow I think that was a good decision. I didn't want a shortcut to get things done, I need mileage, I need to get my hands dirty with all sorts of programming problems, no matter how trivial. Apart from being fun, it's also the only way to re-learn some things that I ended up forgetting after a while (because, yeah, I forget very easily all the things - I might write about this in the future).</p>

<h2>
  <a name="i-was-just-peacefully-coding" href="#i-was-just-peacefully-coding">
  </a>
  I was just peacefully coding.
</h2>

<p>But reading about something is not the same as using and applying it to a mundane activity. And that's what happened today. I was coding a very simple algorithm that a dear friend of mine was talking about with me. He said he was asked to code it in an interview and I decided to implement it in Golang as a challenge. I wouldn't look anywhere, I wouldn't try to find a solution or a hint of the solution online. The only thing I allowed myself to do was to search syntax-related things, because, as I stated above, I easily forget some things.</p>

<p>And during that activity, I ended up needing to implement a stack. I had some sort of a stack already but badly implemented in a string that I was manipulating throughout the code. So I did my own implementation of the stack, which took me around 15 minutes. Here is the first version I came up with:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight go"><code><span class="c">// package and imports suppressed</span>

<span class="k">type</span> <span class="n">unicodeSlice</span> <span class="p">[]</span><span class="kt">int32</span>
<span class="k">type</span> <span class="n">Stack</span> <span class="k">struct</span> <span class="p">{</span>
    <span class="n">unicodeSlice</span>
<span class="p">}</span>

<span class="k">func</span> <span class="p">(</span><span class="n">s</span> <span class="o">*</span><span class="n">Stack</span><span class="p">)</span> <span class="n">Push</span><span class="p">(</span><span class="n">v</span> <span class="kt">int32</span><span class="p">)</span> <span class="p">{</span>
    <span class="n">s</span><span class="o">.</span><span class="n">unicodeSlice</span> <span class="o">=</span> <span class="nb">append</span><span class="p">(</span><span class="n">s</span><span class="o">.</span><span class="n">unicodeSlice</span><span class="p">,</span> <span class="n">v</span><span class="p">)</span>
<span class="p">}</span>

<span class="k">func</span> <span class="p">(</span><span class="n">s</span> <span class="o">*</span><span class="n">Stack</span><span class="p">)</span> <span class="n">Pop</span><span class="p">()</span> <span class="p">{</span>
    <span class="n">lastElementPosition</span> <span class="o">:=</span> <span class="nb">len</span><span class="p">(</span><span class="n">s</span><span class="o">.</span><span class="n">unicodeSlice</span><span class="p">)</span> <span class="o">-</span> <span class="m">1</span>
    <span class="k">if</span> <span class="n">lastElementPosition</span> <span class="o">&gt;=</span> <span class="m">0</span> <span class="p">{</span>
        <span class="n">s</span><span class="o">.</span><span class="n">unicodeSlice</span> <span class="o">=</span> <span class="n">s</span><span class="o">.</span><span class="n">unicodeSlice</span><span class="p">[</span><span class="o">:</span><span class="n">lastElementPosition</span><span class="p">]</span>
    <span class="p">}</span>
<span class="p">}</span>

<span class="k">func</span> <span class="p">(</span><span class="n">s</span> <span class="o">*</span><span class="n">Stack</span><span class="p">)</span> <span class="n">PopIfMatches</span><span class="p">(</span><span class="n">v</span> <span class="kt">int32</span><span class="p">)</span> <span class="kt">error</span> <span class="p">{</span>
    <span class="n">lastElementPosition</span> <span class="o">:=</span> <span class="nb">len</span><span class="p">(</span><span class="n">s</span><span class="o">.</span><span class="n">unicodeSlice</span><span class="p">)</span> <span class="o">-</span> <span class="m">1</span>
    <span class="k">if</span> <span class="n">lastElementPosition</span> <span class="o">&gt;=</span> <span class="m">0</span> <span class="o">&amp;&amp;</span> <span class="n">s</span><span class="o">.</span><span class="n">unicodeSlice</span><span class="p">[</span><span class="n">lastElementPosition</span><span class="p">]</span> <span class="o">==</span> <span class="n">v</span> <span class="p">{</span>
        <span class="n">s</span><span class="o">.</span><span class="n">Pop</span><span class="p">()</span>
        <span class="k">return</span> <span class="no">nil</span>
    <span class="p">}</span>

    <span class="k">return</span> <span class="n">fmt</span><span class="o">.</span><span class="n">Errorf</span><span class="p">(</span><span class="s">"value to pop (%d) does not match provided value (%d)"</span><span class="p">,</span> <span class="n">s</span><span class="o">.</span><span class="n">unicodeSlice</span><span class="p">[</span><span class="n">lastElementPosition</span><span class="p">],</span> <span class="n">v</span><span class="p">)</span>
<span class="p">}</span>
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



<p>My idea was to have a regular stack, hence both Push() and Pop(), and an additional PopIfMatches() which was what I needed: a way to only pop the stack if the top value of the stack was a determined value that I could pass. If not, I needed an error, and that's what I decided to return.</p>

<h2>
  <a name="hunn-maybe-i-could-see-what-ai-is-all-about" href="#hunn-maybe-i-could-see-what-ai-is-all-about">
  </a>
  Hunn, maybe I could see what AI is all about.
</h2>

<p>Right away, after getting the implementation working, I started to review it, as I always do. Then it came to me: well, do I need to do that? Let's see what GPT can do! A stack is a very common implementation, but I wanted to see what GPT would do with my "PopIfMatches" requirement.</p>

<p>I typed this: "Can you make a stack in Go with a special method that pop (sic) only if the value corresponds to a passed value?" and got exactly this:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight go"><code><span class="c">// package and imports suppressed</span>

<span class="k">type</span> <span class="n">Stack</span> <span class="k">struct</span> <span class="p">{</span>
    <span class="n">items</span> <span class="p">[]</span><span class="kt">int</span>
<span class="p">}</span>

<span class="k">func</span> <span class="p">(</span><span class="n">s</span> <span class="o">*</span><span class="n">Stack</span><span class="p">)</span> <span class="n">Push</span><span class="p">(</span><span class="n">i</span> <span class="kt">int</span><span class="p">)</span> <span class="p">{</span>
    <span class="n">s</span><span class="o">.</span><span class="n">items</span> <span class="o">=</span> <span class="nb">append</span><span class="p">(</span><span class="n">s</span><span class="o">.</span><span class="n">items</span><span class="p">,</span> <span class="n">i</span><span class="p">)</span>
<span class="p">}</span>

<span class="k">func</span> <span class="p">(</span><span class="n">s</span> <span class="o">*</span><span class="n">Stack</span><span class="p">)</span> <span class="n">PopIf</span><span class="p">(</span><span class="n">v</span> <span class="kt">int</span><span class="p">)</span> <span class="p">(</span><span class="kt">int</span><span class="p">,</span> <span class="kt">bool</span><span class="p">)</span> <span class="p">{</span>
    <span class="k">if</span> <span class="nb">len</span><span class="p">(</span><span class="n">s</span><span class="o">.</span><span class="n">items</span><span class="p">)</span> <span class="o">==</span> <span class="m">0</span> <span class="p">{</span>
        <span class="k">return</span> <span class="m">0</span><span class="p">,</span> <span class="no">false</span>
    <span class="p">}</span>
    <span class="n">lastIndex</span> <span class="o">:=</span> <span class="nb">len</span><span class="p">(</span><span class="n">s</span><span class="o">.</span><span class="n">items</span><span class="p">)</span> <span class="o">-</span> <span class="m">1</span>
    <span class="n">lastItem</span> <span class="o">:=</span> <span class="n">s</span><span class="o">.</span><span class="n">items</span><span class="p">[</span><span class="n">lastIndex</span><span class="p">]</span>
    <span class="k">if</span> <span class="n">lastItem</span> <span class="o">==</span> <span class="n">v</span> <span class="p">{</span>
        <span class="n">s</span><span class="o">.</span><span class="n">items</span> <span class="o">=</span> <span class="n">s</span><span class="o">.</span><span class="n">items</span><span class="p">[</span><span class="o">:</span><span class="n">lastIndex</span><span class="p">]</span>
        <span class="k">return</span> <span class="n">lastItem</span><span class="p">,</span> <span class="no">true</span>
    <span class="p">}</span>
    <span class="k">return</span> <span class="m">0</span><span class="p">,</span> <span class="no">false</span>
<span class="p">}</span>
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



<p>Right off the bat, I noticed:</p>

<ul>
<li>
<code>PopIf</code> was easier to read than my code, with an early return for an empty stack.</li>
<li>
<code>PopIf</code> returns a bool instead of an error to indicate the success or failure of the code.</li>
<li>
<code>PopIf</code> also returns the removed value (or 0, which is the zero value for int in Go).</li>
</ul>

<p>But then I also noticed a few mistakes I made (which, granted, I would probably fix them on my review, but anyway...):</p>

<ul>
<li>Returning a <code>bool</code> instead of an error made way more sense. I just needed to indicate the success or failure of the operation. The meaning of it is something that the caller could take care of anyway.

<ul>
<li>That also helps with making the implementation cleaner because I didn't need to import anything like I was doing with <code>fmt</code>.</li>
</ul>


</li>
<li>There was no need for me to have my own <code>unicodeSlice</code> type. I could make it a slice of the type I needed.</li>
</ul>

<p>Not huge things, probably things I'd refactor right away or someone would get in a code review (in a real-world scenario), but still, things that are important. It took me less than 1 minute to formulate the prompt and get the implementation from the AI. Then a few more minutes to review the generated code and adapt it to my use. </p>

<h2>
  <a name="time-is-money-and-money-is-what-matters-for-capitalism-at-least" href="#time-is-money-and-money-is-what-matters-for-capitalism-at-least">
  </a>
  Time is money. And money is what matters... for capitalism, at least
</h2>

<p>The time it took me to get the AI code and review it was still less than the 15 minutes that it took me to make the initial implementation from scratch, which would still require a quick review. Realistically, I would reward myself with a coffee or a quick walk around the house before getting into the review, so let's put that the final acceptable implementation, without the AI, would take around 40 minutes.</p>

<p>So it's around 10 minutes for the AI guided by the human against 40 minutes for the human aided by search engines. That's what capitalism is going to take into consideration! And I will go as far as saying that maybe that's already part of the reason we're seeing so many layoffs around the world.</p>

<h2>
  <a name="who-am-i-or-who-will-i-become" href="#who-am-i-or-who-will-i-become">
  </a>
  Who am I? Or who will I become?
</h2>

<p>Is AI Code Reviewer a profession of the future? What about designing a whole application? Will there be something like AI Architect Reviewer? Is my next programming language the natural language?</p>

<p>So many questions, so many problems, and so little... time! Damn it! Who am I?</p>...