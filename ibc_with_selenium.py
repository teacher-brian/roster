from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import re

browser = webdriver.Firefox() # Get local session of firefox
browser.get("https://wts.seattlecolleges.edu/seanor/ibc/") # Load App page

elem = browser.find_element_by_xpath('//*[@name="empid"]') # Find the Login box
elem.send_keys('user')
elem = browser.find_element_by_xpath('//*[@name="pin"]')# Find the Password box
elem.send_keys("pid" + Keys.RETURN)
#try:
#elem = browser.find_element_by_link_text("Home")
#elem.click()
