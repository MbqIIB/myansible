#!/bin/bash



name=gongyan@cn.ibm.com
pass=yan.gong


#https://diuf.unifr.ch/people/slimanef/APTI-Database/Images/set12345/ 
Images=( \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/Images/set12345/AdvertisingBold.tgz \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/Images/set12345/Andalus.tgz \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/Images/set12345/ArabicTransparent.tgz \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/Images/set12345/DecoTypeNaskh.tgz \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/Images/set12345/DecoTypeThuluth.tgz \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/Images/set12345/DiwaniLetter.tgz \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/Images/set12345/MUnicodeSara.tgz \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/Images/set12345/SimplifiedArabic.tgz \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/Images/set12345/Tahoma.tgz \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/Images/set12345/TraditionalArabic.tgz \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/GrandTruth/set12345/XMLAdvertisingBold.tgz \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/GrandTruth/set12345/XMLAndalus.tgz \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/GrandTruth/set12345/XMLArabicTransparent.tgz \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/GrandTruth/set12345/XMLDecoTypeNaskh.tgz \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/GrandTruth/set12345/XMLDecoTypeThuluth.tgz \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/GrandTruth/set12345/XMLDiwaniLetter.tgz \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/GrandTruth/set12345/XMLMUnicodeSara.tgz \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/GrandTruth/set12345/XMLSimplifiedArabic.tgz  \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/GrandTruth/set12345/XMLTahoma.tgz \
 https://diuf.unifr.ch/people/slimanef/APTI-Database/GrandTruth/set12345/XMLTraditionalArabic.tgz  \
)

#GrandTruth



for f in ${Images[@]}
do
    echo $f
    #wget --user=${name} --password=${pass}  -c -r -np -k -L -p $f
    wget --user=${name} --password=${pass}  -c $f
done

