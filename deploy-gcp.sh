#!/bin/bash

# Google Cloud Run Deployment Script for Dengue Bot

echo "🚀 Deploying Dengue Bot to Google Cloud Run..."

# Set your project variables
PROJECT_ID="your-project-id"  # Replace with your Google Cloud Project ID
SERVICE_NAME="dengue-bot-api"
REGION="us-central1"

echo "📋 Prerequisites:"
echo "1. Install Google Cloud CLI: https://cloud.google.com/sdk/docs/install"
echo "2. Run: gcloud auth login"
echo "3. Run: gcloud config set project $PROJECT_ID"
echo "4. Enable Cloud Run API: gcloud services enable run.googleapis.com"
echo ""

read -p "Have you completed the prerequisites? (y/n): " confirm
if [ "$confirm" != "y" ]; then
    echo "Please complete prerequisites first."
    exit 1
fi

# Build and tag the image for Google Cloud
echo "🔨 Building Docker image..."
docker build -t gcr.io/$PROJECT_ID/$SERVICE_NAME .

# Push to Google Container Registry
echo "📤 Pushing to Google Container Registry..."
docker push gcr.io/$PROJECT_ID/$SERVICE_NAME

# Deploy to Cloud Run
echo "🌐 Deploying to Cloud Run..."
gcloud run deploy $SERVICE_NAME \
    --image gcr.io/$PROJECT_ID/$SERVICE_NAME \
    --platform managed \
    --region $REGION \
    --allow-unauthenticated \
    --set-env-vars GOOGLE_API_KEY=$GOOGLE_API_KEY \
    --port 8000 \
    --memory 1Gi \
    --cpu 1

echo "✅ Deployment complete!"
echo "🌐 Your API is now live at the URL shown above"
