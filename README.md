## AWS Clash Royale Deck Generator to AWS ECS with Terraform and GitHub Actions

## Overview 

The application runs in a Docker container hosted on Amazon ECS Fargate. The infrastructure is defined using Terraform and deployed through automated workflows in GitHub Actions. DNS is managed via Route 53, and HTTPS is enabled through ACM.
The web application generates a random 8-card deck each time the user presses "Get My Deck!" Each deck follows standard Clash Royale gameplay rules, such as not allowing more than one Champion card. The application uses the official Clash Royale API to ensure all generated decks are accurate and up-to-date with the current version of the game.

##  Local Development

## Getting Started

### Prerequisites
- Python 3.8 or higher
- Docker (optional)
- AWS account (for deployment)
- Clash Royale API key from [RoyaleAPI](https://developer.clashroyale.com)

### Local Development Setup

1. Clone the repository
   ```bash
   git clone https://github.com/r-esty/Clash_Royale_ECS.git
   cd Clash_Royale_ECS
   ```
2. Set up Python environment
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate  
   ```
3. Install dependencies
   ```bash
   pip install -r requirements.txt
   ```
4. Set your API key
   ```bash
   export CLASH_ROYALE_API_KEY="your-api-key-here"
5. Run app
   ```bash
   python3 app.py
   ```
6. Open browser
   ```bash
   http://localhost:5000
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

Live at:
https://tm.romeoesty.com

















