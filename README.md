# BasicRFM
This repository contains code to perform inference in the random function model as described in:

```
Random function priors for exchangeable arrays with applications to graphs and relational data
James Robert Lloyd, Peter Orbanz, Zoubin Ghahramani, Daniel Roy
Neural Information Processing Systems, 2012
```
The paper can be found on [nips.cc](https://proceedings.nips.cc/paper/2012/hash/df6c9756b2334cc5008c115486124bfe-Abstract.html).
## Usage 
1. Change your Matlab working directory to this folder.
2. Open highschool_predict.m or highschool_plot.m or clique_plot.m.
3. Run the code.

Contact [James Robert Lloyd](http://mlg.eng.cam.ac.uk/lloyd/) for more information if required.

### Warning
Exit Matlab after every execution to reset the environment. If you run the code repeatedly without exiting Matlab in between, the results will deviate from the published results.


## Original Code
The code in the main branch is cleaned, with any superfluous code removed. The full original code can be downloaded from the [website](https://jamesrobertlloyd.com/assets/BasicRFM.tar.gz) of the first author or from [github](https://github.com/adiehl96/BasicRFM/files/8727738/BasicRFM.tar.gz). Alternatively, it can be viewed on the branch [original](https://github.com/adiehl96/BasicRFM/tree/original). The only changes done on the branch original are the following:
* Added .gitignore files to the directories `DataFolds` and `PartialResults`. These are empty directories that hold temporary files, which are needed to run the code.
* Fixed the geweke test code, changes can be viewed [here](https://github.com/adiehl96/BasicRFM/commit/bdeca39e0cdca3c7a90411fab4cb431a8e5be078).

## License
Copyright (C) 2013, [James Robert Lloyd](https://github.com/jamesrobertlloyd)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
