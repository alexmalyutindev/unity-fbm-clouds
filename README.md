FBM Parallax Clouds for Unity build-in render pipeline.
==========

[![Build](https://github.com/alexmalyutindev/unity-fbm-clouds/actions/workflows/upm-ci.yml/badge.svg)](https://github.com/alexmalyutindev/unity-fbm-clouds/actions/workflows/upm-ci.yml)
[![Release](https://img.shields.io/github/v/release/alexmalyutindev/unity-fbm-clouds)](https://github.com/alexmalyutindev/unity-fbm-clouds/releases)

Clouds are using Fractal Brownian Motion and Raymarching prarallax offset method:

![anim](https://github.com/alexmalyutindev/unity-fbm-clouds-buildin/blob/master/Recordings/gif_animation_001.gif)

Installation
------------
### Using git: 
Please add the following line to `dependencies` sections to the package manifest file (`Packages/manifest.json`).

- `"com.alexmalyutindev.fbm-parallax-clouds": "https://github.com/alexmalyutindev/unity-fbm-clouds.git#latest"`

Or, you can add this package using PackageManager `Add package from git URL` option:

- `https://github.com/alexmalyutindev/unity-fbm-clouds.git#latest`

### Via NPM Registry:
Please add the following sections to the package manifest file (`Packages/manifest.json`).

To the `scopedRegistries` section:

```
{
  "name": "Alex Malyutin",
  "url": "https://registry.npmjs.com",
  "scopes": [ "com.alexmalyutindev" ]
}
```

To the `dependencies` section:

```
"com.alexmalyutindev.fbm-parallax-clouds": "1.0.0"
```

References
----------

- [Fractal Brownian Motion](https://thebookofshaders.com/13/)
- [Parallax](https://catlikecoding.com/unity/tutorials/rendering/part-20/)

License
-------
This project is MIT License - see the [LICENSE](LICENSE.md) file for details
