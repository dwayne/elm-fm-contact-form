import { defineConfig } from 'astro/config';
import path from 'node:path';
import process from 'node:process';
import url from 'node:url';

const __dirname = path.dirname(url.fileURLToPath(import.meta.url));
const base = process.env.ASTRO_BASE || '/';
const styleMode = process.env.STYLE_MODE || 'workshop'; // 'workshop' | 'app'

// https://astro.build/config
export default defineConfig({
  base,
  vite: {
    css: {
      preprocessorOptions: {
        scss: {
          additionalData: `$base: "${base}"; $mode: "${styleMode}";`,
          loadPaths: [
            path.resolve(__dirname, 'src/styles')
          ]
        }
      }
    }
  }
});
