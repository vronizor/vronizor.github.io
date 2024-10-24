---
layout: post
title: yt-dlp for rookies
author: Vincent Thorne
#last-edit: 2022-06-29
---

yt-dlp is a powerful program that let's you download audio and video content for a large variety of websites. yt-dlp is a program which you interact with from the terminal (a command-line interface, or CLI). This tutorial is for my dear readers who have no idea on how to install and run programs from the terminal, just like me a couple of years back.

## The Steps

1. Open the terminal (Cmd+space, type "terminal", press enter)
2. Install **[Homebrew](https://brew.sh/)**
   
   `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`
   
   Enter your password (no characters will show: this is normal) and press enter. Say yes/press enter when required.

   Homebrew is a package manager: it lets you download programs, their dependencies (other programs they rely on to work) and helps you keep them up to date.
   
3. Install **[yt-dlp](https://github.com/yt-dlp/yt-dlp/)**

   `brew install yt-dlp`

   This will install the program and all its dependencies.

4. Install **[ffmpeg](https://www.ffmpeg.org/)**

   `brew install ffmpeg`

   This is a program that converts content in different audiovisual formats.

5. Download your content ([full yt-dlp options](https://github.com/yt-dlp/yt-dlp/#usage-and-options)). [These websites](https://github.com/yt-dlp/yt-dlp/blob/master/supportedsites.md) are supported.
   1. If you just want the audio, a command like the following should do the job (don't forget to input the URL!):

      `yt-dlp --extract-audio --ignore-errors --no-warnings --no-check-certificate --audio-format mp3 --embed-thumbnail --restrict-filenames -o '%(title)s.%(ext)s' [url_of_video_or_audio]`

      Importantly, all the options are optional, i.e., the command will download you *something*! By default yt-dlp will download the video if it's a video, and an audio file if it's a radio show or song. Quick explanation of the options in this case:
      - `--extract-audio`: only extract the audio
      - `--ignore-errors --no-warnings --no-check-certificate`: technical stuff so that the program doesn't crash/complains too much.
      - `--audio-format mp3`: convert output to mp3
      - `--embed-thumbnail`: use the thumbnail of the video as the "album cover"
      - `--restrict-filenames`: clean the filenames of weird characters and spaces
      - `-o '%(title)s.%(ext)s'`: specify the naming of the output. Here it will take the title of the video/audio file, add a "." and write the file extension. An example will be: `Chic_–_Soup_for_One.mp3`. More on outputs (for example, what variables you can extract from the video and add to the filename) can be found [here](https://github.com/yt-dlp/yt-dlp/?tab=readme-ov-file#output-template).
      - Note: you can also pass a YouTube **playlist** URL, and it will download all the content of the playlist! I usually then modify the output format as follows:

         `-o '%(playlist)s/%(playlist_index)03d_%(title)s.%(ext)s'`

         This downloads each video/audio of a given playlist in a playlist-specific folder, and adds the index (i.e., order) of the video within the playlist at the start of the filename.

   2. If you want a video, here is a good command to start with:

      `yt-dlp --restrict-filenames --write-subs --convert-subs srt --embed-subs --remux-video mkv -o '%(title)s.%(ext)s' [url_of_video]`

      This will download the video and all subtitles and make it an mkv (container) file. It is also possible to get multiple audio streams (languages) but I have never tried: search for `--audio-multistreams` in the option page and on Google (adding `yt-dlp` to your query, of coure) ;-].

6. Controlling where the files will be downloaded. There are two different ways of doing this.
   1. [preferred method] In the terminal, navigate to the destination folder using `cd path/to/folder`. `cd` stands for "current directory" where the terminal is "working from". Then just run one of the above commands and the audio or video file should appear in that folder.
   2. Instead of navigating to destination directory, pass the full path of the destination folder to the `-o` (output) option:

      `-o 'full/path/to/dir/%(title)s.%(ext)s'`
      
      The path should be from the root of your machine. To get any folder's full path, select it in the Finder and type Cmd+Alt+c: the full path will be in your clipboard, and you just need to paste it (Cmd+v) anywhere. You can also right-click on a folder, keep Alt pressed, and click on "Copy "[directory]" as Pathname".



