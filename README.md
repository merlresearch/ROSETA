<!--
Copyright (C) 2017-2023 Mitsubishi Electric Research Laboratories (MERL)

SPDX-License-Identifier: AGPL-3.0-or-later
-->

# Robust Online Subspace Estimation and Tracking Algorithm (ROSETA)

This script implements a revised version of the robust online subspace estimation and tracking algorithm (ROSETA) that is capable of identifying and tracking a time-varying low dimensional subspace from incomplete measurements and in the presence of sparse outliers. The algorithm minimizes a robust l1 norm cost function between the observed measurements and their projection onto the estimated subspace. The projection coefficients and sparse outliers are computed using a LASSO solver and the subspace estimate is updated using a proximal point iteration with adaptive parameter selection.

This script implements a revised version of the robust online subspace estimation and tracking algorithm (ROSETA) that appeared in:

[1] Mansour, H., Jiang, X., "A Robust Online Subspace Estimation and Tracking Algorithm", IEEE International Conference on Acoustics, Speech, and Signal Processing (ICASSP), DOI: 10.1109/​ICASSP.2015.7178735, April 2015, pp. 4065-4069.

A description of the improved ROSETA appeared in:

[2] Mansour, H., "A Short Note on Improved ROSETA," arXiv:1710.05961, 2017.

The algorithm is capable of identifying and tracking a time-varying low dimensional subspace from incomplete measurements and in the presence of sparse outliers. The algorithm minimizes a robust l1 norm cost function between the observed measurements and their projection onto the estimated subspace. The projection coefficients and sparse outliers are computed using a LASSO solver and the subspace estimate is updated using a proximal point iteration with adaptive parameter selection.

## Usage

To run the script with the example data set, simply run the file `motion_separation.m` in MATLAB.

## Citation

If you use the software, please cite our publication as follows:

```Bibtex
@inproceedings{Mansour2015apr1,
    author = {Mansour, H. and Jiang, X.},
    title = {A Robust Online Subspace Estimation and Tracking Algorithm},
    booktitle = {IEEE International Conference on Acoustics, Speech, and Signal Processing (ICASSP)},
    year = 2015,
    pages = {4065--4069},
    month = apr,
    publisher = {IEEE},
    doi = {10.1109/ICASSP.2015.7178735},
    url = {https://www.merl.com/publications/TR2015-027}
}

@misc{mansour2017short,
      title={A Short Note on Improved ROSETA},
      author={Hassan Mansour},
      year={2017},
      eprint={1710.05961},
      archivePrefix={arXiv},
      primaryClass={cs.NA},
      url={https://www.merl.com/publications/docs/TR2017-154.pdf}
}
```

## Contact

Hassan Mansour: mansour@merl.com

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for our policy on contributions.

## License

Released under `AGPL-3.0-or-later` license, as found in the [LICENSE.md](LICENSE.md) file.

All files:

```
Copyright (C) 2017-2023 Mitsubishi Electric Research Laboratories (MERL).

SPDX-License-Identifier: AGPL-3.0-or-later
```
