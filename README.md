# APS
APS - Advandced Port Scanner

APS is a small script to combine in a short time the information of multiple network diagnostic tools.

## Requierements
- bash4
- dialog (optional for setup.sh)

## Install

### Advanced ;)

You can copy the script file "aps" to every location which is on your PATH.
Make it executable and the installation is done.

### Beginner

If you aren't confident with the steps described above, use the "setup.sh" script and follow the instructions:

```bash
sudo bash setup.sh
```

### Update

Updating the tool is simple just pull the newest commits from the repo and run the ```setup.sh``` again.
You might want to change the path in the install process.

## Usage

If your installation was successful the script could be launched with this single command:

```bash
sudo aps
```
and the result could look like this (blurred additional entries for obvious reasons):

![result](/imgs/reuslt.png)

### What is this mysterious script doing and why do I need it?
- read out all ports of an local ```nmap -p 1-65535 localhost``` scan
- looking for these ports with ```netstat -tulpnae```
- sort them not completly correct with a bubblesort
- and find the process calls with ```ps -p <port> -o command```
- to fianlly pretty print out the concatenated results.

This tool helps you to see which actual service is running on your ports

#### TODO
- [] lot of things
- [] figure out bugs/and solution for them (There are a few but didn't found the time for issues)
- [] refactor for better error handling
- [] CI/CD Pipeline (with github actions?)
