const localtunnel = require('localtunnel');

const PORT = parseInt(process.env.PORT, 10) || 3000;
const SUBDOMAIN = process.env.SUBDOMAIN || 'ksit-icb-portal';

async function startTunnel() {
  while (true) {
    try {
      console.log(`[Tunnel] Connecting on port ${PORT} with subdomain '${SUBDOMAIN}'...`);
      const tunnel = await localtunnel({ port: PORT, subdomain: SUBDOMAIN });
      console.log(`[Tunnel] LIVE PUBLIC URL: ${tunnel.url}`);

      await new Promise((resolve) => {
        tunnel.on('close', () => {
          console.log('[Tunnel] Connection closed. Auto-reconnecting in 3s...');
          resolve();
        });
        tunnel.on('error', (err) => {
          console.warn('[Tunnel] Event warning:', err.message);
          try { tunnel.close(); } catch (_) {}
          resolve();
        });
      });
    } catch (err) {
      console.error('[Tunnel] Error:', err.message);
    }
    await new Promise((r) => setTimeout(r, 3000));
  }
}

startTunnel();
