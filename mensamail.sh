#/bin/sh
echo Subject: Speisekarte `date`
echo Heute gibt es:
# /usr/bin/twidge lsrecent --long --unseen --saveid
links -codepage iso-8859-2 -dump http://www.studentenwerk-muenchen.de/mensa/speiseplan/speiseplan_$(date +%Y-%m-%d)_411_-de.html -width 400|grep -e Fleisch -e fleischlos|grep -v "fleischloses Gericht"|sed 's/  \([mf]\)/ \1/g'

