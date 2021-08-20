# ThanOS
A lightweight OS used for boot-to-browser thin clients

## Architecture

The ThanOS project aims to provide a lightweight, portable OS than can be used for a wide variety of applications, through the use of containers. The key aims of this new project:

- Immutable output
- Ease of build 
- Lean / simple design
- Clean base to build upon  
  
<br/>
  
The ThanOS project predominantly uses [linuxkit](https://github.com/linuxkit/linuxkit) as the toolkit that will produce repeatable and straightforward build of the entire in-memory operating system. The linuxkit project combines a Linux kernel with a number of additional container images to produce a Linux Operating System with just the right amount of functionality (no less / no more). We have built upon the minimal set of components:

- containerd (the engine to start/stop all other components in a LinuxKit OS)
- dhcp (for network access)
- ntp (network time)
- rngd (random number gen for entropy)
- sshd (for ssh access)

To this minimal build, we've added our own service that will provide the functionality needed for applications that generate visual and audio outputs to run successfully:

<br/>

### Corvus
The `corvus` service builds upon the upstream `dind` (docker-in-docker) container and adds the additional packages required to initialize and run an X11 and ALSA server. 

The `start.sh`, once run, executes a number of steps:
1. Install, configure and start the X11 server
2. Unmute the master output in ALSA
3. Read the X and Y resolution from the config file located at `/var/lib/docker/config`
4. Set the screen resolution to the values read in from the config file
5. Launch a new private Firefox session, and navigate to the url also read in from the config file

##### NOTE: ThanOS is designed to be installed through the [Tinkerbell](https://github.com/belchy06/sandbox) provisioning engine. As such, if installed without Tinkerbell, you will not have the config file and will most likely have the screen resolution set to the X server default 800x600.

<br/>


## Pixel Streaming
One of the use cases ThanOS is primarily designed for, is to be a thin client that runs a web browser with the intention of receiving a pixel streaming output. <br/> We've included the necessary drivers to have audio and video output, as well as keyboard and mouse input. 

For users wanting to use ThanOS in a pixel streaming deployment, point the `url` field in the `writefile` action of your [Tinkerbell](https://github.com/belchy06/sandbox) template to the address of your pixel streaming application. 

eg http://mypixelstreamingurl

<br/>

## Building ThanOS
### Working on an Ubuntu 20.04 host
```
# Clone this repo
git clone https://github.com/belchy06/ThanOS

# Generate ssh keys
ssh-keygen -t rsa -b 4096 -C "your_email@domain.com"

# build it - this produces a virtual box VHD file
make
```

<br/>

### Building other output formats
The LinuxKit project can generate a wide variety of output formats. See `linuxkit build -help` for the complete list of output formats available. Once you have identified your target format, you can specify it with:
```
make FORMAT=your-format
```

<br/>

## Troubleshooting
You can ssh into your machine once it is running on port 1234. NOTE: You may need `-o StrictHostKeyChecking=no` in your connection command. eg
```
ssh -o StrictHostKeyChecking=no x.x.x.x -p 1234 -l root
```
