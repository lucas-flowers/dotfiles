#!/usr/bin/python3
# -*- coding: utf-8 -*-

import sys

try:
    import scribus
except ImportError,err:
    print "This Python script is written for the Scribus scripting interface."
    print "It can only be run from within Scribus."
    sys.exit(1)

#########################
# YOUR IMPORTS GO HERE  #
#########################

def main(argv):
    """Translate imported RGB colors to CMYK colors."""
    #########################
    #  YOUR CODE GOES HERE  #
    #########################
    if scribus.haveDoc():
        clrs = scribus.getColorNames()
        newname = ""
        for clr in clrs:
            if clr.find("From") == 0:
                cmyk = scribus.getColor(clr)
                c = cmyk[0]
                cd = c*100/255
                ca = "c"+str(cd)
                m = cmyk[1]
                md = m*100/255
                ma = "m"+str(md)
                y = cmyk[2]
                yd = y*100/255
                ya = "y"+str(yd)
                k = cmyk[3]
                kd = k*100/255
                ka = "k"+str(kd)
                newname = ca+ma+ya+ka
                scribus.defineColor(newname,c,m,y,k)
                scribus.replaceColor(clr,newname)
                scribus.deleteColor(clr,newname)

def main_wrapper(argv):
    """The main_wrapper() function."""
    try:
        scribus.statusMessage("Running script...")
        scribus.progressReset()
        main(argv)
    finally:
        if scribus.haveDoc():
            scribus.setRedraw(True)
        scribus.statusMessage("")
        scribus.progressReset()

if __name__ == '__main__':
    main_wrapper(sys.argv) 
