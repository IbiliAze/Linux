#!/bin/bash


\d = digit
{1,3} = match between 1, 3 characters
\. = period


[ Examples ]

{IP Address}

\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}

10.1.1.1
192.168.0.1
255.255.255.0
172.160.34.2
333.333.333.333

\d = digit
{1,3} = match from 1, upto 3 digits in each octet
\. = escaped period


