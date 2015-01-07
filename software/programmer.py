#!/usr/bin/python

import time
import SH1106
import bootloader
import sys

def write_text(disp,text,page,column):
    paged_text = SH1106.get_paged_text(text,spacing=4,offset=2)
    disp.send_pages(paged_text,page,column)
    
def show_progress(i):
    if not hasattr(show_progress, "counter"):
         show_progress.counter = 0  # it doesn't exist yet, so initialize it
    i = i/1024
    if i > show_progress.counter:
        disp.set_page(6)
        disp.set_column(show_progress.counter)
        page = [0xff]*(i-show_progress.counter)
        disp.send_data(page)
        show_progress.counter = i
try:
    prog = bootloader.Programmer()
    disp = SH1106.Display(prog)
    write_text(disp,"Loading",2,2)
    hexfile  = bootloader.HexFile(sys.argv[1])
    prog.write_program(hexfile,set_progress=show_progress)
    disp.clear_screen()
    write_text(disp,"Verify",2,2)
    prog.verify_program(hexfile,set_progress=show_progress)
    disp.clear_screen()
    write_text(disp,"Done   ",2,2)
    time.sleep(2)
    disp.clear_screen()
except bootloader.ProgrammerError as e:
    print e
    
