# AWS Clash Royale Deck Generator to AWS ECS with Terraform and Github Actions

This project deploys a containerised web based application to AWS using Terraform and Github Actions

## Overview 

The application runs in a Docker container hosted on ECS Fargate. Infrastructure is defined using Terraform and deployed through automated workflows in GitHub Actions. DNS is handled through Route 53 with HTTPS enabled via ACM.

##  Local Development

### Prerequisites
- Python 3.8+
- Docker (optional)
- Clash Royale API key

### Running Locally

1. Clone the repository:
```bash
git clone https://github.com/YOUR_USERNAME/Clash_Royale_ECS.git
cd Clash_Royale_ECS
```
2.Set up your environment:
```bash
python3 -m venv .venv
source .venv/bin/activate  # On Windows, use .venv\Scripts\activate
```
3. Install dependencies
```bash
pip install -r requirements.txt
```
4.Add your API key:
Create a file called .env in the project's root directory and add the following line, replacing YOUR_API_KEY_HERE with your actual key
```
CLASH_ROYALE_API_KEY="YOUR_API_KEY_HERE"
```
5.Run the application
```bash
python app.py
```
6.Visit http://localhost:5000

###Running with Docker
```bash
docker build -t clash-royale-deck .
docker run -p 5000:5000 -e CLASH_ROYALE_API_KEY="your-api-key" clash-royale-deck
```

















