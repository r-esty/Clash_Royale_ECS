# AWS Clash Royale Deck Generator to AWS ECS with Terraform and Github Actions

This project deploys a containerised web based application to AWS using Terraform and Github Actions.The web based applciwyion creates the user random decks each time they press "Get My Deck!" each random deck will contain a mixture of 8 cards following the clash royale standsrd gamemode rule etc you cant have more than one champions in a deck.I used clash royale api which to give me up to date information so that the decks are as accurate to the current version of yhr game

## Overview 

The application runs in a Docker container hosted on Amazon ECS Fargate. The infrastructure is defined using Terraform and deployed through automated workflows in GitHub Actions. DNS is managed via Route 53, and HTTPS is enabled through ACM.
The web application generates a random 8-card deck each time the user presses "Get My Deck!" Each deck follows standard Clash Royale gameplay rules, such as not allowing more than one Champion card. The application uses the official Clash Royale API to ensure all generated decks are accurate and up-to-date with the current version of the game.
API Key
This project uses the official Clash Royale API. You can get a free API key by registering https://developer.clashroyale.com/#/login

##  Local Development

### Prerequisites
- Python 3.8+
- Docker (optional)
- Clash Royale API key

### Running Locally

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/r-esty/Clash_Royale_ECS.git](https://github.com/YOUR_USERNAME/Clash_Royale_ECS.git)
    cd Clash_Royale_ECS
    ```

2.  **Set up your environment:**
    ```bash
    python3 -m venv .venv
    source .venv/bin/activate  
    ```

3.  **Install dependencies:**
    ```bash
    pip install -r requirements.txt
    ```

4.  **Run the application with your API key which you can get on https://developer.clashroyale.com/#/login :**
    ```bash
    export CLASH_ROYALE_API_KEY="your-api-key" && python app.py
    ```
    Replace `"your-api-key"` with your actual key.

5.  **Visit the application:**
    Visit `http://localhost:5000` in your web browser.

Running with Docker
```bash
docker build -t clash-royale-deck .
docker run -p 5000:5000 -e CLASH_ROYALE_API_KEY="your-api-key" clash-royale-deck
```
### Terraform
- **ECS Fargate** for serverless container hosting
- **Application Load Balancer** for HTTPS traffic distribution  
- **VPC** with public/private subnets and NAT gateways
- **Route 53** for DNS management (tm.romeoesty.com)
- **ACM** certificate for SSL/TLS
- **Security Groups** restricting traffic between components
- **Secrets Manager** for API key storage
- **ECR** for Docker image repository

### CI/CD (GitHub Actions)
- Builds Docker image on push to main
- Pushes image to Amazon ECR
- Updates ECS service for automatic deployment
- Zero-downtime rolling updates

















