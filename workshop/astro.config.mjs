import { defineConfig } from 'astro/config';
import path from 'node:path';
import url from 'node:url';

const __dirname = path.dirname(url.fileURLToPath(import.meta.url));

// https://astro.build/config
export default defineConfig({
  vite: {
    css: {
      preprocessorOptions: {
        scss: {
          loadPaths: [
            path.resolve(__dirname, 'src/styles')
          ]
        }
      }
    }
  }
});
