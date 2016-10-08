#!/bin/bash
make && ./opencv | nc 127.0.0.1 8000
