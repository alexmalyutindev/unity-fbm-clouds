FBM Parallax Clouds for Unity build-in render pipeline.
==========

[![Build](https://github.com/alexmalyutindev/unity-fbm-clouds/actions/workflows/upm-ci.yml/badge.svg)](https://github.com/alexmalyutindev/unity-fbm-clouds/actions/workflows/upm-ci.yml)
[![Release](https://img.shields.io/github/v/release/alexmalyutindev/unity-fbm-clouds)](https://github.com/alexmalyutindev/unity-fbm-clouds/releases)

Clouds are using Fractal Brownian Motion and Raymarching prarallax offset method:

![anim](https://github.com/alexmalyutindev/unity-fbm-clouds-buildin/blob/master/Recordings/gif_animation_001.gif)

Installation
------------
Find the manifest.json file in the Packages folder of your project and add a line to `dependencies` field:

* `"com.alexmalyutindev.fbm-parallax-clouds": "https://github.com/alexmalyutindev/unity-fbm-clouds.git#latest"`

Or, you can add this package using PackageManager `Add package from git URL` option:

* `https://github.com/alexmalyutindev/unity-fbm-clouds.git#latest`

Or, use [UpmGitExtension](https://github.com/mob-sakai/UpmGitExtension) to install and update the package.

References
----------

- [Fractal Brownian Motion](https://thebookofshaders.com/13/)
- [Parallax](https://catlikecoding.com/unity/tutorials/rendering/part-20/)

License
-------

Copyright (C) 2021 Malyutin Alexandr

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.