# Lesson 12: API requests: GET

from config.global_config import CURRENCY_API_KEY
import requests
import pandas as pd
import sys
sys.path.append('..')

# Task 1
print('Task 1:')
url = 'https://api.currencylayer.com/change'
access_key = CURRENCY_API_KEY
currencies = 'USD,RUB,EUR'
start_date = '2024-08-13'
end_date = '2024-08-13'


api_request = f'{url}?access_key={access_key}&currencies={currencies}&start_date={start_date}&end_date={end_date}'

r = requests.get(url=api_request)
result = r.json()
print(r)
print(type(r))
print(r.text)
print(result)
print(type(result))
print('')

# Task 2
print('Task 2:')
currencies_list = list()

for i in range(1, 31):
    if i < 10:
        start_date = end_date = f'2024-07-0{i}'
    else:
        start_date = end_date = f'2024-07-{i}'
    api_request = f'{url}?access_key={access_key}&currencies={currencies}&start_date={start_date}&end_date={end_date}'
    r = requests.get(url=api_request)
    result = r.json()
    if result.get('quotes') is not None:
        currencies_list.append({
            'date': start_date,
            'currency': 'RUB',
            'rate_to_USD': result.get('quotes').get('USDRUB').get('start_rate')
        })
        currencies_list.append({
            'date': start_date,
            'currency': 'EUR',
            'rate_to_USD': result.get('quotes').get('USDEUR').get('start_rate')
        })

print(currencies_list)
df = pd.DataFrame(currencies_list)
df.to_csv('./Utils/currencies.csv', index=False)
data_output = pd.read_csv('Utils/currencies.csv')
print(data_output)
