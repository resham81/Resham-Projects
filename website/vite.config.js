import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// GitHub Pages: https://resham81.github.io/Resham-Projects/
export default defineConfig({
  plugins: [react()],
  base: '/Resham-Projects/',
})
