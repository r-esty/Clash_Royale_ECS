import requests
import json
import os
import random
from flask import Flask, jsonify, render_template

app = Flask(__name__)

BASE_URL = "https://proxy.royaleapi.dev/v1"

ENDPOINT_CARDS = "/cards"

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/random_cards')
def get_random_cards():
    print(f"DEBUG: Attempting to fetch cards from: {BASE_URL}{ENDPOINT_CARDS}")

    api_key = os.environ.get("CLASH_ROYALE_API_KEY")

    if not api_key:
        print("ERROR: CLASH_ROYALE_API_KEY environment variable not set.")
        return jsonify({"error": "Clash Royale API Key not configured in environment variable."}), 500

    headers = {
        "Authorization": 'Bearer ' + api_key,
        "Accept": "application/json"
    }

    try:
        response = requests.get(BASE_URL + ENDPOINT_CARDS, headers=headers, timeout=10)
        response.raise_for_status()
        data = response.json()

        if not data or "items" not in data:
            print("ERROR: No card data or 'items' key found in API response.")
            return jsonify({"error": "No card data found from Clash Royale API."}), 500

        all_cards = data["items"]
        num_cards_to_select = 8

        if len(all_cards) < num_cards_to_select:
            final_deck_cards = all_cards
            print(f"WARN: Not enough total cards ({len(all_cards)}) to form an 8-card deck. Returning all available cards.")
        else:
            initial_deck = random.sample(all_cards, num_cards_to_select)

            deck_champions = [card for card in initial_deck if card.get('rarity', '').strip().lower() == 'champion']
            deck_non_champions = [card for card in initial_deck if card.get('rarity', '').strip().lower() != 'champion']

            final_deck_cards = []

            if len(deck_champions) > 1:
                chosen_champion = random.choice(deck_champions)
                final_deck_cards.append(chosen_champion)

                num_replacements_needed = num_cards_to_select - len(deck_non_champions) - 1

                all_non_champions_pool = [card for card in all_cards if card.get('rarity', '').strip().lower() != 'champion']
                available_non_champions_for_replacement = [
                    card for card in all_non_champions_pool
                    if card not in deck_non_champions and card != chosen_champion
                ]

                if len(available_non_champions_for_replacement) >= num_replacements_needed:
                    replacements = random.sample(available_non_champions_for_replacement, num_replacements_needed)
                else:
                    print(f"WARN: Not enough unique non-champion cards for full replacement. Using all available ({len(available_non_champions_for_replacement)}) to fill deck.")
                    replacements = available_non_champions_for_replacement

                final_deck_cards.extend(deck_non_champions)
                final_deck_cards.extend(replacements)

            else:
                final_deck_cards = initial_deck

        final_deck_cards = final_deck_cards[:num_cards_to_select]

        random.shuffle(final_deck_cards)

        cards_with_details = []
        for card in final_deck_cards:
            cards_with_details.append({
                "name": card.get('name', 'Unknown Card'),
                "rarity": card.get('rarity', 'Common'),
                "iconUrls": card.get('iconUrls', {})
            })

        return jsonify(cards_with_details)

    except requests.exceptions.HTTPError as http_err:
        print(f"API HTTP error: {http_err}. Status Code: {response.status_code}. Response: {response.text}")
        return jsonify({"error": f"API HTTP error: {http_err}. Status Code: {response.status_code}. Response: {response.text}"}), response.status_code
    except requests.exceptions.ConnectionError as conn_err:
        print(f"API connection error: {conn_err}")
        return jsonify({"error": f"API connection error: {conn_err}. Check network/API availability."}), 500
    except requests.exceptions.Timeout as timeout_err:
        print(f"API timeout error: {timeout_err}")
        return jsonify({"error": f"API timeout error: {timeout_err}."}), 500
    except requests.exceptions.RequestException as req_err:
        print(f"An unexpected request error occurred: {req_err}")
        return jsonify({"error": f"An unexpected request error occurred: {req_err}"}), 500
    except Exception as e:
        print(f"An unknown server error occurred: {e}")
        return jsonify({"error": f"An unknown server error occurred: {e}."}), 500

if __name__ == '__main__':
    app.run(host="0.0.0.0", port=5000, debug=True)

