#!/bin/zsh
TF=$(tempfile)
for c in "416 .twidgerc_schellingmensaria_twitter" "411 .twidgerc_mensaleo_twitter" "411 .twidgerc_mensaleopold" "421 .twidgerc_arci" "431 .twidgerc_loth" "512 .twidgerc_cafeadalbert_twitter"
#for c in "411 .twidgerc_mensaleopold" "421 .twidgerc_arci" "431 .twidgerc_loth" 
#for c in "416 .twidgerc_schellingmensaria"
do
  elinks -dump-width 800 -dump http://www.studentenwerk-muenchen.de/mensa/speiseplan/speiseplan_$(date +%Y-%m-%d)_$c[(w)1]_-de.html -dump-charset utf-8|grep -e Fleisch -e fleischlos|grep -e "Tagesgericht" -e "Aktionsessen" -e "Biogericht" > $TF
  #echo http://www.studentenwerk-muenchen.de/mensa/speiseplan/speiseplan_$(date +%Y-%m-%d)_$c[(w)1]_-de.html
  for i in $(seq `wc -l $TF|cut -d\  -f1`);
  do
    TEXT=$(head -n $i $TF|tail -n1|sed "s/   Aktionsessen/   Tagesgericht Aktion/"|sed "s/   Biogericht/   Tagesgericht Bio/"|sed  s/\ \ \ Tagesgericht/$(LANG=de_DE.UTF-8 date +%a)/|tr -s \ |sed -s 's/ //g');
    while ! twidge -c $c[(w)2] update "$TEXT"
    do
      sleep $((($RANDOM%30)+61))
    done
    sleep $((($RANDOM%30)+61))
  done
  sleep $((($RANDOM%30)+61))
done
rm $TF
