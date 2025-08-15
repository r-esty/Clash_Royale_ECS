from flask import Flask, render_template

import requests
import json
import os
import random

try:
    with open("api_ecs", "r") as f:
        api_key = f.read().strip()
except FileNotFoundError:
    print("Error: 'api_key' file not found. Please create it and add your API key.")
    exit()

base_url = "https://api.clashroyale.com/v1"
endpoint = "/cards"

headers = {
    "Authorization": 'Bearer ' + api_key
}

response = requests.get(base_url + endpoint, headers=headers)

if response.status_code == 200:
    data = response.json()

    if data and "items" in data:
        all_cards = data["items"]
        
        random_card_selection_count = 8

        if len(all_cards) >= random_card_selection_count:
            selected_random_cards = random.sample(all_cards, random_card_selection_count)
            
            print(f"----- {random_card_selection_count} Random Cards Selected -----")
            for card_item in selected_random_cards:
                print(f"- {card_item['name']}")
        else:
            print(f"Error: You requested {random_card_selection_count} random cards, but only {len(all_cards)} are available in the game.")

    else:
        print("The JSON is empty or does not contain card data.")

else:
    print(f"Error: Request failed with status code {response.status_code}")
    print(f"Response text: {response.text}")


