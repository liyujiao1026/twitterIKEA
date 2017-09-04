import tweepy
import csv


consumer_key="xxx"
consumer_secret="xxx"
access_token="xxx"
access_token_secret ="xxx"



auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
auth.set_access_token(access_token, access_token_secret)
api = tweepy.API(auth)

print "API setting is done"

f = open('Aug_IKEA_all_0903.csv', 'wb')
csvWriter = csv.writer(f)

csvWriter.writerow(('user_id', 'user_location',  'tweet_text', 'tweet_created_at',
 				'tweet_retweet_count', 'user_statuses_count', 'user_followers_count', 'user_friends_count','tweet_place')) 


for tweet in tweepy.Cursor(api.search,q="IKEA",count=100,
                           #lang="en",
                           wait_on_rate_limit = True, wait_on_rate_limit_notify = True,
                           include_entities=True,
                           since=2017-07-01).items():
	
	#print "loop..."

	try:

		#if tweet.user.location.encode('utf-8').lower().find("stockholm") >= 0 or tweet.user.location.encode('utf-8').lower().find("gothenburg") >= 0:

			csvWriter.writerow((tweet.user.id, tweet.user.location.encode('utf-8'), tweet.text.encode('utf-8'), tweet.created_at,
						tweet.retweet_count, tweet.user.statuses_count,
				 		tweet.user.followers_count, tweet.user.friends_count, tweet.place))

    	except tweepy.TweepError as e:  
         	print(e.reason)
        	sleep(900)
        	continue

    	except StopIteration: #stop iteration when last tweet is reached
        	break

f.close()	



