# AWS Clash Royale Deck Generator to AWS ECS with Terraform and Github Actions

This project deploys a containerised web based application to AWS using Terraform and Github Actions

## Overview 

The application runs in a Docker container hosted on ECS Fargate. Infrastructure is defined using Terraform and deployed through automated workflows in GitHub Actions. DNS is handled through Route 53 with HTTPS enabled via ACM.

###Local App Setup

```bash
git clone https://github.com/r-esty/Clash_Royale_ECS.git
cd Clash_Royale_ECS
python3 -m venv .venv
source .venv/bin/activate  # Or use .venv\Scripts\activate on Windows
pip install -r requirements.txt
CLASH_ROYALE_API_KEY="YOUR_API_KEY_HERE"
flask run
```






