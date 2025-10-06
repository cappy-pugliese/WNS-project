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
conda env export -n pcangsd -f /home/FCAM/cpugliese/bin/pcangsd_env.yml --no-builds
# no builds argument will make it so it ignores platform-specific builds (if there's trouble downloading dependencies)
```