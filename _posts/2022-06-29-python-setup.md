---
layout: post
title: A Python setup that finally works
author: Vincent Thorne
#last-edit: 2022-06-29
---

My punctual use of Python lead to a rocky situation on my computer: multiple installed versions of Python with some managed by Anaconda, unruly `export PATH`s and multiple virtual environments. It (kind of) worked when I needed to, but I felt a complete lack of control. In short, my computer was the embodiment of xkcd’s [famous comic](https://xkcd.com/1987):

![xkcd comic python environment](https://imgs.xkcd.com/comics/python_environment.png)

That was until my colleague [Matteo](https://ie.linkedin.com/in/matteo-pograxha-b9a822148) took the time the other day to teach me his own protocol to install and maintain a healthy Python ecosystem. This post will walk the reader through the steps that helped me achieve Python sanity on macOS.

## The Steps

These commands are to be run in the terminal. They assume that you have Homebrew installed (which I recommend — [some reasons why](http://web.archive.org/web/20211125121141/https://mouselike.de/introduction-to-homebrew/)): install instructions are available [here](https://brew.sh/).

**Controversial Step 0**: if installed, remove Anaconda completely and clean your `.zshrc` of all `export PATH`s created by Anaconda or conda. More details on [Anaconda’s help page](https://docs.anaconda.com/anaconda/install/uninstall/). Not taking a stance for or against Anaconda/conda here, just advising to clean up old layers of Python before laying the sturdy foundations!

1. Install Python from Homebrew
   `brew install python`
2. Make sure that the `export PATH` in `.zshrc` is set to the one prescribed by Homebrew and that there are no other export paths
   `export PATH="/usr/local/opt/python/libexec/bin:$PATH"`
3. Restart the terminal session
4. Navigate to the directory of the project
   `cd path/to/project`
5. Install virtualenv with pip
   `pip install virtualenv`
6. Create a new virtual environment
   `virtualenv [environment-name]`
7. Activate (source) the new environment
   `source [environment-name]/bin/activate`
8. Install required packages with pip
   `pip install [package]`
9. If necessary later on, upgrade packages
   `pip install [packages] --upgrade`
10. Once done managing the environment, deactivate it
    `deactivate`

## Spyder setup

Accustomed to RStudio and other statistical IDEs, Spyder is a close enough cousin to ease my transition into Python. A few further steps are necessary to link it with the custom environment created above. 

1. Install `spyder-kernels` in the virtual environment
   `pip install spyder-kernels`
   - Depending on your version of Spyder, it might ask you to install a specific version. Try with the version displayed first
     `pip install spyder-kernels==2.3.0`, for example
2. In Spyder preferences
   1. Go to the Python Interpreter tab and select “Use the following Python interpreter”. 
   2. Click on the file icon
   3. In the Finder prompt, navigate to your virtual environment, the bin folder and select the `pyhton` file.
   4. Click OK and restart Spyder
3. Check if it works by `import [package]` a package installed in your virtual environment using the IPython console in Spyder

**Important**: if you create a new virtual environment, you will have to make sure that it has `spyder-kernels` installed (step 1) and re-link Spyder to that new environment (step 2).

## If nothing works

Take a deep breath and ask your knowledgeable friends and colleagues to take a look at your computer and help you figure things out. There is light at the end of the Python tunnel!