# This script prints the desscription of an rsync exit status if there is an
# error (i.e. if the exit status is non-zero).

if [ $1 -eq 1 ];
then
    echo "Syntax or usage error"
fi
if [ $1 -eq 2 ];
then
    echo "Protocol incompatibility"
fi
if [ $1 -eq 3 ];
then
    echo "Errors selecting input/output files, dirs"
fi
if [ $1 -eq 4 ];
then
    echo "Requested action not supported: an attempt was made to manipulate 64-bit
    files on a platform that cannot support them; or an option was specified
    that is supported by the client and not by the server."
fi
if [ $1 -eq 5 ];
then
    echo "Error starting client-server protocol"
fi
if [ $1 -eq 6 ];
then
    echo "Daemon unable to append to log-file"
fi
if [ $1 -eq 10 ];
then
    echo "Error in socket I/O"
fi
if [ $1 -eq 11 ];
then
    echo "Error in file I/O"
fi
if [ $1 -eq 12 ];
then
    echo "Error in rsync protocol data stream"
fi
if [ $1 -eq 13 ];
then
    echo "Errors with program diagnostics"
fi
if [ $1 -eq 14 ];
then
    echo "Error in IPC code"
fi
if [ $1 -eq 20 ];
then
    echo "Received SIGUSR1 or SIGINT"
fi
if [ $1 -eq 21 ];
then
    echo "Some error returned by waitpid()"
fi
if [ $1 -eq 22 ];
then
    echo "Error allocating core memory buffers"
fi
if [ $1 -eq 23 ];
then
    echo "Partial transfer due to error"
fi
if [ $1 -eq 24 ];
then
    echo "Partial transfer due to vanished source files"
fi
if [ $1 -eq 25 ];
then
    echo "The --max-delete limit stopped deletions"
fi
if [ $1 -eq 30 ];
then
    echo "Timeout in data sent/receive"
fi
if [ $1 -eq 35 ];
then
    echo "Timeout waiting for daemon connection"
fi
