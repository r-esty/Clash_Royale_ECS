const generateButton = document.getElementById('generateButton');
const loadingIndicator = document.getElementById('loadingIndicator');
const errorDisplay = document.getElementById('errorDisplay');
const cardList = document.getElementById('cardList');
const cardsDisplayContainer = document.getElementById('cardsDisplay');

function getRarityClass(rarity) {
    switch (rarity.toLowerCase()) {
        case 'common': return 'common-border';
        case 'rare': return 'rare-border';
        case 'epic': return 'epic-border';
        case 'legendary': return 'legendary-border';
        case 'champion': return 'champion-border';
        default: return 'common-border';
    }
}

generateButton.addEventListener('click', async () => {
    cardList.innerHTML = '';
    errorDisplay.classList.add('hidden');
    loadingIndicator.classList.remove('hidden');
    generateButton.disabled = true;
    
    cardsDisplayContainer.classList.remove('is-visible'); 

    try {
        const response = await fetch('/api/random_cards');
        const data = await response.json();

        if (response.ok) { 
            loadingIndicator.classList.add('hidden');
            cardsDisplayContainer.classList.add('is-visible'); 

            if (Array.isArray(data) && data.length > 0) {
                data.forEach(card => { 
                    const cardFrame = document.createElement('div');
                    cardFrame.className = `card-frame ${getRarityClass(card.rarity)}`; 
                    
                    const cardContent = document.createElement('div');
                    cardContent.className = 'card-content';
                    cardContent.innerHTML = `<span class="card-name">${card.name}</span>`; 

                    cardFrame.appendChild(cardContent);
                    cardList.appendChild(cardFrame);
                });
            } else {
                cardList.innerHTML = '<div class="text-red-300 col-span-full">Couldn\'t generate cards. The API might be empty or in an odd format.</div>';
            }
        } else {
            loadingIndicator.classList.add('hidden');
            errorDisplay.textContent = data.error || 'Something went wrong fetching cards from the server.';
            errorDisplay.classList.remove('hidden');
            cardList.innerHTML = '<div class="text-red-300 col-span-full">Deck generation failed. Please try again.</div>'; 
        }
    } catch (error) {
        loadingIndicator.classList.add('hidden');
        errorDisplay.textContent = 'Network problem. Can\'t connect to the app. Is the server running?';
        errorDisplay.classList.remove('hidden');
        cardList.innerHTML = '<div class="text-red-300 col-span-full">Failed to load cards due to a connection issue.</div>';
        console.error('Fetch error:', error);
    } finally {
        generateButton.disabled = false;
    }
});