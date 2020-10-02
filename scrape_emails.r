# Using Rselenium ------------------------------------------------------------
library(RSelenium)
library(tidyverse)

library(rvest)

# Log in to inside seattle -------------------------------------------------------------------------

# open driver  ------------------------------------------------------------

driver <- rsDriver(browser =c("firefox"))
remote_driver <- driver[["client"]]
#remote_driver$close()



# navigtate to briefcase --------------------------------------------------


remote_driver$navigate("https://people.seattlecolleges.edu/user/login")
RSelenium:::selKeys %>% names()
remote_driver$refresh()


# find login --------------------------------------------------------------

el<- remote_driver$findElement(using='xpath', '//*[@name="name"]')
el$highlightElement()

el$clickElement()


el$sendKeysToElement(list('email'))  #change to user full email
el.1 <- remote_driver$findElement(using = 'xpath', '//*[@name="pass"]') # district password
el.1$highlightElement()

el.1$sendKeysToElement(list('email-pass'))  #change to Pass ID
el$sendKeysToElement(list(key='enter'))



# grab class list ---------------------------------------------------

## There is an <a href> for current and next_quarter

## default is current

hrefs<- remote_driver$findElements(using='xpath', '//*[@class="card-link"]')
hrefs[[1]]$highlightElement()    # will find the links in the card link table, but for current and next quarter


class.list <- list()
for (i in 1:length(hrefs)){
  class.list[i] <- hrefs[[i]]$getElementText()   # This will print only the active card.
  }
class.list

#below gets the first link and opens add/drop
hrefs[[1]]$highlightElement()
hrefs[[1]]$sendKeysToElement(list(key='enter')) # that will drop the card down, exposing add/drop...may be unnecessary to click add drop link

xpath.add.drop<- '/html/body/div/div/div/div[2]/div/div[2]/div/article/div/div[1]/div/div[2]/div[1]/div/div[1]/div/div[1]/div[2]/div/ul/li[9]/a/strong'
adEl<- remote_driver$findElement(using='xpath',xpath.add.drop)

adEl$clickElement()


# get emails --------------------------------------------------------------

email.elements<- remote_driver$findElement(using = 'xpath','//*[@class="btn btn-info"]')


emails<- email.elements$getElementAttribute(attrName = 'href')
# must clean up now.  First thing is to drop mail to, then speparate

# get table of roster from 1 class ----------------------------------------

page<- remote_driver$getPageSource() %>% .[[1]] %>% read_html()

roster.table <- '/html/body/div[1]/div/div/div[2]/div/div/main/section/div/div/form/table'

table.out <- page %>% html_nodes(.,xpath=roster.table)
table.out %>% html_text()


#hmm..
