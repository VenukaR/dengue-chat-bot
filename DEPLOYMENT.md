# Deployment Guide for Dengue Bot API

## 🌟 Recommended Free Hosting Platforms

### 1. **Railway** (Easiest)
- **Free Credits:** $5/month
- **Steps:**
  1. Go to [railway.app](https://railway.app)
  2. Sign up with GitHub
  3. Click "New Project" → "Deploy from GitHub repo"
  4. Select your dengue bot repository
  5. Add environment variable: `GOOGLE_API_KEY=your_key`
  6. Railway auto-detects Dockerfile and deploys!

### 2. **Render** (Most Reliable)
- **Free Tier:** 750 hours/month
- **Steps:**
  1. Go to [render.com](https://render.com)
  2. Sign up and connect GitHub
  3. Click "New +" → "Web Service"
  4. Connect your repository
  5. Use these settings:
     - **Build Command:** `docker build -t dengue-bot .`
     - **Start Command:** `docker run -p $PORT:8000 dengue-bot`
     - **Environment:** Add `GOOGLE_API_KEY`

### 3. **Google Cloud Run** (Most Scalable)
- **Free Tier:** 2M requests/month
- **Steps:**
  1. Install [Google Cloud CLI](https://cloud.google.com/sdk/docs/install)
  2. Run: `gcloud auth login`
  3. Create project: `gcloud projects create your-project-id`
  4. Set project: `gcloud config set project your-project-id`
  5. Enable services: `gcloud services enable run.googleapis.com cloudbuild.googleapis.com`
  6. Run: `./deploy-gcp.sh`

### 4. **Fly.io** (Global Edge)
- **Free Tier:** 3 VMs, 3GB storage
- **Steps:**
  1. Install [flyctl](https://fly.io/docs/hands-on/install-flyctl/)
  2. Run: `fly auth signup`
  3. In your project: `fly launch`
  4. Set secrets: `fly secrets set GOOGLE_API_KEY=your_key`
  5. Deploy: `fly deploy`

## 🔧 Pre-deployment Checklist

- [ ] `.env` file with `GOOGLE_API_KEY`
- [ ] `den1.pdf` file in project root
- [ ] Docker working locally
- [ ] GitHub repository created
- [ ] Environment variables configured on platform

## 🌐 Platform Comparison

| Platform | Free Tier | Docker Support | Ease of Use | Uptime |
|----------|-----------|----------------|-------------|---------|
| Railway | $5/month credits | ✅ Excellent | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| Render | 750 hours | ✅ Good | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Google Cloud Run | 2M requests | ✅ Excellent | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Fly.io | 3 VMs | ✅ Excellent | ⭐⭐⭐ | ⭐⭐⭐⭐ |

## 🚨 Important Notes

1. **Environment Variables:** Always set `GOOGLE_API_KEY` as environment variable, never commit it to Git
2. **PDF File:** Ensure `den1.pdf` is included in your repository
3. **Port Configuration:** Most platforms provide `$PORT` environment variable
4. **Health Checks:** Use `/health` endpoint for platform health checks
5. **Scaling:** Your app processes embeddings on startup, so first request may be slow

## 🔒 Security Recommendations

- Use platform's secret management for API keys
- Enable HTTPS (most platforms do this automatically)
- Consider rate limiting for production use
- Monitor usage to stay within free tiers
