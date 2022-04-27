#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Mar  8 13:28:41 2022

@author: chrispatton
"""

import os
from ebaysdk.finding import Connection
from dotenv import load_dotenv
import requests
import pandas as pd



load_dotenv()

API_KEY=os.getenv('api_key')

goatproducts = []
productlist = []


for pagenum in range(1,5):

    url = f'https://pwcdauseo-zone.cnstrc.com/browse/group_id/sneakers?c=ciojs-client-2.26.6&key=key_XT7bjdbvjgECO5d8&i=95f64e39-f7f3-409b-ad02-7310ae69a1d9&s=7&page={pagenum}&num_results_per_page=24&_dt=1646699867985'
    
    r = requests.get(url).json()
    
    x= 0
    while (x<24):
            
            goatproducts.append(r["response"]["results"][x]["value"])
            x+=1

    
for searchterm in goatproducts:
    pages =0
    while pages < 101:
        api = Connection(appid=API_KEY, config_file=None)
        response = api.execute('findItemsAdvanced', {'keywords': searchterm, 'paginationInput' : pages })
        
        
        try:
            for item in response.reply.searchResult.item:
                product = {
                    'Shoe': searchterm,
                    'Listing Title' : item.title,
                    'Price' : item.sellingStatus.currentPrice.value,
                    'URL' :  item.viewItemURL
                    }
                productlist.append(product)
        except:
            pass  
        pages+=1
  
     
productsdf =  pd.DataFrame(productlist)
productsdf.to_csv('SNKRS2.csv', index=False)
print(productsdf.head())
   
 
         
   
         
