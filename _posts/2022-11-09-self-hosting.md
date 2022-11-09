---
layout: post
title:  "My take on self-hosting"
date:   2022-11-09 15:45:00 CET
tags: self-hosting
---

This is a write-up of my experience with self-hosting services. I hope it's useful and encouraging to people that wishes to get started in this art.

## Motivation

For some people, I'm a paranoid, I avoid social networks and use Linux. For others, I'm not doing enough, my phone runs Google's spyware disguised as OS and WhatsApp is my main messaging platform. Honestly, I don't care, I just try to stay away from extremes, life is too short to pick all fights, at the same time, whenever possible I like to try alternatives.

Around 2010 I started to use Dropbox, it was like magic, no more sending zip files to my email or having to worry about pen drives. A paid subscription was not an option, I was broke as hell therefore I had to rely on their free tier which was generous for the time's standard, I even able to increase it to 5 GiB if my memory serves me well by completing certain steps like sending referrals. All was fine, I was happy with this new world of cloud services. Its Linux support was not as good as Windows, but it worked decently well.

After some 5ish years Dropbox started to go awry, I don't remember exactly what happened that made me search for alternatives, also by this time I wasn't so comfortable with the idea of my files stored in someone else's computer with arbitrary terms and conditions which may allow them to access and use them somehow. Since I was already using several Google products, it made sense to sell a bit more of my soul to it. Google Drive's free storage quota was much more generous, running out of space became the least of my concerns. One big disappointment though was its Linux support, I couldn't find anything that worked, meaning I had to use its web interface. After some reluctantly I started to use Google Photos, its convenience was too attractive, and its free unlimited storage was an easy sell.

In 2020, everyone was taken by surprise when Google discontinued unlimited storage. Understandable, I could even pay for storage. And yet I found myself again in an uncomfortable position of having to trust a 3rd party with my files, by this time my trust for Google was very different from the time I ditched Dropbox. I thought: I'm not going to put my files to the will of a service provider, even if I pay I cannot fully trust it. As many people were outraged by this move and self-hosting was trending everywhere, I decided to give it a try.

## Preparation

Armed with that motivation, a dusty Raspberry Pi 2 and 64GB SD Card, I set to adventure myself. First I had to decide which OS to install. Ubuntu, Debian or Raspbian didn't appeal to me. Having previous good experience with [Arch Linux ARM](https://archlinuxarm.org) I thought why not. Despite claims out there that Arch is not reliable, I never had any serious trouble with it for the last 7 years as my main system or in 2 years of self-hosting.

