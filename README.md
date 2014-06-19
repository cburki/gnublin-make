Summary
-------

They are tools that simplify the compilation and publication of the Gnublin modules. The gnublin.mk can be included from a module Makefile. This allow the Makefile of the module to be simple as the one here below.

    TARGET := mymodule_target
    SOURCES := mymodule.cpp
    
    include ../Config.mk
    include $(GNUBLINMKDIR)/gnublin.mk

Publication of files is done using [fabric][1], a python library and command-line tool for streamlining the use of SSH for application deployment and system administration tasks. Publication is helpful when you cross-compile your codes and want to install them quickly on a target. For this to work as expected, *fabric* must be installed on the host system and a user with *sudo* privileges must exist on the target system. The USER, HOST and PORT variables from the Config.mk configuration file must be adjusted. USER is the user on the target system that fabric will use to connect with ssh. HOST and PORT are the hostname or IP address and SSH port for connecting to the target system. Here is a sample of a Config.mk file.

    GNUBLINMKDIR := ../gnublin-make
    GNUBLINAPIDIR := ../gnublin-api

    USER := toto
    HOST := 192.168.1.10
    PORT := 22

You need to checkout this repository when you checkout the [gnublin-modules][2] repository.


  [1]: http://www.fabfile.org/
  [2]: https://github.com/cburki/gnublin-modules