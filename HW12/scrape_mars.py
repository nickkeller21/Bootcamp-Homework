

from splinter import Browser
from bs4 import BeautifulSoup
import tweepy
import pandas as pd
import config
import time

#Site Navigation


# Defining scrape & dictionary
def scrape():
    final_data = {}
    output = marsNews()
    final_data["mars_news"] = output[0]
    final_data["mars_paragraph"] = output[1]
    final_data["mars_image"] = marsImage()
    final_data["mars_weather"] = marsWeather()
    final_data["mars_facts"] = marsFacts()
    final_data["mars_hemisphere"] = marsHem()

    return final_data

def init_browser():
    # @NOTE: Replace the path with your actual path to the chromedriver
    #executable_path = {"executable_path": "/usr/local/bin/chromedriver"}
    executable_path = {"executable_path": "chromedriver.exe"}
    return Browser("chrome", **executable_path, headless=False)

# # NASA Mars News

def marsNews():
    browser=init_browser()
    news_url = "https://mars.nasa.gov/news/"
    browser.visit(news_url)
    html = browser.html
    soup = BeautifulSoup(html, "html.parser")
    news_title = soup.find("div", class_="content_title").text
    news_p = soup.find("div", class_ ="article_teaser_body").text
    output = [news_title, news_p]
    browser.quit()
    return output

# # JPL Mars Space Images - Featured Image
def marsImage():
    browser=init_browser()
    image_url = "https://www.jpl.nasa.gov/spaceimages/?search=&category=Mars"
    browser.visit(image_url)
    html = browser.html
    soup = BeautifulSoup(html, "html.parser")
    image = soup.find("img", class_="thumb")["src"]
    featured_image_url = "https://www.jpl.nasa.gov" + image
    browser.quit()
    return featured_image_url

# # Mars Weather
def marsWeather():
    consumer_key = config.consumer_key
    consumer_secret = config.consumer_secret
    access_token = config.access_key
    access_token_secret = config.access_secret

    # Setup Tweepy API Authentication
    auth = tweepy.OAuthHandler(consumer_key, consumer_secret)
    auth.set_access_token(access_token, access_token_secret)
    api = tweepy.API(auth, parser=tweepy.parsers.JSONParser())

    target_user = "MarsWxReport"
    tweet = api.user_timeline(target_user, count =4)
    mars_weather = ((tweet)[3]['text'])
    return mars_weather


# # Mars Facts
def marsFacts():
    browser=init_browser()
    facts_url = "https://space-facts.com/mars/"
    browser.visit(facts_url)
    mars_data = pd.read_html(facts_url)
    mars_data = mars_data[1]
    mars_facts = mars_data.to_html(header = False, index = False)
    print(mars_facts)
    browser.quit()
    return mars_facts


# # Mars Hemispheres
def marsHem():

    browser=init_browser()
    hemispheres_url = "https://astrogeology.usgs.gov/search/results?q=hemisphere+enhanced&k1=target&v1=Mars"
    browser.visit(hemispheres_url)
    html = browser.html
    soup = BeautifulSoup(html, "html.parser")
    mars_hemisphere = []

    products = soup.find("div", class_ = "result-list" )
    hemispheres = products.find_all("div", class_="item")
    
    for hemisphere in hemispheres:
        time.sleep(5)
        title = hemisphere.find("h3").text
        title = title.replace("Enhanced", "")
        end_link = hemisphere.find("a")["href"]
        image_link = "https://astrogeology.usgs.gov/" + end_link    
        browser.visit(image_link)
        html = browser.html
        soup=BeautifulSoup(html, "html.parser")
        downloads = soup.find("div", class_="downloads")
        image_url = downloads.find("a")["href"]
        dictionary = {"title": title, "img_url": image_url}
        mars_hemisphere.append(dictionary)
    browser.quit()
    return mars_hemisphere



