# ThanOS
A lightweight OS used for various projects. 

## Architecture

The ThanOS project aims to provide a lightweight, portable OS than can be used for a wide variety of applications, through the use of containers. The key aims of this new project:

- Immutable output
- Ease of build 
- Lean / simple design
- Clean base to build upon  
  
  
The ThanOS project predominantly uses [linuxkit](https://github.com/linuxkit/linuxkit) as the toolkit that will produce repeatable and straightforward build of the entire in-memory operating system. The linuxkit project combines a Linux kernel with a number of additional container images to produce a Linux Operating System with just the right amount of functionality (no less / no more). We have built upon the minimal set of components:

- containerd (the engine to start/stop all other components in a LinuxKit OS)
- dhcp (for network access)
- ntp (network time)
- rngd (random number gen for entropy)
- sshd (for ssh access)

To this minimal build, we've added our own container that will provide the functionality needed for applications that generate visual and audio outputs to run successfully:

### Stark

The `stark` container builds upon the upstream `dind` (docker-in-docker) container and adds the additional functionality to run an X11 and ALSA server. An application that produces an audio visual output such as Firefox can then be run


## Building ThanOS
### Working on an Ubuntu 20.04 host
```
# Clone this repo
git clone https://github.com/belchy06/ThanOS

# Generate ssh keys
ssh-keygen -t rsa -b 4096 -C "your_email@domain.com"

# Copy the ssh files to the relevant directory
cp $HOME/.ssh ~/.ssh

# build it - this produces a virtual box VHD file
make
```

### Building other output formats
The LinuxKit project can generate a wide variety of output formats. See `linuxkit build -help` for the complete list of output formats available. Once you have identified your target format, you can specify it with:
```
make FORMAT=your-format
```


## Troubleshooting
You can ssh into your machine once it is running on port 1234. NOTE: You may need `-o StrictHostKeyChecking=no` in your connection command. eg
```
ssh -o StrictHostKeyChecking=no x.x.x.x -p 1234 -l root
```
