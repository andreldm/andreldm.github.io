---
layout: post
title:  "Getting started with Xfce collaboration"
date:   2018-06-30 20:20:00
tags: Xfce Open Source
---

<!--
Check these:
https://mail.xfce.org/pipermail/xfce4-dev/2018-June/032137.html
https://ceph.com/contribute/
-->

Once in while someone comes around and ask how he/she could help Xfce, unfortunately there is no one-size-fits-all answer, actually to properly give meaningful guidance, a couple of questions should be asked first, e.g. do you have any programming skills? What exactly do you want to improve?
It's been a long time since I've been planning to write a comprehensive guide, I hope this to be helpful to newcomers.

## What is to be done?

As any open source project, there are several ways to collaborate, and everyone is welcome to help in any or many ways he likes.

### Translation

Our translators do an amazing work, most of major languages are constantly updated, I really appreciate their effort. But don't feel unmotivated, there is always place of improvement, especially if you speak any of the not so updated languages.

Xfce uses gettext which generates .po files from source code. You can view these files on any Xfce component repository, for example [Thunar](https://git.xfce.org/xfce/thunar/tree/po).

Fortunately, translators don't need to know terminal commands or any complex tool, since Xfce translations are handled in [Transifex](https://www.transifex.com/xfce/), a web-based translation platform. At that link you can see the overview of the current status of translations.

Once you sign up, you can ask to join the a translation team. Be patient, it may that a while to a coordinate to approve. If you think you request is taking longer than it should, please poke us vie the [translation mailing list](https://mail.xfce.org/mailman/listinfo/xfce-i18n) or directly at IRC channel #xfce-dev (more about this latter).

After joining a team, transifex should be quite intuitive, there is even a comments section in case of doubts for a particular text to be translated, but developers are not notified, so I recommend to use the mailing list or [bug tracker](https://bugzilla.xfce.org/).

### Donations

If you have some spare coins to donate to Xfce, the official way to do so is via [Xfce's bountysource page](https://www.bountysource.com/teams/xfce). You can donate to the organization itself or put a reward of a specific bug. The money is more than welcome, but we are not actively making use of it, that's why I hint donators to place rewards for things they expect. Yet, even if you make a hefty donation, remember this is an open source project 100% run by volunteers, no one is implicitly obliged to act upon your requests.

### Bug Reporting / Testing

If you are an enthusiast, always looking for new features, this could be of your interest.

### Coding

This is the most effective way to help, we really need people tinkering Xfce's components. You don't have to be ninja, just basic knowledge of programming, preferably C, and the desire to learn. Speaking of which, some people are scared C, because they heard it's too low level... Fear not, the language is quite simple. Yes, there are pitfalls and gotchas, as any other language, but the experience is improved by gtk's and glib's utility functions and abstractions.

The recommended way to start is to scratch your own itch, you know, that bug that is bothering you or a behavior that could be improved. Browse [Xfce's Bugzilla](https://bugzilla.xfce.org/) and look for that bug or report it. Then go to [Xfce's repository browser](https://git.xfce.org/) and clone the repository for the component you are about to hack. The first thing you need to do is to build and run that component, I'm going to use xfce4-appfinder as an example:

```
git clone git://git.xfce.org/xfce/xfce4-appfinder
cd xfce4-appfinder
./autogen.sh --prefix=/usr --enable-debug
make
```

The `./autogen.sh` command might fail if you don't have the development packages for dependencies, unfortunately it's hard to give instructions since package names vary between distributions, searching by the error message can be help a lot. The `--prefix=/usr` option is useful if you want to install the component on your system (with `sudo make install`), it means to replace the version provided by the system package manager. Be aware that daily usage of development builds is cool because of unreleased fixes and new features, but it's also risky because new bugs can be introduced or due incompatibilities with stable components. The `--enable-debug` allows interesting things for development such as debugging with gdb, more detailed backtraces and compiling warnings.

After `make`, the binary is ready to run, however xfce4-appfinder and some other components run in background (daemon mode), so we need to make sure to kill it with `pkill -i xfce4-appfinder`. Now from the root of the repository, run `src/xfce4-appfinder`. Congratulations, you have just built your first component!!!


#### GTK Inspector

Now that almost all components are gtk3-based, 

#### Communication

[tell about #xfce-dev, the mailing lists and to be patient]

#### Recommended reading

* http://gezeiten.org/pre-2014/post/2012/11/How-to-start-contributing-to-Xfce-or-any-other-open-source-project
* https://people.gnome.org/~swilmet/glib-gtk-book/
