### gnublin.mk --- 
## 
## Filename     : gnublin.mk
## Description  : General purpose makefile for use with gnublin embedded
##                linux software.
## Author       : Christophe Burki
## Maintainer   : Christophe Burki
## Created      : Wed Apr 23 20:18:06 2014
## Version      : 1.0.0
## Last-Updated : Sun Jun 22 11:48:47 2014 (7200 CEST)
##           By : Christophe Burki
##     Update # : 103
## URL          : 
## Keywords     : 
## Compatibility: 
## 
######################################################################
## 
### Commentary   : 
## 
## 
## 
######################################################################
## 
### Change log:
## 
## 
######################################################################
## 
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License version 3 as
## published by the Free Software Foundation.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program; see the file LICENSE.  If not, write to the
## Free Software Foundation, Inc., 51 Franklin Street, Fifth
## ;; Floor, Boston, MA 02110-1301, USA.
## 
######################################################################
# 
# Here is the complete list of configuration parameters :
# 
# GNUBLINAPIDIR  The path where the gnublin API software is installed
#                on your system.
# 
#
# This makefile also defines the following goalds for use to run make :
#
# all        This is the default when no goal is given,. It builds the
#            target.
#
# target     Builds the target.
# 
# clean      Deletes file created during the build.
#
# distclean  Clean and remove *~ files.
#
# publish    Publish the target to the destination.
# 
######################################################################
## 
### Code         :


GNUBLINMAKEDIR := /home/cburki/Burkionline/Projects/Gnublin/gnublin-make
ifndef GNUBLINAPIDIR
GNUBLINAPIDIR := /opt/gnublin-api
endif

ifeq ($(wildcard $(GNUBLINAPIDIR)/API-config.mk), )
$(error "GNUBLINAPIDIR is not defined correctly !")
endif

include $(GNUBLINAPIDIR)/API-config.mk

GNUBLINAPI_INC := -I$(GNUBLINAPIDIR)
GNUBLINAPI_LIB := $(GNUBLINAPIDIR)/gnublin.a

GCC := $(CXX)
#LD := arm-linux-gnueabi-ld
CPPFLAGS += $(CXXFLAGS) $(GNUBLINAPI_INC) $(BOARDDEF)
LDFLAGS +=  $(GNUBLINAPI_LIB)

OBJECTS := $(addsuffix .o, $(basename $(SOURCES)))

# Remove the extension .o from objects
#NAMES := $(patsubst %.o,%,$(OBJECTS))

#
# --------------------------------------------------------------------
#

.PHONY : all clean distclean


all : $(TARGET)

$(TARGET) : $(OBJECTS)
	$(GCC) $(OBJECTS) -o $(TARGET) $(LDFLAGS)

%.o : %.c
	$(GCC) -c -o $@ $< $(CPPFLAGS)

%.o : %.cpp
	$(GCC) -c -o $@ $< $(CPPFLAGS)

#python-module : $(OBJECTS)
#	$(error Not yet implemented "$(NAMES)")

clean : 
	rm -Rf *.o $(TARGET)

#python-module-clean : clean
#	rm -f *.i *.py *.pyc *_wrap.cxx _*.so

distclean : clean
	rm -f *~

publish : $(TARGET)
	fab -f $(GNUBLINMAKEDIR)/fpublish.py --host $(HOST) --port $(PORT) --user $(USER) publish


######################################################################
### gnublin.mk ends here
