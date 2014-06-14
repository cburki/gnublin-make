### fpublish.py --- 
## 
## Filename     : fpublish.py
## Description  : Fabric file for publishing files on target.
## Author       : Christophe Burki
## Maintainer   : Christophe Burki
## Created      : Tue May 27 10:15:52 2014
## Version      : 
## Last-Updated : Tue May 27 13:46:33 2014 (7200 CEST)
##           By : Christophe Burki
##     Update # : 66
## URL          : 
## Keywords     : 
## Compatibility: 
## 
######################################################################
## 
### Commentary   : The installation file must have the following format
##
##  local_file_path, target_file_path, owner, mode
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
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2, or (at your option)
## any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program; see the file COPYING.  If not, write to the
## Free Software Foundation, Inc., 51 Franklin Street, Fifth
## ;; Floor, Boston, MA 02110-1301, USA.
## 
######################################################################
## 
### Code         :

# ------------------------------------------------------------------------------

from fabric.api import env, sudo, local
from fabric.operations import put

from sys import exit
from os.path import basename

# ------------------------------------------------------------------------------

def publish(filename = 'INSTALL_FILE') :
    """
    Publish the files read from the given filename. Permissions and owners are
    set according to what is specified in the filename for each files.

    @param filename The name of the file from which to read the files to publish.
    """
    
    try :
        fd = open(filename, 'r')
    except IOError, error :
        print(error)
        exit(1)

    global remotePath

    for line in fd.readlines() :

        line = line.strip()
        
        # Skip empty line.
        if len(line) == 0 :
            continue

        # Skip commented out line
        if line[0] == '#' :
            continue

        records = line.split(' ')
        # Remove empty records
        records = filter(None, records)
                
        if len(records) < 2 :
            print("ERROR : A line must have at least 3 records ! Skip the line: {}".format(line))
            continue
        
        localFile = records[0].strip()
        targetFile = records[1].strip()
        owner = None
        mode = None

        if len(records) >= 3 :
            owner = records[2].strip()
        if len(records) >= 4 :
            mode = int(records[3].strip())

        # Put the file on the destination.
        put(local_path = localFile, remote_path = targetFile, use_sudo = True)

        if owner :
            # Change the owner on the target
            sudo('chown {} {}'.format(owner, targetFile))

        if mode :
            # Change the mode on the target
            sudo('chmod {} {}'.format(mode, targetFile))

    fd.close()
    
# ------------------------------------------------------------------------------

######################################################################
### fpublish.py ends here
