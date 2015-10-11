
This script - assuming you are backing up your iPhone locally on your Mac - extracts all the SMS messages from the local SQLite database into a CSV file.

Please feel free to add/remove columns you need / don't need by editing the `select statement` in the following section:

``` shell
.mode csv
.once SMSes.csv
SELECT date, text FROM message ORDER BY date;
.exit
.quit
```

The output file will contain two columns: the first one is a timestamp (in classic UNIX timestamp format), the second column contains the body of the SMS message.

#### Tested on

* Mac OS X El Capitan 10.11

### With

* an iPhone 4s (iOS 9.0.2)
* iTunes 12.3.0.44
