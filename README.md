## Forward modeling of 3D gravity anomalies using high-order Gaussian quadrature

*Copyright (c) 2024 by Central South University, China. All Rights Reserved.*

>This program uses high order Gaussian orthogonality to calculate gravity anomalies and gravity gradient anomalies for cuboid models. The program is written in MATLAB language. The project complies with the MIT open source protocol and is free to use and modify. 

### Contributors

Y. Yang [OCRID](https://orcid.org/0009-0002-4733-6663) X. Tong [OCRID](https://orcid.org/0000-0001-8641-9360) and H. Li.

Contact by <yangyaokun@csu.edu.cn>.

<!-- ### Citing

>If you use the `GaussQuadrature_3dGravity` in your research, please cite the following paper:

- Y. Yang and X. Tong. (2024). Forward modeling of 3D gravity anomalies using high-order Gaussian quadrature.

```tex
@article{yang2024gaussian,
  title={Forward modeling of 3D gravity anomalies using high-order Gaussian quadrature},
  author={Yang, Yaokun and Tong, Xiaozhong},
  journal={},
  volume={},
  number={},
  pages={},
  year={2024},
  publisher={}
}
``` -->

### Notice

**It is recommended that you use a version no later than MATLAB R2019b.** We also recommend that you use the latest version of MATLAB software like MATLAB R2024b. If you run into problems with other versions of MATLAB, you can [submit an issue](https://github.com/PourRevenir/GaussQuadrature_3dGravity/issues)  or send an email to us.

### Starting

1. Clone the repository to your local machine.
   
```bash
$ git clone https://github.com/PourRevenir/GaussQuadrature_3dGravity.git
```

2. Open MATLAB and navigate to the cloned repository. Then, run the command to add the repository to the MATLAB path.

```matlab
>> PATH
```

3. Open the `main.mlx` file and try the script.

### Model

The real model used in the article comes from [SEG/EAGE Salt and Overthrust Models](https://wiki.seg.org/wiki/SEG/EAGE_Salt_and_Overthrust_Models).

We provide a python program to do this, just run `download.py`.

### Contributing

All constructive contributions are welcome, e.g. bug reports, discussions or suggestions for new features. You can either [open an issue on GitHub](https://github.com/PourRevenir/GaussQuadrature_3dGravity/issues) or make a pull request with your proposed changes. Before making a pull request, check if there is a corresponding issue opened and reference it in the pull request. If there isn't one, it is recommended to open one with your rationale for the change. New functionality or significant changes to the code that alter its behavior should come with corresponding tests and documentation. If you are new to contributing, you can open a work-in-progress pull request and have it iteratively reviewed.

### Contents

```shell
├─Figure
├─Test
├─Source
├─Data
│  └─Color
│      └─src
├─.vscode
└─Model
    ├─3-D_Salt_Model
    │  ├─ClassicA
    │  ├─README
    │  │  └─INFO
    │  ├─SURFACES
    │  ├─ClassicB
    │  └─VEL_GRIDS
    │      └─SALTF
    ├─marmosi
    └─Salt_Model_3D
        └─3-D_Salt_Model
            ├─ClassicA
            ├─README
            │  └─INFO
            ├─SURFACES
            ├─ClassicB
            └─VEL_GRIDS
```

### References

- [Mathworld Wolfram](https://mathworld.wolfram.com/GaussianQuadrature.html)
