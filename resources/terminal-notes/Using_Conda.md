# Using Conda

on xanadu:

`module load anaconda3/4.1.1`

## Creating an environment

```{bash}
## code Andrius suggested I use
module load anaconda3/4.1.1
conda create -n pcangsd # -n --> name environment
source activate pcangsd
conda install pip
pip install pcangsd
# got an error about "SRE module mismatch" when trying to run pcangsd


## installing pcangsd (directions from github)
conda env create -f pcangsd/environment.yml
# conda *env* create lets you specify what to add into the environment
# can also use `conda env update` instead of `create` to add to an existing environment
conda activate pcangsd
```

-   conda activate \<env_name\>

-   conda deactivate

to rename, go into conda directory and change the env directory name itself

```{bash}
conda env update -n pcangsd -f /home/FCAM/cpugliese/bin/pcangsd_env.yml
# got error
    # Solving environment: failed 
    # ResolvePackageNotFound: 
    # [long list of package names]

conda env export -n pcangsd -f /home/FCAM/cpugliese/bin/pcangsd_env.yml --no-builds
# no builds argument will make it so it ignores platform-specific builds (if there's trouble downloading dependencies)
# didn't work --> errors similar to the original SRE module mismatch

conda env export -f /home/FCAM/cpugliese/bin/pcangsd_env.yml --format yml --no-builds
# also didn't work
# needs to be run inside an active envirionment or provide env name (with -n)
# also --format is not an actual option here. love when documentation doesn't actually line up with the different verions
```

```{bash}
conda env create -f /home/FCAM/cpugliese/bin/pcangsd_env.yml -n test
#Using Anaconda Cloud api site https://api.anaconda.org
#Solving environment: failed


```

```{bash}
#miniconda3
conda create -f /home/FCAM/cpugliese/bin/pcangsd_env.yml -n pcangsd
```

```{bash}
### conda install command ###
pcangsd dependencies:
python>=3.10
cython>3.0.0
numpy>2.0.0
scipy>1.14.0
pip

conda install --file /home/FCAM/cpugliese/bin/miniconda3/envs/pca2/pcangsd_dependencies.txt
```