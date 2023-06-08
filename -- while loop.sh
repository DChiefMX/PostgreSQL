-- while loop
$ while true; do ( echo -n  'date +"%T - size:"' && curl -so /dev/null http://35.175.181.205/ -w '%{size_download}\n'; sleep 1 ; done

1) connect to database using msql command
2) $ show processlist; and see the last process wich is my connection

