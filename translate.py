#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
reload(sys)
import pandas as pd
sys.setdefaultencoding('utf-8')
from textblob import TextBlob
import csv


data_path = '/Users/Yujiao/Desktop/twitter_Ikea/TwitterIKEA2.csv'
data_IKEA = pd.read_csv(data_path)



def sv2en(words):
	tweet_text = TextBlob(words)
    	tweet_lang = tweet_text.detect_language()

    	try:
    		tweet_en = tweet_text.translate(from_lang = tweet_lang, to = "en")
    	
    	except Exception: 
  			tweet_en = tweet_text

    	return  [str(tweet_en), tweet_en.sentiment.polarity, tweet_en.sentiment.subjectivity]


tweet_EN_section =  data_IKEA.tweet_text.apply(lambda x: pd.Series({'tweet_EN':sv2en(x)[0], 'tweet_EN_polarity':sv2en(x)[1], 'tweet_EN_subjectivity':sv2en(x)[2]}))
data_IKEA_en = pd.concat([data_IKEA, tweet_EN_section], axis=1)

print data_IKEA_en
data_IKEA_en.to_csv("data_IKEA_en.csv", sep = ",")



