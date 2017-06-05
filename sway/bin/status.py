#!/usr/bin/env python
from subprocess import Popen, PIPE
import re
import time
import sys

def light():
    p = Popen(["/home/till/bin/light"], stdout=PIPE)
    output = p.communicate()[0].decode("utf-8")
    p.wait()
    return str(float(output)) + "%"

def volume():
    p = Popen(["pamixer", "--get-volume"], stdout=PIPE)
    output = p.communicate()[0].decode("utf-8")
    p.wait()
    volume = str(int(output)) + "%"
    if muted():
        return volume + "M"
    else:
        return volume

def muted():
    p = Popen(["pamixer", "--get-mute"], stdout=PIPE)
    p.communicate()
    exit_code = p.wait()
    return exit_code == 0

def wifi():
    p = Popen(["iwconfig"], stdout=PIPE, stderr=PIPE)
    output = p.communicate()[0].decode("utf-8")
    p.wait()
    m = re.search('ESSID:(.*)', output).group(1)
    if re.match("off", m):
        return "off"
    else:
        ssid = m[1:-3]
        strength = re.search('Signal level=(.*)', output).group(1)[:-2]
        return ssid + " " + strength

def battery():
    p = Popen(["acpi"], stdout=PIPE)
    output = p.communicate()[0].decode("utf-8")
    p.wait()
    battery_level = re.search('\d+%', output).group(0)
    return battery_level

def datetime():
    return time.strftime("%Y-%m-%d %H:%M")

def print_line(message):
    sys.stdout.write(message + '\n')
    sys.stdout.flush()

def read_line():
    try:
        line = sys.stdin.readline().strip()
        if not line:
            sys.exit(3)
    except KeyboardInterrupt:
        sys.exit()

while True:
    line = read_line()
    status = "L: " + light() + " " + \
             "V: " + volume() + " " + \
             "W: " + wifi() + " " + \
             "B: " + battery() + " " + \
             "T: " + datetime()
    print_line(status) 
