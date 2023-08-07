- [Introduction](#introduction)
  - [Requirements](#requirements)
  - [For Windows user](#for-windows-user)
    - [Install WSL](#install-wsl)
    - [Install Docker desktop](#install-docker-desktop)
    - [Set VS Code up](#set-vs-code-up)
    - [Clone sppmg/TW\_Thesis\_Template and use](#clone-sppmgtw_thesis_template-and-use)
  - [For Ubuntu user](#for-ubuntu-user)
  - [Tips and Hints](#tips-and-hints)
  - [Trouble shooting](#trouble-shooting)
    - [Trouble in starting WSL remote](#trouble-in-starting-wsl-remote)
  - [References](#references)


# Introduction

This tutorial guides you how to work on your latex project in container, using VSCODE as editor.

The Dockerfile helps you to set the environment for [sppmg/TW_Thesis_Template](https://github.com/sppmg/TW_Thesis_Template).

In `Dockerfile`, 
the container is built upon [qmcgaw/latexdevcontainer](https://github.com/qdm12/latexdevcontainer) with tag `latest-full`. It is big (image size ~2GB) but allows full functionalities. In Dockerfile, you can use `FROM qmcgaw/latexdevcontainer` but Chinese support and some of the features might not work.

In `devcontainer.json`, useful extensions are prescribed and will be automatically installed if you build the container through VSCode following the instructions below.

The use is easy, 
- open any of the `main.tex`, edit then save, the pdf file will automatically be compiled. 
- `ctrl+alt+V` to view pdf in the side panel
- `ctrl+alt+X` to open the side bar; you can manually select recipe for your tex file compilation there.


## Requirements

- [VS code](https://code.visualstudio.com/download) installed
- [VS code remote containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) installed
- [Docker](https://www.docker.com/products/docker-desktop) installed and running
- [Docker Compose](https://docs.docker.com/compose/install/) installed


## For Windows user

The following additional tools are required for Window's user
1. [Windows Terminal]((https://www.microsoft.com/zh-tw/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab))
1. Windows Subsystem for Linux (WSL)

### Install WSL
> ⚠️
> - You must be running Windows 10 version 2004 and higher (Build 19041 and higher) or Windows 11.
> - If you're running an older build, or just prefer not to use the install command and would like step-by-step directions, see [WSL manual installation steps for older versions](https://docs.microsoft.com/en-us/windows/wsl/install-manual).

1. Open the **Windows Terminal**. Then, install **WSL2** and the Ubuntu-20.04 distribution as default with the following command.
    ```powershell
    wsl --install -d Ubuntu-20.04
    wsl --set-default Ubuntu-20.04
    ```
1. Check if your Ubuntu-20.04 distribution uses **WSL 2**.
    ```powershell
    wsl -l -v
    ```
    If your Ubuntu-20.04 distribution uses WSL 1, please use the following command to set your Ubuntu-20.04 distribution to use WSL 2.
    ```powershell
    wsl --set-version Ubuntu-20.04 2
    ```

1. If you want to browse files in wsl in the Windows GUI, open "File Explorer" and type **\\\\wsl$** in the address bar and press "Enter". This allows you to view all wsl distributions in File Explorer and freely browse files of different wsl distributions.


### Install Docker desktop
1. Download **Docker desktop for Windows** from [official website](https://hub.docker.com/editions/community/docker-ce-desktop-windows) and install it.
1. Start Docker Desktop, and select **Settings (gear icon in the upper right corner) > General** to check whether the **Use WSL 2 based engine** check box is selected. If it is not checked, please select it.


### Set VS Code up
1. Download VS Code from the [official website](https://code.visualstudio.com/) and install it.
1. Install VS Code extension called **Remote Development** from [here](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack).


### Clone [sppmg/TW_Thesis_Template](https://github.com/sppmg/TW_Thesis_Template) and use

How to work in WSL:
1. Start **VS Code**.
1. Press `F1` or `ctrl+shift+p` to open Command Palette (interactive prompt will appear in the top center)
1. Type **Remote-WSL: New WSL Window** to search for command (search function is not case sensitive).
1. Use the keyboard up and down keys to select the **Remote-WSL: New WSL Window** command and press "Enter" (the selected command will be highlighted) or use the mouse to click the **Remote-WSL: New WSL Window** command.
1. Switch to the new window connected to WSL. Check for the **WSL: Ubuntu-20.04** prompt on the left side of the status bar (at the bottom of the window).

Clone [sppmg/TW_Thesis_Template](https://github.com/sppmg/TW_Thesis_Template) in WSL:
1. `ctrl+shift+p`, type and select `WSL: Open Folder in WSL`, select a folder as the workspace.
1. ``ctrl+shift+` `` in VS Code to open integrated terminal, and use command `git clone https://github.com/sppmg/TW_Thesis_Template.git`


Open [sppmg/TW_Thesis_Template](https://github.com/sppmg/TW_Thesis_Template) in container:
1. Make sure Docker desktop is running.
2. `WSL: Open Folder in WSL` again to open the directory of TW_Thesis_Template, and a notification will be displayed in the lower right corner. 
3. Click **"Reopen in Container"** to building the image and run the container.



## For Ubuntu user

1. Make sure docker is running in the background.
1. Start **VS Code**.
1. Click **Source Control** tab in the left side bar.
1. Click the **Clone Repository** to clone this repo.
1. Paste the **[sppmg/TW_Thesis_Template](https://github.com/sppmg/TW_Thesis_Template):** into the interactive prompt at the top center of the window and press "Enter".
1. In the interactive prompt at the top center of the window, select the **preferred path to store the cloned repository** and press "Enter".
1. After the clone is successful, a notification will appear in the lower right corner to remind you to open the cloned repository. Please click **"Open"**.
1. After successfully opening the project, a notification will be displayed in the lower right corner to remind you that you can use the container. Click **"Reopen in Container"** to building the image and run the container.


Once the container is built:
1. Start **VS Code**.
1. Click **Remote Explorer** tab in the left side bar.
1. Select **Containers** in the drop-down menu to display the available Dev Containers.
1. Click the **Open Folder in Container icon** on the right side and select workspace label.
1. The VS Code will reopen the window that connect the container (check if there is a prompt for **Dev Container: workspace** in the lower left corner of the window).


## Tips and Hints
- Image only needs to be built for once unless `.devcontainer/Dockerfile` changed.
- If your container is gone, open the folder in VS Code(note for Windows user: VS Code should open in WSL) and press `F1` or `ctrl+shift+p` to use **Remote-Containers: Reopen in Container** command.
- If devcontainer has changed, open the folder in VS Code(note for Windows user: VS Code should open in WSL) and press `F1` or `ctrl+shift+p` to use **Remote-Containers: Rebuild and Reopen in Container**.
- Manually open your workspace (the folder where `.devcontainer` lies): `ctrl+shift+p`, type and select `Dev Containers: Reopen in Container`

## Trouble shooting
### Trouble in starting WSL remote
When you failed in starting the dev container, check if there is a connection error at the stage of opening WSL-remote (**Remote-WSL: Open new window**):
![VS Code server for WSL failed to download](./assets/mdimages/wsl_downloaderror.png)

If this is the case, the failure that you cannot start a WSL remote server as well as the dev container is caused by the proxy of your company or organization. See [this thread](https://github.com/microsoft/vscode-remote-release/issues/133#issuecomment-489627195).

#### Download VS Code server manually to solve the issue
- Download **vscode-server-linux-x64.tar.gz** via an alternative network (e.g. your cell phone)
    - Check the log in WSL terminal to find the link. For example, https://update.code.visualstudio.com/commit:b5205cc8eb4fbaa726835538cd82372cc0222d43/server-linux-x64/stable
    > 💡**Hint**: See the highlighted area in the snapshot above; click on where the red arrow points to open the log.
- Copy **vscode-server-linux-x64.tar.gz** to the following place:
    - ```
      C:\Users\<username>\AppData\Local\Temp\vsch\serverCache\b5205cc8eb4fbaa726835538cd82372cc0222d43\
      ```
    > 💡**Hint**: See the highlighted area in the snapshot above to find the *commit checksum*.

#### Use VPN to solve the issue
- Download and install this [VPN](https://www.vpngate.net/cn/download.aspx). (Please assess the risks of using this VPN yourself)
- Double click the "VPN Gate 公共 VPN 中繼服務器". (corresponding to step 1 in the figure below)
- Select a VPN server and double click. (corresponding to step 2 in the figure below)
- Select the default TCP protocol as the preferred one and click "確定". (corresponding to step 3 in the figure below)
![VPN step by step](./assets/mdimages/VPN_step.png)
- If the connection is successful, you will see the window shown below.
![VPN connected](./assets/mdimages/VPN_connected.png)
- If your VS Code server has finished downloading, you can left-click "VPN Gate Connection" and click "斷開" to disconnect the VPN server.
![VPN disconnect](./assets/mdimages/VPN_disconnect.png)
- To close the VPN Client program completely, click the arrow in the taskbar to expand Background Tasks, then left-click the VPN Client logo and click "退出 VPN Client 管理器程序".
![VPN close](./assets/mdimages/VPN_close.png)




## References
- [Install WSL](https://docs.microsoft.com/en-us/windows/wsl/install)
- [Install Docker Desktop on Windows](https://docs.docker.com/desktop/windows/install/)
- [Using Docker as a Dev Environment with VS Code: Part 2](https://spin.atomicobject.com/2021/06/16/docker-development-container/)
- [DrWatson.jl Docs](https://juliadynamics.github.io/DrWatson.jl/stable/)
- [Data Version Control With Python and DVC](https://realpython.com/python-data-version-control/)
- [GitHub: terasakisatoshi/jldev_poetry](https://github.com/terasakisatoshi/jldev_poetry)
- [GitHub: cjolowicz/hypermodern-python](https://github.com/cjolowicz/hypermodern-python)
- [GitHub: Lee-W/cookiecutter-python-template](https://github.com/Lee-W/cookiecutter-python-template/tree/0.7.1)
- [GitHub: dgoings/docker-dev-example](https://github.com/dgoings/docker-dev-example)
- [GitHub: drivendata/cookiecutter-data-science](https://github.com/drivendata/cookiecutter-data-science)
- [GitHub: crmne/cookiecutter-modern-datascience](https://github.com/crmne/cookiecutter-modern-datascience)

