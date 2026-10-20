# Personal Portfolio Website

**Type:** Personal project  
**Year:** 2026  
**Author:** Resham Furqan 

Beige and sage React portfolio that showcases selected work, certifications, and contact details. Built to be CV-ready: one public link that works on phone and desktop with no installs for visitors.

**Tech:** React · Vite · Framer Motion · CSS · GitHub Pages

**Live site:** https://resham81.github.io/Resham-Projects/

## Environment

- **OS:** Windows, macOS, or Linux
- **Node.js:** 20+ recommended (for local development only)
- **Package manager:** npm

Visitors do **not** need Node. The published site is static HTML/CSS/JS on GitHub Pages.

## Source location

App code lives in the repo at [`website/`](../../website/) (not inside this folder).  
This folder is the project entry + documentation, same pattern as other `projects/` items.

| Path | Purpose |
|------|---------|
| `website/` | React app source |
| `website/src/data/projects.js` | Profile, skills, projects, certifications |
| `website/src/App.jsx` | Page sections & interactions |
| `website/src/components/HeroVisual.jsx` | Hero botanical panel |
| `.github/workflows/deploy-pages.yml` | Auto-deploy to GitHub Pages |

## Run locally

From the repo root:

```powershell
cd website
npm install
npm run dev
```

Open the URL Vite prints (usually `http://localhost:5173/Resham-Projects/`).

### Production build (optional check)

```powershell
cd website
npm run build
npm run preview
```

## Deploy (public website link)

Hosting is free via **GitHub Pages**. Anyone with the link can open it — no GitHub login required.

1. One-time: repo **Settings → Pages → Source: GitHub Actions**
2. Push changes under `website/` (or the workflow file) to `main`
3. Check the **Actions** tab until “Deploy portfolio to GitHub Pages” is green
4. Share: **https://resham81.github.io/Resham-Projects/**

## What’s on the site

- **Hero** — name branding + botanical visual panel  
- **About** — short intro  
- **Work** — expandable projects with skill filters; links to GitHub / demos  
- **Certifications** — Zoho, Red Hat, Cisco CCNA, e& hackathon, AWS  
- **Contact** — email, phone, GitHub, LinkedIn  

## Edit content

| What | Where |
|------|--------|
| Contact details | `website/src/data/projects.js` → `PROFILE` |
| Certifications | `website/src/data/projects.js` → `CERTIFICATIONS` |
| Project cards | `website/src/data/projects.js` → `PROJECTS` |
| Skill filters | `website/src/data/projects.js` → `SKILLS` |
| Colours / layout | `website/src/index.css` |

## What’s included

- This README (project documentation)
- Live app source under `website/`
- GitHub Actions workflow for Pages deploy
