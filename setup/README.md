Here is a short technical description on how the setup scripts work.

#### Directory structure
<table>
    <tr>
        <td><code>README.md</code></td>
        <td>You are reading it ;)</td>
    </tr>
    <tr>
        <td><code>setup-{config}.sh</code></td>
        <td>the script that contains the steps needed to intialize/update the corresponding <code>{config}</code></td>
    </tr>
    <tr>
        <td><code>packages-{config}</code></td>
        <td>the required package names for the particular <code>{config}</code>, separated by newlines</td>
    </tr>
    <tr>
        <td><code>links-{config}</code></td>
        <td>symbolic links that are required to be present in the system, in the following format: <code>{link name}:{target relative to $HOME/dotfiles}</code>, separated by newlines</td>
    </tr>
    <tr>
        <td><code>system.sh</code></td>
        <td>this script sets up basic things that are needed to run an Arch based system after fresh install</td>
    </tr>
    <tr>
        <td><code>setup.vim</code></td>
        <td>this installs/updates Neovim plugins if needed</td>
    </tr>
    <tr>
        <td><code>helpers.sh</code></td>
        <td>this contains common functions for all setup scripts, handles their dependencies, etc.</td>
    </tr>
</table>

#### Creating a new configuration
- create a `setup-xxx.sh` script, with the desired name
- use this template to get started:
```bash
#!/bin/bash
set -e                  # recommended, as if a step fails, we don't want to continue
source "helpers.sh"     # required

# do stuff here
```
- all you need in reality is to `source "helpers.sh"`, then your config will be accounted for
- if your configuration has some pacman packages that are needed, eg. a program that you want to customize:
    - create `packages-xxx` with the corresponding config name
    - add your packages' names there, and they will be automatically handled before your setup script runs
- if you want to modify some configuration file in the system, then you should symlink it to our dotfiles folder somewhere like so:
    - create `links-xxx` with the corresponding config name
    - specify where your configuration file is (or folder) in the system, separate it with a colon, and the target config inside the dotfiles folder: `{link}:{target}`
- if your config depends on other configs, then refer to the `setup_dependency` function

#### Script helper functions
see examples in present script files

---

```j
include_text {text_to_include} {target_file}
```
Makes sure that a line of text is present in a file, if not, it appends it.
This is useful if you don't want to overwrite the file completely, thus not symlinking it,
only a part of it is important.

---

```j
setup_dependency {setup_config_name}
```
With this present in your setup script, you ensure that the dependent config is set up before yours. Currently only one of these are supported per setup script.
You are free to call any other script file, but not existing config scripts. In that case use this helper.

---

more will be added as needed
