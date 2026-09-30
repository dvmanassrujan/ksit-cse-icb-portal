# KSIT CSE (ICB) Portal - Cloud Deployment Guide

This guide walks you through deploying your **KSIT CSE (ICB) Integrated Academic & Information Portal** permanently to the cloud for free with a 24/7 live HTTPS URL.

---

## Prerequisites Completed For You
Your repository is already pre-configured for instant zero-configuration deployment:
- [x] **Express Cloud Binding**: Configured to listen on `process.env.PORT` with `'0.0.0.0'` host binding.
- [x] **Dual Database Resilience**: Works immediately out-of-the-box using the built-in Relational Store (`database/seed.json` & `database/data_store.json`), and automatically switches to MySQL if cloud MySQL credentials (`DB_HOST`, `DB_USER`, `DB_PASSWORD`) are supplied.
- [x] **[.gitignore](file:///d:/community%20based%20folder/.gitignore)**: Configured to exclude `node_modules` and sensitive `.env` files.
- [x] **[render.yaml](file:///d:/community%20based%20folder/render.yaml)**: Pre-created blueprint for 1-click Render setup.
- [x] **[Procfile](file:///d:/community%20based%20folder/Procfile)**: Ready for Railway / Heroku.
- [x] **Git Repository**: Initialized with branch `main` and clean commit.

---

## Method 1: Deploy Free on Render (Recommended)

Render provides a completely free Web Service tier with automatic SSL/HTTPS and zero maintenance.

### Step 1: Create a GitHub Repository
1. Go to [github.com/new](https://github.com/new) and log in.
2. Enter repository name: `ksit-cse-icb-portal`
3. Set visibility to **Public** or **Private** (both work).
4. Do **not** initialize with README/license (we already have a complete repo).
5. Click **Create repository**.

### Step 2: Push Your Code to GitHub
Open your terminal in `d:\community based folder` and run (replace `<YOUR-GITHUB-USERNAME>`):
```bash
git remote add origin https://github.com/<YOUR-GITHUB-USERNAME>/ksit-cse-icb-portal.git
git push -u origin main
```

### Step 3: Deploy on Render
1. Visit [render.com](https://render.com) and click **Get Started for Free** (sign up with GitHub).
2. On your Render Dashboard, click **New +** -> **Web Service**.
3. Select **Build and deploy from a Git repository** -> click **Next**.
4. Choose your `ksit-cse-icb-portal` repository.
5. Render will automatically detect the settings:
   - **Name**: `ksit-cse-icb-portal`
   - **Environment**: `Node`
   - **Build Command**: `npm install`
   - **Start Command**: `npm start`
   - **Plan Type**: **Free**
6. Click **Deploy Web Service**.
7. In ~2 minutes, Render will build and launch your site with a permanent URL:
   `https://ksit-cse-icb-portal.onrender.com`

---

## Method 2: Deploy on Railway (Alternative)

1. Go to [railway.app](https://railway.app) and sign in with GitHub.
2. Click **New Project** -> **Deploy from GitHub repo**.
3. Select `ksit-cse-icb-portal`.
4. Railway will automatically detect the `Procfile` and `package.json` and deploy.
5. In **Settings** -> **Networking**, click **Generate Domain** to get your public URL.

---

## Quick Instant Link (Temporary Public Access)

If you need a live internet link right this minute (e.g. for a quick presentation or mobile testing without waiting for GitHub):
```bash
npx localtunnel --port 3000
```
This gives you a public URL (e.g. `https://xxxx.loca.lt`) pointing straight to your running local server.
