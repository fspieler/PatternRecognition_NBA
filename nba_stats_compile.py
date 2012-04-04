#!/usr/bin/env python
#this code generates csv file hiearchy
import urllib
from BeautifulSoup import BeautifulSoup
import re
import string

def remove_html_tags(data):
    p = re.compile(r'<.*?>')
    return p.sub('', data)


for year in range(2005, 2013): #2005 (league expanded to 30 teams) through 2012
	year_file = open( ''.join([str(year), "_data.csv"]),'w') 


	#each team page's URL is distinguished by 3-letter code and year
	teams = ["ATL", "BOS", "CHA", "CHI", "CLE", "DAL", "DEN", "DET", "GSW", "HOU", "IND", "LAC", "LAL", "MEM", "MIA", "MIL", "MIN", "NJN", "NOH", "NYK", "OKC", "ORL", "PHI", "PHO", "POR", "SAC", "SAS", "TOR", "UTA", "WAS"]

	if year == 2006 or year == 2007: #Hornets played home games in OKC after Katrina
		nok_index = teams.index("NOH")
		teams.insert(nok_index, "NOK")
		teams.remove("NOH")

	if year <= 2008: #Before Seattle franchise moved to OKC
		sea_index = teams.index("OKC") 	
		teams.insert(sea_index, "SEA")
		teams.remove("OKC")

	for team in teams:
		season_url =  ''.join(["http://www.basketball-reference.com/teams/", team, "/", str(year), "/gamelog/"]) 
		print season_url
		f = urllib.urlopen( season_url )
		html = f.read()
		f.close()
		soup = BeautifulSoup(html)
		
		elems = soup.findAll('td')	
		for i in range(0, len(elems) - 1):
			if i % 35 == 0:
				year_file.write( ''.join([str(teams.index(team)+1), "; "]))
				
			elem = remove_html_tags(elems[i].renderContents())
			elem = elem.replace('-', '')		
			if( elem == '' or elem == ' '):
				elem = '1' #HOME
			elif( elem == '@' ):
				elem = '0' #AWAY
			elif( i % 35 == 4 ):
				elem = teams.index(elem)
			elif( elem == 'L'):
				elem = 0 #LOSS
			elif( elem == 'W'):
				elem = 1 #WIN
			if i % 35 != 1:
				year_file.write( ''.join([str(elem), "; "]) )
			if i % 35 == 34:
				year_file.write( '\n' )
		year_file.write( '\n' )


	year_file.close()
