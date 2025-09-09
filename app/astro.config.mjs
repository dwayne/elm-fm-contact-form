import { defineConfig } from 'astro/config';
import elmPlugin from 'vite-plugin-elm';
import process from 'node:process';

const base = process.env.ASTRO_BASE || '/';

// https://astro.build/config
export default defineConfig({
  base,
  vite: {
    plugins: [
      elmPlugin({
        nodeElmCompilerOptions: {
          pathToElm: 'elm'
        }
      })
    ]
  }
});
