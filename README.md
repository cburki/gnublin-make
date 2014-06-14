Summary
-------

They are tools that simplify the compilation and publication of the Gnublin modules. The gnublin.mk can be included from a module Makefile. This allow the Makefile of the module to be simple as the one here below.

    TARGET := mymodule_target
    SOURCES := mymodule.cpp
    
    include ../Config.mk
    include $(GNUBLINMKDIR)/gnublin.mk

You need to checkout this repository when you checkout the [gnublin-modules][1] repository.


  [1]: https://github.com/cburki/gnublin-modules