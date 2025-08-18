## AWS Clash Royale Deck Generator to AWS ECS with Terraform and GitHub Actions

## Overview 

The application runs in a Docker container hosted on Amazon ECS Fargate. The infrastructure is defined using Terraform and deployed through automated workflows in GitHub Actions. DNS is managed via Route 53, and HTTPS is enabled through ACM.
The web application generates a random 8-card deck each time the user presses "Get My Deck!" Each deck follows standard Clash Royale gameplay rules, such as not allowing more than one Champion card. The application uses the official Clash Royale API to ensure all generated decks are accurate and up-to-date with the current version of the game.


### Architecture Diagram:
<img width="1292" height="989" alt="image" src="https://github.com/user-attachments/assets/137342fe-d17a-4fcd-982b-62a75b7b7e21" />





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
### Running with Docker
1. Build the Docker Image
   ```bash
   docker build -t clash-royale-deck .
   ```
2. Run the Docker Container
   ```bash
    docker run \
      --name clash_royale_container \
      -p 5000:5000 \
      -e CLASH_ROYALE_API_KEY="your-api-key-here" \
      clash-royale-deck
   ```


 
   
## Key Components

### Docker
- A  `Dockerfile` in the directory that defines how the application is built into a container.   

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

## Directory Structure

   ```bash
├── README.md
├── app.py
├── dockerfile
├── requirements.txt
├── static
│   ├── script.js
│   └── style.css
├── templates
│   └── index.html
└── terraform
    ├── modules
    │   ├── acm/
    │   ├── alb/
    │   ├── ecr/
    │   ├── ecs/
    │   ├── iam/
    │   ├── route53/
    │   └── vpc/
    ├── main.tf
    ├── output.tf
    ├── providers.tf
    └── variables.tf
```
## Screnshots

### Domain Page

<img width="1919" height="1015" alt="image" src="https://github.com/user-attachments/assets/0453af62-2546-4e16-bada-1edcf91b164a" />

<img width="1919" height="1016" alt="image" src="https://github.com/user-attachments/assets/74df7d49-dff8-4878-a880-2854247cb9c2" />

### SSL Certificate

<img width="1918" height="1017" alt="image" src="https://github.com/user-attachments/assets/6a46c000-3419-417d-8474-2537d9682f37" />

### GitHub Actions CI/CD Pipeline

<img width="1919" height="872" alt="image" src="https://github.com/user-attachments/assets/0bfd1c01-0ab5-402f-8ddb-d2f57e881f77" />







  
Live at:
https://tm.romeoesty.com

