Once the OS was installed, another decision had to be made, how to manage services. Some people insist in using packages provided by the distribution. I knew this would have limited success, after all, I couldn't depend solely on packagers and AUR. Some people really like to suffer more than necessary and use Kubernetes for home labs. If you have time, multiple boards and motivation to learn Kubernetes, go ahead, it is just not my case. There is also Portainer and Ansible, which I didn't really consider. Finally, I settled on using Docker with compose files. This approach has been serving me well, there are alternatives, there are even distros (e.g. [Umbrel](https://umbrel.com)) which automate the installation and maintenance of services (I'm not talking about packages and systemd services). For now I'm happy with the balance of control, simplicity and maintenance effort.

![Raspberry Picture]({{ site.url }}/assets/img/raspberry.jpg){:style="display: block; margin:auto"}

## Syncthing

Time to decide which service could replace Google Drive. The obvious contenders were ownCloud and its fork Nextcloud. I wasn't sure which project was more healthy and future-proof. Both were also considerable heavy for my poor Raspberry Pi 2. [Syncthing](https://syncthing.net) seemed a lighter and simpler alternative, people were talking greatly about it. Unfortunately it doesn't provide any graphical interface beyond management of folders and devices. After a bit of back and forth, I had it working on my computers and phone. It works very well and the fact that it can sync even over the internet with relay was a pleasant surprise.

All in all, I'm completely satisfied with Syncthing and I don't have plans to use something else.

## Borg + RClone + Backblaze

Ok cool, so I had synced folders in my laptop, desktop, phone (some folders only) and raspberry. Only two of the 3-2-1 Backup Rule were compliant in this setup. I had to have a copy elsewhere. Every month putting everything in a hard drive and leave it at my mother house? Nope, that's not good. After some research I was confident that an encrypted backup using [Borg](https://www.borgbackup.org) + [Rclone](https://rclone.org) and a cheap storage service such as [Backblaze](https://backblaze.com) was perfect for my case. Borg and Rclone are great pieces of software and Backblaze is easy to set up, reliable and extremely cheap for my backup of 30 GiB, I pay around 50 dollar cents every 6 months. It is also cheap because borg does incremental backups, if you need to download or upload tons of gigabytes then you'll pay for ingress/egress, but it should still cost cents. To properly give credits, I followed most of what is taught in this [article](https://medium.com/@mormesher/building-your-own-linux-cloud-backup-system-75750f47d550).

This is another area I don't have much to complain. To be honest, what I could do better is to automate backups, currently I run a script from my laptop. I know, I'm lazy, but I kinda like seeing the backup being uploaded.

## KeePass

Around the same time was looking into the question of using a password manager. This was one  my of biggest personal tech debt for ages. The obvious options were paid services which are not bad per se, it just that sharing my passwords with a company is insane to me. I don't believe the promises that everything is perfectly encrypted and only I can access my data with a master password. Bitwarden was the obvious candidate, but I was sold on KeePass simplicity, it's just an encrypted file that I could sync with Syncthing. After one evening of generating, resetting and storing passwords in a KeePass file I was thinking why the hell I didn't do this earlier, it was beautiful.

For some services I was using 2 factor tokens managed by Google Authenticator, then replaced by FreeOTP and then later andOTP. As those two projects are unmaintained, I didn't want to have an app just for TOPT tokens and KeePass supports it then why not, it's super convenient (albeit slightless less secure to have all eggs in the same basket). By the way, I use [KeePassXC](https://keepassxc.org) on my laptop and [KeePassDX](https://www.keepassdx.com) on my phone.

## The Lounge

Since 2013 I have been involved in Xfce development. As most of devs were chatting via IRC (then Freenode, now Libera) I needed an IRC client and bouncer. I don't exactly remember what I tried to use, in the end I settled for [The Lounge](https://thelounge.chat). It has a nice web interface and works well on mobile. For some time I had one instance hosted in a Digital Ocean, then I moved it to a free tier Google Cloud VM (around the same time I was going all-in for Google, silly me). Once I was confident with self-hosting, The Lounge was running in my humble Raspberry, it felt good to shut down my GCP account. I admit having it running from home means I get disconnected a few times a day (it's worse since I moved to Germany, gosh, shitty internet here).

The Lounge hasn't changed much since I started to use, which is good, some changes are for the worse. If it goes unmaintained or if I'm willing to try out something new, I will probably check Matrix and its IRC bridge.

## Pi-hole

As I already on the self-hosting bandwagon, [Pi-hole](https://pi-hole.net) seemed a nice addition. It works as promised, indeed blocks a good deal of crap and the only noticeable breakage were Google Ads links. Since I moved to a new apartment (country actually) I didn't set it at the router as the preferred DNS server, I only my laptop is pointing to it. On my phone uBlock Origin does the trick and is not limited to my home Wi-Fi.

I honestly didn't notice any browsing speed-ups as some people claimed, ultimately I could just use uBlock Origin on my laptop as well, for now I'll leave it be.

## File Browser

Syncthing is great and I totally understand its authors for not including a dropbox-like web UI. But I need one. [File Browser](https://filebrowser.org) fits my needs perfectly well, it even replaced pigallery2 as photo viewer. Its built-in text editor is also super useful. The only [glitch](https://github.com/filebrowser/filebrowser/issues/1833) that irritates me is when scrolling down, opening a photo, closing the photo reloads the folder, you have to scroll all the way back to where you were. Hopefully this will be fixed some day.

I'm happy with File Browser, I just wish that glitch was fixed. As a photo gallery it is not extraordinary, I considered installing Photoprism but I didn't like its requirement to have mysql, too much for my little pi.

## Speisekarte

In one company I worked, people memorized servers' IP addresses and which ports certain services were running. The infra guy had some excuse for not having a local DNS with human friendly host names for our local servers. I decided to create a small service that listed our services and if they are up, as it was basically a service menu I called it [Speisekarte](https://github.com/andreldm/speisekarte). It listens to my pi's 80 port and I find it nice to have an overview of what's running. There are more flashy and robust dashboard out there like [Dashy](https://github.com/lissy93/dashy), for now I'm happy with my own solution, I even ported it from Node to Go and to decrease its footprint, also there is no dependency to any JavaScript libraries or anything, it's as lightweight as possible.

## Zerotier

With cloud-based hosted, all my stuff is within reach wherever I go as long as there is an internet connection. I could just have all my files in my phone, but it wouldn't solve my need to check messages in The Lounge. I also could expose a random ssh port and use a dynamic DNS service to deal with IP changes. It would probably work, I was afraid of exposing ports in to the wild world of web. I thought Cloudflare Tunnel could help me in this scenario, probably I didn't understand its purpose, it didn't work as I intended after multiple attempts. Besides, I would start to sell my soul to yet another big company. Then I came across [Tailscale](https://tailscale.com) and [Zerotier](https://www.zerotier.com). Tailscale looked nicer, I just couldn't agree with their stupid requirement of using OAuth login with a Google, Microsoft or GitHub account. I'm not using any OAuth login since I started to use KeePass, I didn't intend to resume now. Then Zerotier was my next best option. After a bit of struggling (not so much actually) it magically worked, I was thrilled to access my services from anywhere, for free! Thanks a lot Zerotier for your free tier.

## Conclusion

After two years of self-hosting I can tell you it is worth it. It feels good not having to rely on unscrupulous corps, it's also great the feeling of owning the hardware and data, and the learning process is a bonus. If you're not tech-savvy or simply don't have the time self-hosting is probably not for you, just try your best to make educated choices. For example, my main email address is managed by [Tutanota](https://tutanota.com), I happily pay for it not because it promises full encryption, but because it's one less thing I don't need to depend on Google's false benevolence. I digress, privacy goes hand in hand with self-hosting but deserves a post on its own.

That's it, if you have any single board computer, or is planning to buy one, I suggest you to consider self-hosting at least for the fun of it, you can start with one of the [many possibilities](https://github.com/awesome-selfhosted/awesome-selfhosted) and see where it goes.
