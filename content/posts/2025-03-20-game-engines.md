---
date: "2025-03-20T16:11:00Z"
tags:
  - Gamedev
title: Exploring Game Engines
slug: game-engines
---

About one year ago I tried to create a game that I can summarize as a [Commandos](https://en.wikipedia.org/wiki/Commandos_(series)) but with spaceships. Even though Java is the language I have the most experience with, the game engines I found just didn't click for me. Getting started was brittle, ideas were overflowing, and I was losing time. So, I picked [Phaser](https://phaser.io/), as JavaScript is (was?) the next best thing for me.

As I said, in the beginning, ideas for the game were popping up by the second. Phaser was really easy to get up and running. Unfortunately, JavaScript started to annoy me, I dearly missed type safety. If only JS was strongly typed... well, it is, in the form of TypeScript. Switching to TypeScript was easier than I thought. There are a couple of templates out there showing how to use Phaser + TypeScript + Vite. After a couple of weeks, I started hitting some walls. The player movement wasn't working as I wanted. To be honest, I wasn't even sure how it should be. To add insult to injury, I didn't really like TypeScript. My memory is fuzzy, but I recall having issues with interfaces, my Java-based assumptions didn't apply to TypeScript.
After a while, with my frustration growing and my free time shrinking, I ~~gave up~~ paused this project indefinitely.

Recently I decided to resume my foray into game development. I knew I had to take a completely different approach. My plan was to start humbly: pick a dead-simple game and reimplement it, then move on to another, slightly more complex one. Rinse and repeat until I feel confident tackling something ambitious again. If I never feel competent enough, at least I had fun trying.

As the game to reimplement, I chose [2048](https://github.com/gabrielecirulli/2048). Needless to say, it's ultra simple, hard to find something simpler. Game chosen, should I implement it with Phaser? Not really. Maybe I failed because I used the wrong technology. Maybe it was entirely my fault. Most likely a mix of both. I needed to avoid repeating the same mistakes. For this reason, I set out to experiment with other game engines.

About 20 years ago, when I was learning programming, there were some nice options for libraries and game engines. Off the top of my head, I remember [Allegro](https://liballeg.org/), [SDL](https://www.libsdl.org/), [Irrlicht](https://irrlicht.sourceforge.io/) and [Ogre3D](https://www.ogre3d.org/). Allegro was the one I used the most and I have fond memories of it. I'm glad to see they are all still maintained after so many years.

However, I knew that writing a game in C/C++ is an uphill battle, I would lose valuable time worrying about memory management, string manipulation, cross compilation, etc. Things that are solved in high level languages.

After looking around a bit, I chose [Heaps](https://heaps.io/) and [Godot](https://godotengine.org/). They are nothing alike, which might give me a broader perspective. I also decided to implement the game using Phaser again to give me a baseline for comparisons.

Below I report **my impressions**, they are **very subjective** and I don't claim the approach I used in each case is the optimal one. I'm convinced there are better ways to implement the game using each technology's best practices. That said, I still believe this evaluation gives me solid hints for choosing a game engine for my future projects.

To provide context for the numbers below, I used Arch Linux running on a ThinkPad T480s (i5-8350U, 12GB ram). And for the sake of simplicity, I'm using "game engine" as an unifying term for libraries, frameworks, engines, etc.

Source code can be found [here](https://github.com/andreldm/2048).

### Phaser

I reused the basic setup from my abandoned project, which used TypeScript/Vite and some existing code. This probably saved me an entire evening (my loose time measure, which amounts to about 4 hours).

Implementing the game was a bit more challenging than I expected. I can't say Phaser or TypeScript stood in my way, but TypeScript still doesn't feel exactly ergonomic to me. Being strongly typed makes it much more tolerable than JavaScript though.

#### The good
* Comprehensive documentation, web searches yield good results and even ChatGPT provides decent answers.
* Calls itself a framework and I agree, it has many batteries included.

#### The bad
* Wrapping the game for desktop means shipping an entire browser, which is overkill.
* The visual editor is paid. It's not expensive, but I'd only consider buying it if I was deeply invested in Phaser.

#### The ugly
* No built-in 3D support, which could be an issue depending on the project.

#### Summary

| Evaluated item | Results | Comments |
| --- | --- | --- |
| Build time (JS) | 8s | |
| Build time (Electron) | 21s| |
| Build time (Tauri) | 3m53s | |
| Electron folder size | 428MiB | 126MiB zipped |
| Electron memory usage | 795MiB | 8 processes |
| Tauri .deb file | 2.9MiB | 8.7MiB executable, 6.7MiB after strip |
| Tauri memory usage | 625MiB | 3 processes |

![2048 built with Phaser](/assets/img/2048-phaser.png)

Judging only by the numbers it may seem to be slow to build, but in practice it isn't, with Vite and the TypeScript compiler, whenever I saved a file I could see my changes instantly in the browser.

For browser-based games, Phaser is a great choice. However, for games that should also run on desktops or phones, its footprint might be an issue. My only gripe is that TypeScript is far from my favorite language.

### Heaps

I first learned about Haxe and eventually Heaps when reading the [Papers, Please porting process](https://dukope.com/devlogs/papers-please/mobile/) to phones. The list of games made with Heaps has some impressive ones and overall it looked like an interesting technology, but I wasn't convinced it was a viable option and wanted to rule it out.

Setup was painful, I spent two evenings wrestling with HashLink to get it working and build an executable. Most issues stemmed from using the latest release (1.14); building from Git master solved them. Part of that time was also spent learning about the technology itself: why Haxe was created, its build targets and why HashLink exists.

After that, porting the code from Phaser was mostly smooth. I really liked the language syntax, it felt very familiar and straightforward.

#### The good
* I liked Haxe more than TypeScript.
    * Much less occurrences of `this.`.
    * No nonsense public/private, interfaces/classes and modules.
    * No nonsense getter/setter.
    * Porting the code from TypeScript felt like simplifying it.
* Surprisingly good experience in VS Code (though I didn't try debugging).

#### The bad
* Community and ecosystem are alive but not as active as before (at least that's my impression).
    * Not nearly as big as Godot or TypeScript in terms of tooling.
    * Many libraries in Haxelib are unmaintained.
* Tweaking the tweening library (Actuate) for smooth animations was tricky, it doesn't support Heaps out of the box.
* Default font is primitive; I had to generate a custom font using LibGDX's Hiero. The result is not perfect, needs more tweaking.
* Fewer built-in features compared to Phaser or Godot; even tweening requires an extra library.

#### The ugly
* The change-compile-check loop is slower than Phaser/TypeScript/Vite by default.
  * Can be much improved with: `haxe -v --wait 8000` and [watchexec](https://github.com/watchexec/watchexec).
  * Hot reload is also extremely handy.
* ChatGPT isn't as helpful as it was for Phaser and Godot.
* Arrays lack functions such as `forEach` and `find`.

#### Summary

| Evaluated item | Results | Comments |
| --- | --- | --- |
| Build time (JS) | 3s | |
| Build time (OpenGL/HashLink) | 4s| |
| Build time (Native/HashLink) | 44s | |
| JS script size | 2.4MiB | 1.4MiB after uglify |
| Executable size | 5.4MiB | 4.5MiB after strip + 1.5MiB if you count Heaps libs in /usr/lib |
| Memory usage | 170MiB | single process |

![2048 built with Heaps](/assets/img/2048-heaps.png)

Haxe/Heaps completely exceeded my expectations. Despite the rough edges, once you have a working setup they are quite sharp tools. The generated binary as well as the JS code are incredibly efficient. I also can't help to feel this is a proper way to build games, with Phaser it feels like we're cheating, I know this is naive way of thinking, most of the users don't care about the underlying tech, that's just my gut feeling.

For small games I think Haxe/Heaps is a good bet, my only concern is how much time needs to be spent filling the gaps of features the engine does not provide, to some degree this concern also applies to Phaser.

### Godot

If you never heard of Godot you probably live under a rock. I think it's safe to say it's the most advanced and popular open-source game engine. It gained a lot of attention after Unity's disastrous licensing changes. I'm not exactly comfortable with having an editor at the center of development, I'm used to text-only development, but I needed to give this a try.

#### The good
* All the features one can imagine are already included; if you're missing something, you're way past amateurism.
* Once you get used to the concept of Scenes and Nodes, it's actually quite straightforward.
* The documentation is good, I wouldn't say it's much better than the others, but what stands out is the sheer amount of material available online. In that regard, Godot is unbeatable.

#### The bad
* The editor is slow to start, sometimes hangs and even crashed once.

#### The ugly
* GDScript is okay, it doesn't get in my way, but the syntax is sometimes weird, just like Python.
* Despite the huge amount of documentation, ChatGPT wasn't very helpful. In some cases, it suggested things that simply don't exist.

#### Summary

| Evaluated item | Results | Comments |
| --- | --- | --- |
| Build time (web) | 2s | |
| Build time (linux) | 2s | |
| Exported web assets | 42MiB | 9 files, including a WASM binary |
| Executable file size | 66.4MiB | strip and upx break it |
| Memory usage | 120MiB | single process |

![2048 built with Godot](/assets/img/2048-godot.png)

Building is blazingly fast, I can't complain about this. The binary it produces isn't as small as the one generated by Heaps, but it uses less memory and I suspect it's much more self contained (i.e. fewer dependencies).  The web export, on the other hand, is a bit bloated, it even features a loading screen. I get that for a medium-sized game, this is only a minor inconvenience, but I just don't think 40MiB of assets is justifiable for small games.

To my surprise, I was able to easily port the game logic from Phaser/Heaps, I was expecting the editor to stay in my way, actually no, I felt like the editor is mostly optional, it's possible to do (almost?) anything with only code. Conversely, I was too biased after using Phaser and Heaps, I believe there is more Godotic (is that a word?) way of implementing using more of the editor.

### Next steps

At the end of this little adventure, I'm super happy with the results. For better or worse, there is no clear winner, Phaser excels at being web-native, Godot is the feature king, while Heaps is simply fun to work with.

The next game to reimplement will be [Bust-A-Move](https://en.wikipedia.org/wiki/Puzzle_Bobble) and for that I'm going to pick Godot. Why? Because it's the most versatile of the three engines covered here. Whatever games I decide to make in the future, there's a good chance Godot will be a good fit. If I get stuck during those remakes or simply get tired of Godot, Heaps is my plan B. Another engine worth mentioning is Defold, that's my plan C.

In the end, I would like to close with [Nicolas Cannasse](https://github.com/ncannasse)'s (Haxe and Heaps creator) wisdom:

> Enjoy and don't forget that while good tools help making good games, they are not the games themselves.
