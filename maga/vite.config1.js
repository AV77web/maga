import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";
import Inspect from "vite-plugin-inspect";
import { visualizer } from "rollup-plugin-visualizer";

export default defineConfig({
  base: "/maga/",
  plugins: [react(), Inspect(), visualizer()],
  css: {
    devSourcemap: true, // abilitato durante lo sviluppo
    sourcemap: true, // corretta ortografia
    preprocessorOptions: {
      scss: {
        sourceMap: true, // se usi SCSS
      },
    },
  },
  build: {
    outDir: "c:/wamp64/www/maga/", // OK
    emptyOutDir: false, // ✅ non cancellare
    sourcemap: true,
    cssCodeSplit: true,
    cssMinify: false,
    /*rollupOptions: {
      output: {
        manualChunks: {
          react: ["react", "react-dom"],
          aggrid: ["ag-grid-community", "ag-grid-react"],
        },
      },
    },*/
  },
});
