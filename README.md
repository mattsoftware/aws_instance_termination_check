# AWS Instance Termination Check

Bash file and systemd script to run as a daemon and call user defined scripts when an AWS EC2 Spot
Instance receives a termination event

Information about the instance termination event can be found here:
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-interruptions.html. As advised in that
document the poll rate in this script is set for every 5 seconds.

# Usage
Run the script with a directory to run the scripts in when the instance gets a termination event

Each script will be run with the event as its STDIN. Also the event is available in the $ACTION
environment variable

Each script will be run multiple times. This is important to realise and each run can be identified
by the IS_TERMINATING environment variable. On the initial run IS_TERMINATING will be equal to 0.
The next run IS_TERMINATING will be 1, and will be incremented each time from then on. At any time
the ACTION variable can be used to get information on when the instance will be terminated, or as a
guide each increment will happen every 30 seconds.

